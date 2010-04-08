//
//  RTKNewsStory.m
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

// RevTK Specific Imports
#import "RTK.h"
#import "RTKUtils.h"
#import "RTKNewsStory.h"


@implementation RTKNewsStory

#pragma mark -
#pragma mark RTKResponseObject Methods

- (void)parseResponse: (id)responseObject
{
	NSDictionary *story = (NSDictionary *)responseObject;
	
	[self setNewsId: [RTKUtils getJsonIntegerFromDictionary: story withKey:@"id"]];
	[self setSubject: [story valueForKey:@"subject"]];
	[self setText: [story valueForKey: @"text"]];
	[self setDate: [story valueForKey: @"date"]];
	[self setBrief: [RTKUtils getJsonBooleanFromDictionary: story withKey:@"brief"]];
}

#pragma mark -
#pragma mark NSObject Methods

- (NSString *)description {
	return [NSString stringWithFormat: @"RTKNewsStory { id=%d, subject='%@', text='...', date='%@', brief=%@ }", newsId, subject, date, RTKBoolStr(brief)];
}

- (void)dealloc
{
	[subject release];
	[text release];
	[date release];
	[super dealloc];
}

#pragma mark -
#pragma mark Synthesized Properties

@synthesize newsId;
@synthesize subject;
@synthesize text;
@synthesize date;
@synthesize brief;

@end
