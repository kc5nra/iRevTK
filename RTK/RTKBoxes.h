//
//  RTKApiKey.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// RevTK Specific Imports
#import "RTKResponseObject.h"

/**
 Boxes Response Object.
 This object contains information retrieved from a Api Boxes Request.
 */
@interface RTKBoxes : RTKResponseObject {
	/**
	 An array of boxes.
	 */
	NSArray *boxes;
	/**
	 The amount of cards that have been added to a users deck but have zero reviews.
	 */
	int untestedCount;
}

@property (nonatomic, retain)	NSArray *boxes;
@property						int		untestedCount;
@end
