//
//  RTKApiKey.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// RevTK Specific Imports
#import "RTKResponseObject.h"

/**
 Api Key Response Object.
 This object contains information retrieved from a Api Key Request.
 */
@interface RTKApiKey : RTKResponseObject {
	/**
	 The api key taken from the response.
	 */
	NSString *apiKey;
}

@property (retain)	NSString *apiKey;

@end
