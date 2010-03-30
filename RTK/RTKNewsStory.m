//
//  RTKNewsStory.m
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTK.h"
#import "RTKApiRequest.h"
#import "RTKNewsStory.h"


@implementation RTKNewsStory

@synthesize newsId;
@synthesize subject;
@synthesize text;
@synthesize date;
@synthesize brief;

- (void)parseResponse: (id)responseObject
{
	NSDictionary *story = (NSDictionary *)responseObject;
	
	[self setNewsId: [RTKApiRequest getJsonIntegerFromDictionary: story withKey:@"id"]];
	[self setSubject: [story valueForKey:@"subject"]];
	[self setText: [story valueForKey: @"text"]];
	[self setDate: [story valueForKey: @"date"]];
	[self setBrief: [RTKApiRequest getJsonBooleanFromDictionary: story withKey:@"brief"]];
}

- (NSString *)description {
	return [NSString stringWithFormat: @"RTKNewsStory { id=%d, subject='%@', text='...', date='%@', brief=%@", newsId, subject, date, RTKBoolStr(brief)];
}

- (void)dealloc
{
	[subject release];
	[text release];
	[date release];
	[super dealloc];
}

@end
