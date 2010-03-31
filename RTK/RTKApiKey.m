//
//  RTKApiKey.m
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKApiKey.h"


@implementation RTKApiKey

@synthesize apiKey;

- (void)parseResponse: (id) responseObject {
	[self setApiKey: (NSString *)responseObject];
}

- (NSString *)description {
	return [NSString stringWithFormat: @"RTKApiKey { apiKey='%@' }", apiKey];
}

- (void)dealloc
{
	[apiKey release];
	
	[super dealloc];
}

@end
