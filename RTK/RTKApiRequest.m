//
//  RTKApiRequest.m
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "JSON.h"
#import "RTK.h"
#import "RTKApiRequest.h"
#import "RTKApiError.h"
#import "RTKResponseObject.h"

NSString* const kRTKApiRequestURL			= @"127.0.0.1:8080";
NSString* const kRTKApiRequestApiKeyHeader	= @"revtk-api-key";

static NSString *sharedApiKey = nil;


@implementation RTKApiRequest

@synthesize object;

- (id)initWithURL:(NSURL *)newURL
{
	self = [super initWithURL:newURL];
	[self setPersistentConnectionTimeoutSeconds:20];
	return self;
}


- (void)dealloc
{
	[error release];
	[super dealloc];
}

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
	
	NSDictionary *responseDictionary = [jsonParser objectWithString:[self responseString] error: NULL];
	
	RTKResponseObject *responseObject = [self createResponseObjectInstance];
	
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

#pragma mark Static Methods

+ (NSString *)apiKey {
	return sharedApiKey;
}

+ (void)setApiKey:(NSString *)newApiKey {
	[sharedApiKey release];
	sharedApiKey = newApiKey;
	[sharedApiKey retain];
}

+ (int) getJsonIntegerFromDictionary:(NSDictionary*)dictionary withKey:(NSString*)key
{
	NSNumber* _int = [dictionary valueForKey:key];
	return [_int integerValue];
}

+ (BOOL) getJsonBooleanFromDictionary:(NSDictionary*)dictionary withKey:(NSString*)key
{
	NSNumber* _int = [dictionary valueForKey:key];
	return ([_int integerValue] == 1) ? TRUE : FALSE;
}

@end
