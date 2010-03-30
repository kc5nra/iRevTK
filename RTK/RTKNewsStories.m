//
//  RTKNewsStories.m
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKNewsStories.h"
#import "RTKNewsStory.h"


@implementation RTKNewsStories

@synthesize newsStories;

- (void)parseResponse: (id) responseObject {
	
	NSArray* _rawNewsStories = (NSArray *)responseObject;
	
	NSMutableArray *_newsStories = [[NSMutableArray alloc] initWithCapacity: [_rawNewsStories count]];
	
	for(NSDictionary* newsStory in _rawNewsStories) {
		[_newsStories addObject: [[RTKNewsStory alloc] initFromResponseFragment:newsStory withParent:self]];
	}
	
	[self setNewsStories: _newsStories];
	[_newsStories release];
}

- (void)dealloc
{
	[newsStories release];
	
	[super dealloc];
}

@end
