//
//  RTKSimpleBox.m
//  RevTK
//
//  Created by John Bradley on 4/1/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

// RevTK Specific Imports
#import "RTKSimpleBox.h"
#import "RTKUtils.h"

@implementation RTKSimpleBox

#pragma mark -
#pragma mark RTKResponseObject Methods

- (void)parseResponse: (id)responseObject
{
	NSDictionary *story = (NSDictionary *)responseObject;
	
	[self setBoxId:			[RTKUtils getJsonIntegerFromDictionary: story withKey:@"id"]];
	[self setExpiredCards:	[RTKUtils getJsonIntegerFromDictionary: story withKey:@"expiredCards"]];
	[self setFreshCards:	[RTKUtils getJsonIntegerFromDictionary: story withKey:@"freshCards"]];
	[self setTotalCards:	[RTKUtils getJsonIntegerFromDictionary: story withKey:@"totalCards"]];
}

#pragma mark -
#pragma mark NSObject Methods

- (NSString *)description {
	return [NSString stringWithFormat: @"RTKSimpleBox { id=%d, expiredCards='%d', freshCards='%d', totalCards='%d' }", boxId, expiredCards, freshCards, totalCards];
}

- (void)dealloc
{
	[super dealloc];
}

#pragma mark -
#pragma mark Synthesized Properties

@synthesize boxId;
@synthesize expiredCards;
@synthesize freshCards;
@synthesize totalCards;

@end
