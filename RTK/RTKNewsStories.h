//
//  RTKNewsStories.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTKResponseObject.h"

@interface RTKNewsStories : RTKResponseObject {
	NSArray *newsStories;
}

@property (nonatomic, retain) NSArray *newsStories;

@end
