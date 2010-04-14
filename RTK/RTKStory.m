//
//  RTKStory.m
//  RevTK
//
//  Created by ジョン ブラッドリー on 4/13/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

// RevTK Specific Imports
#import "RTKStory.h"
#import "RTKUtils.h"

@implementation RTKStory

#pragma mark -
#pragma mark RTKResponseObject Methods

- (void)parseResponse: (id)responseObject
{
	NSDictionary *story = (NSDictionary *)responseObject;
	
	[self setUserId:		[RTKUtils getJsonIntegerFromDictionary: story withKey:@"userId"]];
	[self setUserName:      [story objectForKey:@"userName"]];
	[self setHeisigNumber:	[RTKUtils getJsonIntegerFromDictionary: story withKey:@"heisigNumber"]];
    [self setLastModified:  [story objectForKey:@"lastModified"]];
    [self setText:          [story objectForKey:@"text"]];
    [self setStars:         [RTKUtils getJsonIntegerFromDictionary: story withKey:@"stars"]];
	[self setKicks:         [RTKUtils getJsonIntegerFromDictionary: story withKey:@"kicks"]];
}

#pragma mark -
#pragma mark NSObject Methods

- (NSString *)description {
	return [NSString stringWithFormat: @"RTKStory { userId=%d, userName='%@', heisigNumber='%d', lastModified='%@', text='...', stars='%d', kicks='%d' }",
            userId, userName, heisigNumber, lastModified, stars, kicks, nil];
}

- (void)dealloc
{
	[super dealloc];
}

#pragma mark -
#pragma mark Synthesized Properties

@synthesize userId;
@synthesize userName;
@synthesize heisigNumber;
@synthesize lastModified;
@synthesize text;
@synthesize stars;
@synthesize kicks;

@end
