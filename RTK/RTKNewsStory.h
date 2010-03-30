//
//  RTKNewsStory.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RTKResponseObject.h"

@interface RTKNewsStory : RTKResponseObject {
	int			newsId;
	NSString	*subject;
	NSString	*text;
	NSString	*date;
	BOOL		brief;
}

@property			int			newsId;
@property (retain)	NSString	*subject;
@property (retain)	NSString	*text;
@property (retain)	NSString	*date;
@property			BOOL		brief;

@end
