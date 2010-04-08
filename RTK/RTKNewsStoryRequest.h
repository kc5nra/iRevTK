//
//  RTKNewsStoryRequest.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// RevTK Specific Imports
#import "RTKApiRequest.h"

/**
 Api News Story Request.
 This Api request does a GET of a specific News Story from the rest service.
 */
@interface RTKNewsStoryRequest : RTKApiRequest 


/**
 Initializes a GET request object for retrieving a specific news item.
 The caller of this method must release the Request object themselves.
 @param newsStoryId the integer id of the story to retrieve
 @returns a reference to a RTKNewsStoryRequest object
 */
+ (RTKNewsStoryRequest *)get:(int)newsStoryId;	

@end