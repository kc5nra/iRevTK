//
//  RTKApiKeyRequest.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// RevTK Specific Imports
#import "RTKApiRequest.h"

/**
 Api Key Request.
 This Api request does a HTTP Authenticated GET for retrieving the API Key header for use
 in subsequent api-key authenticated requests.
 */
@interface RTKApiKeyRequest : RTKApiRequest 

/**
 Initializes a GET request object the API Key header for use
 in subsequent api-key authenticated requests.
 The caller of this method must release the Request object themselves.
 @param username the username of the user
 @param password the password of the user
 @returns a reference to a RTKApiKeyRequest object
 */
+ (RTKApiKeyRequest *) get: (NSString *)username withPassword:(NSString *)password;

@end
