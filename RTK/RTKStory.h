//
//  RTKStory.h
//  RevTK
//
//  Created by ジョン ブラッドリー on 4/13/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// RevTK Specific Imports
#import "RTKResponseObject.h"

/**
 Story Response Object.
 This object contains information retrieved from a Api Story Request.
 */
@interface RTKStory : RTKResponseObject {
    /**
     The user id that created this story
     */
    int userId;
    
    /**
     The user's name that created this story.
     */
    NSString *userName;
    
    /**
     The number of the card that this story references.
     */
    int heisigNumber;
    
    /**
     The date since this story was last modified.
     */
    NSString *lastModified;
    
    /**
     The actual text body of the story.
     */
    NSString *text;
    
    /**
     How many stars this story has received.
     */
    int stars;
    
    /**
     How many down-rankings this story has received.
     */
    int kicks;
}

@property                       int       userId;
@property (nonatomic, retain)   NSString  *userName;
@property                       int       heisigNumber;
@property (nonatomic, retain)   NSString  *lastModified;
@property (nonatomic, retain)   NSString  *text;
@property                       int       stars;
@property                       int       kicks;

@end
