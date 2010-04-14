//
//  RTKCardStoriesRequest.h
//  RevTK
//
//  Created by ジョン ブラッドリー on 4/13/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// RevTK Specific Imports
#import "RTKApiRequest.h"

/**
 Api Card Stories Request.
 This Api request does a GET for retrieving stories for a particular card.
 */
@interface RTKCardStoriesRequest : RTKApiRequest
    
/**
 Initializes a GET request object for retrieving a card's stories.
 The caller of this method must release the Request object themselves.
 @returns a reference to a RTKCardStoriesRequest object
 */
+ (RTKCardStoriesRequest *)get: (int)cardId;

@end
