//
//  RTKApiRequest.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// RevTK Specific Imports
#import "ASIHTTPRequest.h"

/**
 The string constant that is used to create the URL for all RTK Api requests.
 */
extern NSString* const kRTKApiRequestURL;

// forward class declarations
/////////////////////////////
@class RTKApiError;
@class RTKResponseObject;
/////////////////////////////

/**
 Abstract API Request Object.
 This API Request abstract class is the 
 base class from which all API Request objects should derive.  
 The base class handles the APIKey header (if it exists) and creating the Response 
 object (parsing JSON and routing the response data to the correct Response Object).
 */
@interface RTKApiRequest : ASIHTTPRequest {
	/**
	 The RTKResponseObject that contains the response.
	 */
	RTKResponseObject	*object;
}

/**
 Initializes the API request with a URL specific to that request type.  This method
 is usually called from a static instance creation factory supplied by the subclass.
 This is an overloaded method from the ASIHTTPRequest object.
 @param newURL the URL to use when creating the new request object
 @returns an instance of the request object
 */
- (id)initWithURL:(NSURL *)newURL;

/**
 Creates an instance of the correct subclass and returns
 a retained pointer.  You must release this when you are
 finished.
 @returns an instance of the ResponseObject
 */
- (id) createResponseObjectInstance;

#pragma mark -
#pragma mark Global API Key Getter/Setter

/**
 Returns the global RevTK Rest service API Key set when the user
 successfully logs in.
 @returns NSString string representation of the apikey to be used with all authenticated
 requests.
 */
+ (NSString *)apiKey;

/**
 Sets the global RevTK Rest service API Key set when the user
 successfully logs in.
 @param newApiKey string representation of the apikey to be set
*/
+ (void)setApiKey:(NSString *)newApiKey;

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain) RTKResponseObject	*object;

@end