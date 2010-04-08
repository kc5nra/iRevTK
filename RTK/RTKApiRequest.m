//
//  RTKApiRequest.m
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

// Third Party Imports
#import "JSON.h"

// RevTK Specific Imports
#import "RTK.h"
#import "RTKApiRequest.h"
#import "RTKApiError.h"
#import "RTKResponseObject.h"

NSString* const kRTKApiRequestURL			= @"192.168.0.195:8080";
NSString* const kRTKApiRequestApiKeyHeader	= @"revtk-api-key";

static NSString *sharedApiKey = nil;

/*
 Private methods that should only be called by subclasses of this class.
 */
@interface RTKApiRequest (Private)

/**
 Builds the request headers for a request before it is executed.  Usually this step
 only involved adding the revtk-api-key header used in requests requiring authentication.
 */
- (void)buildRequestHeaders;

/**
 A callback for when the request has finished and executes any required actions
 before saving away the JSON response and creating the response object.
 */
- (void)requestFinished;

/**
 Creates an instance of the correct subclass and returns
 a retained pointer.  You must release this when you are
 finished.
 @returns an instance of the ResponseObject
 */
- (id) createResponseObjectInstance;

@end

#pragma mark -

@implementation RTKApiRequest

#pragma mark -
#pragma mark Public methods

- (id)initWithURL:(NSURL *)newURL
{
	self = [super initWithURL:newURL];
	[self setPersistentConnectionTimeoutSeconds:20];
	return self;
}

#pragma mark -
#pragma mark Private methods

- (void)buildRequestHeaders
{
	[super buildRequestHeaders];

	if ([RTKApiRequest apiKey]) {
		[self addRequestHeader:kRTKApiRequestApiKeyHeader value:[RTKApiRequest apiKey]];
	}	
}

- (void)requestFinished
{
	SBJSON *jsonParser = [SBJSON new];
	
	// [self responseString] does NOT retain the pointer, no need to free
	NSString *responseString = [self responseString];
	
	// dictionary is freed with jsonParser
	NSDictionary *responseDictionary = [jsonParser objectWithString:responseString error: NULL];
	
	// create the response instance 
	RTKResponseObject *responseObject = [self createResponseObjectInstance];
	
	// initialize response object data from the response json
	[responseObject initWithResponseDictionary: responseDictionary];

	[self setObject: responseObject];
	
	[responseObject release];
	[jsonParser release];
	
	[super requestFinished];
}

- (id) createResponseObjectInstance 
{
	RTKLog(@"This class is not meant to be used directly, please overload this method.");
	[self doesNotRecognizeSelector: _cmd];
	return nil;
}

#pragma mark -
#pragma mark NSObject Methods

- (void)dealloc
{
	[error release];
	[super dealloc];
}


#pragma mark -
#pragma mark Static Methods

+ (NSString *)apiKey {
	return sharedApiKey;
}

+ (void)setApiKey:(NSString *)newApiKey {
	[sharedApiKey release];
	sharedApiKey = newApiKey;
	[sharedApiKey retain];
}

#pragma mark -
#pragma mark Synthesized Properties

@synthesize object;

@end
