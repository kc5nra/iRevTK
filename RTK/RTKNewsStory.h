//
//  RTKNewsStory.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// RevTK Specific Imports
#import "RTKResponseObject.h"

/**
 News Story Response Object.
 This object contains information retrieved from a Api News Story Request.
 */
@interface RTKNewsStory : RTKResponseObject {
	/**
	 The id of this news story.
	 */
	int			newsId;
	/**
	 A short descriptive string describing this news item.
	 */
	NSString	*subject;
	/**
	 The body of this news item.
	 */
	NSString	*text;
	/**
	 The date this news item was published.
	 */
	NSString	*date;
	/**
	 A boolean value describing whether this news post is truncated due to
	 the body containing a <more> tag.
	 True if the news body is truncated, false if it is not.
	 */
	BOOL		brief;
}

@property			int			newsId;
@property (retain)	NSString	*subject;
@property (retain)	NSString	*text;
@property (retain)	NSString	*date;
@property			BOOL		brief;

@end
