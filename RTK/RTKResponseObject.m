//
//  RTKResponseObject.m
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKResponseObject.h"
#import "RTK.h"
#import "RTKUtils.h"
#import "RTKApiError.h"
#import "RTKApiRequest.h"



@interface RTKResponseObject ()

#pragma mark Private Methods

+ (BOOL)dictionaryContainsErrorResponse:(NSDictionary *)dictionary;
+ (id)getErrorResponseFromDictionary:(NSDictionary *)dictionary;

+ (BOOL)dictionaryContainsResponse:(NSDictionary *)dictionary;
+ (id)getResponseFromDictionary:(NSDictionary *)dictionary;

@end

@implementation RTKResponseObject

- (id)initWithResponseDictionary:(NSDictionary *)dictionary {
	[super init];
	// we have something
	if ([dictionary count] > 0) {
		if ([RTKResponseObject dictionaryContainsErrorResponse: dictionary]) 
		{
			[self setError: [RTKResponseObject getErrorResponseFromDictionary: dictionary]];
		} else 
		{
			[self parseResponse: [RTKResponseObject getResponseFromDictionary: dictionary]];
		}
	}
	return self;
}

- (id)initFromResponseFragment:(id)fragment withParent:(id) objectParent {
	[super init];
	
	[self setParent: objectParent];
	[self parseResponse: fragment];
	[self setIsFragment: YES];
	
	return self;
}

- (void)parseResponse: (id)responseObject;
{
	RTKLog(@"This class is not meant to be used directly, please overload this method.");
	[self doesNotRecognizeSelector: _cmd];
}

- (void)dealloc
{
	[error release];
	[parent release];
	[super dealloc];
}

#pragma mark Static Methods

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


@synthesize error;
@synthesize isFragment;
@synthesize parent;

@end
