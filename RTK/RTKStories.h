//
//  RTKStories.h
//  RevTK
//
//  Created by ジョン ブラッドリー on 4/13/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// RevTK Specific Imports
#import "RTKResponseObject.h"

/**
 Stories Response Object.
 This object contains information retrieved from a Api Stories Request.
 */
@interface RTKStories : RTKResponseObject {
    /**
	 An array of stories.
	 */
	NSArray *stories;
}

@property (nonatomic, retain)	NSArray *stories;

@end
