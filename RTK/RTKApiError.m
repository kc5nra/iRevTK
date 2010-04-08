//
//  RTKApiError.m
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

// RevTK Specific Imports
#import "RTKApiError.h"


@implementation RTKApiError

#pragma mark -
#pragma mark NSObject Methods

- (void)dealloc {
	[message release];
	
	[super dealloc];
}

- (NSString *)description {
	return [NSString stringWithFormat: @"RTKApiError { message='%@' statusCode=%de }", message, statusCode];
}

#pragma mark -
#pragma mark Synthesized Properties

@synthesize message;
@synthesize statusCode;

@end
