//
//  RTKBoxesRequest.h
//  RevTK
//
//  Created by John Bradley on 4/1/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// RevTK Specific Imports
#import "RTKApiRequest.h"

/**
 Api Boxes Request.
 This Api request does a GET for retrieving all the leitner boxes.
 */
@interface RTKBoxesRequest : RTKApiRequest

/**
 Initializes a GET request object for retrieving leiter boxes.
 The caller of this method must release the Request object themselves.
 @returns a reference to a RTKBoxesRequest object
 */
+ (RTKBoxesRequest *)get;

@end
