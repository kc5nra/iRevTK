//
//  RTKNewsStoryRequest.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTKApiRequest.h"

@interface RTKNewsStoryRequest : RTKApiRequest 
{	
}

+ (id)newsStoryRequestUsingGETMethod:(int)newsStoryId;	

@end