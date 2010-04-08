//
//  RTKSimpleBox.h
//  RevTK
//
//  Created by John Bradley on 4/1/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// RevTK Specific Imports
#import "RTKResponseObject.h"

/**
 SimpleBox Response Object.
 This object will always? be a fragment child of a Boxes response.
 It contains a reduced information set regarding the contents of a
 particular box.
 */
@interface RTKSimpleBox : RTKResponseObject {
	/**
	 The id of the box
	 */
	int	boxId;
	/**
	 The current amount of expired cards in this box.
	 */
	int	expiredCards;
	/**
	 The current amount of fresh cards in this box (reviewed and not yet expired)
	 */
	int	freshCards;
	/**
	 The total amount of expired and fresh cards in this box.
	 */
	int	totalCards;
}

@property	int	boxId;
@property	int	expiredCards;
@property	int	freshCards;
@property	int	totalCards;

@end
