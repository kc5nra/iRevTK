//
//  RTKNewsRequest.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// RevTK Specific Imports
#import "RTKApiRequest.h"

/**
 Api News Request.
 This Api request does a GET for retrieving all news items.
 */
@interface RTKNewsRequest : RTKApiRequest

/**
 Initializes a GET request object for retrieving the news items.
 The caller of this method must release the Request object themselves.
 @returns a reference to a RTKNewsRequest object
 */
+ (RTKNewsRequest *)get;

@end
