//
//  RTKNewsStories.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// RevTK Specific Imports
#import "RTKResponseObject.h"

/**
 News Response Object.
 This object contains information retrieved from a Api News Request.
 */
@interface RTKNewsStories : RTKResponseObject {
	/**
	 An array of news stories.
	 */
	NSArray *newsStories;
}

@property (nonatomic, retain) NSArray *newsStories;

@end
