//
//  RTKStories.m
//  RevTK
//
//  Created by ジョン ブラッドリー on 4/13/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

// RevTK Specific Imports
#import "RTKStories.h"
#import "RTKStory.h"

@implementation RTKStories

#pragma mark -
#pragma mark RTKResponseObject Methods

- (void)parseResponse: (id) responseObject {
	
	NSArray *_rawStories = (NSArray *)responseObject;
	
	// initialize a place for storing our story objects
	NSMutableArray *_stories = [[NSMutableArray alloc] init];
	
	// loop through the keys in the response dictionary
	for(NSDictionary *story in _rawStories){
        // initialize the child stories from the value of the key
        // keys are usually "0","1", "2", .. and the value is another dictionary
        [_stories addObject: [[RTKStory alloc] initFromResponseFragment: story withParent:self]];
	}
	
	[self setStories: _stories];
	[_stories release];
}

#pragma mark -
#pragma mark NSObject Methods

- (NSString *)description {
	NSMutableString *description = [[NSMutableString alloc] init];
	[description appendString: @"\nRTKStories { "];
	for (RTKStory *story in stories) {
		[description appendString: @"\n\t"];
		[description appendString: [story description]];
	}
	[description appendString: @"\n}"];
	
	return description;
}

- (void)dealloc
{
	[stories release];
	[super dealloc];
}

#pragma mark -
#pragma mark Synthesized Properties

@synthesize stories;

@end
