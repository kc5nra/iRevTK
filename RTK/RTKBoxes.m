//
//  RTKBoxes.m
//  RevTK
//
//  Created by John Bradley on 4/1/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

// RevTK Specific Imports
#import "RTKBoxes.h"
#import "RTKSimpleBox.h"
#import "RTKUtils.h"

@implementation RTKBoxes

#pragma mark -
#pragma mark RTKResponseObject Methods

- (void)parseResponse: (id) responseObject {
	
	NSDictionary *_rawBoxes = (NSDictionary *)responseObject;
	
	// initialize a place for storing our box objects
	NSMutableArray *_boxes = [[NSMutableArray alloc] init];
	
	// loop through the keys in the response dictionary
	for(NSString *aKey in _rawBoxes){
		// special cased 'untestedCount' key is the amount of added but unreviewed cards
		if ([aKey isEqualToString: @"untestedCount"]) {
			[self setUntestedCount: [RTKUtils getJsonIntegerFromDictionary:_rawBoxes withKey:@"untestedCount"]];
		} else {
			// initialize the child boxes from the value of the key
			// keys are usually "1", "2", .. and the value is another dictionary
			[_boxes addObject: [[RTKSimpleBox alloc] initFromResponseFragment: [_rawBoxes valueForKey: aKey] withParent:self]];
		}		
	}
	
	// sort ascending
	NSSortDescriptor *idSorter = [[NSSortDescriptor alloc] initWithKey:@"boxId" ascending:YES];
	[_boxes sortUsingDescriptors: [NSArray arrayWithObject: idSorter]];
	
	[self setBoxes: _boxes];
	[_boxes release];
}

#pragma mark -
#pragma mark NSObject Methods

- (NSString *)description {
	NSMutableString *description = [[NSMutableString alloc] init];
	[description appendString: @"\nRTKBoxes { "];
	for (RTKSimpleBox *simpleBox in boxes) {
		[description appendString: @"\n\t"];
		[description appendString: [simpleBox description]];
	}
	[description appendString: @"\n}"];
	
	return description;
}

- (void)dealloc
{
	[boxes release];
	[super dealloc];
}

#pragma mark -
#pragma mark Synthesized Properties

@synthesize boxes;
@synthesize untestedCount;

@end
