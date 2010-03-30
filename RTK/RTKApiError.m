//
//  RTKApiError.m
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKApiError.h"


@implementation RTKApiError

@synthesize message;
@synthesize statusCode;

- (void)dealloc {
	[message release];
	
	[super dealloc];
}

- (NSString *)description {
	return [NSString stringWithFormat: @"RTKApiError { message='%@' statusCode=%de }", message, statusCode];
}

@end
