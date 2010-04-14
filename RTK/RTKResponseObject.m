//
//  RTKResponseObject.m
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

// RevTK Specific Imports
#import "RTKResponseObject.h"
#import "RTK.h"
#import "RTKUtils.h"
#import "RTKApiError.h"
#import "RTKApiRequest.h"

/*
 Private methods that should only be called by subclasses of this class.
 */
@interface RTKResponseObject ()

/**
 Parses the response and populates the properties specific to the Response Object
 that was instantiated.
 @param responseObject
 */
- (void)parseResponse: (id) responseObject;

/**
 Evaluates the response for whether it has an error descriptor in it's payload.
 This should only be called by Response Object's that can possible contain this 
 payload and not by fragments.
 @param dictionary the JSON Parser's output dictionary.
 @returns true if the payload contains an error; false if it does not.
 */
+ (BOOL)dictionaryContainsErrorResponse:(NSDictionary *)dictionary;

/**
 Gets the Api Error object from a JSON Parser's output.  The actual
 presence of a error in the payload should be checked before this method
 is called.  The resulting object is not kept track of and must be released
 appropriately by whoever calls this method.
 @param dictionary the JSON Parser's output dictionary.
 @returns an Api Error object
 */
+ (id)getErrorResponseFromDictionary:(NSDictionary *)dictionary;

/**
 Evaluates the response for whether it has an response descriptor in it's payload.
 This should only be called by Response Object's that can possible contain this 
 payload and not by fragments.
 @param dictionary the JSON Parser's output dictionary.
 @returns true if the payload contains a response; false if it does not.
 */
+ (BOOL)dictionaryContainsResponse:(NSDictionary *)dictionary;

/**
 Gets the Api Response object from a JSON Parser's output.  The actual
 presence of a response in the payload should be checked before this method
 is called.  The resulting object is not kept track of and must be released
 appropriately by whoever calls this method.
 @param dictionary the JSON Parser's output dictionary.
 @returns the value of the of `response` key in the JSON Parser's output dictionary.
 */
+ (id)getResponseFromDictionary:(NSDictionary *)dictionary;

@end

@implementation RTKResponseObject

#pragma mark -
#pragma mark Public Methods

- (id)initWithResponseDictionary:(NSDictionary *)dictionary {
	[super init];
	if ([dictionary count] > 0) {
		if ([RTKResponseObject dictionaryContainsErrorResponse: dictionary]) 
		{
			[self setError: [RTKResponseObject getErrorResponseFromDictionary: dictionary]];
            RTKLogO(@"%@", error);
            
		} else 
		{
			// our assumption is that if there is NOT an error in the response then it
			// must contain a 'response' key.
			[self parseResponse: [RTKResponseObject getResponseFromDictionary: dictionary]];
		}
	}
	return self;
}

- (id)initFromResponseFragment:(id)fragment withParent:(id) objectParent {
	[super init];
	
	// this is a fragment so set the parent and isFragment properties
	[self setParent: objectParent];
	[self setIsFragment: YES];
	[self parseResponse: fragment];
	
	return self;
}

#pragma mark -
#pragma mark Private Methods

- (void)parseResponse: (id)responseObject;
{
	// this should never be called
	RTKLog(@"This class is not meant to be used directly, please overload this method.");
	[self doesNotRecognizeSelector: _cmd];
}

#pragma mark -
#pragma mark NSObject Methods

- (void)dealloc
{
	[error release];
	[parent release];
	[super dealloc];
}

#pragma mark -
#pragma mark Private Static Methods

+ (BOOL)dictionaryContainsErrorResponse:(NSDictionary *)dictionary
{
	NSDictionary *errorDictionary = [dictionary valueForKey: @"error"];
	
	return (errorDictionary) ? YES : NO;
}

+ (id)getErrorResponseFromDictionary:(NSDictionary *)dictionary
{
	RTKApiError *apiError = [[RTKApiError alloc] init];
	
	NSDictionary *errorDictionary = [dictionary valueForKey: @"error"];
	
	// api error structure
	// { error: { :message, :statusCode } }
	[apiError setMessage: [errorDictionary valueForKey: @"message"]];
	[apiError setStatusCode: [RTKUtils getJsonIntegerFromDictionary:errorDictionary withKey:@"statusCode"]];
	
	return apiError;
}

+ (BOOL)dictionaryContainsResponse:(NSDictionary *)dictionary
{
	id responseObject = [dictionary valueForKey: @"response"];
	
	return (responseObject) ? YES : NO;
}

+ (id)getResponseFromDictionary:(NSDictionary *)dictionary
{	
	id responseObject = [dictionary valueForKey: @"response"];
	
	return responseObject;
}

#pragma mark -
#pragma mark Synthesized Properties

@synthesize error;
@synthesize isFragment;
@synthesize parent;

@end
