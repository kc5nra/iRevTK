//
//  RTKApiKey.m
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKApiKey.h"


@implementation RTKApiKey

#pragma mark -
#pragma mark RTKResponseObject Methods

- (void)parseResponse: (id) responseObject {
	[self setApiKey: (NSString *)responseObject];
}

#pragma mark -
#pragma mark NSObject Methods

- (NSString *)description {
	return [NSString stringWithFormat: @"RTKApiKey { apiKey='%@' }", apiKey];
}

- (void)dealloc
{
	[apiKey release];
	
	[super dealloc];
}

#pragma mark -
#pragma mark Synthesized Properties

@synthesize apiKey;

@end
