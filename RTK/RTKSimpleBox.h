//
//  RTKSimpleBox.h
//  RevTK
//
//  Created by John Bradley on 4/1/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTKResponseObject.h"

@interface RTKSimpleBox : RTKResponseObject {
	int	boxId;
	int	expiredCards;
	int	freshCards;
	int	totalCards;
}

@property	int	boxId;
@property	int	expiredCards;
@property	int	freshCards;
@property	int	totalCards;

@end
