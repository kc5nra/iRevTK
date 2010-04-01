//
//  RTKBoxes.m
//  RevTK
//
//  Created by John Bradley on 4/1/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKBoxes.h"
#import "RTKSimpleBox.h"
#import "RTKUtils.h"

@implementation RTKBoxes

@synthesize boxes;
@synthesize untestedCount;

- (void)parseResponse: (id) responseObject {
	
	NSDictionary *_rawBoxes = (NSDictionary *)responseObject;
	
	NSMutableArray *_boxes = [[NSMutableArray alloc] init];
	
	for(NSString *aKey in _rawBoxes){
		if ([aKey isEqualToString: @"untestedCount"]) {
			[self setUntestedCount: [RTKUtils getJsonIntegerFromDictionary:_rawBoxes withKey:@"untestedCount"]];
		} else {
			[_boxes addObject: [[RTKSimpleBox alloc] initFromResponseFragment: [_rawBoxes valueForKey: aKey] withParent:self]];
		}		
	}
	
	[self setBoxes: _boxes];
	[_boxes release];
}

- (void)dealloc
{
	[boxes release];
	
	[super dealloc];
}

@end
