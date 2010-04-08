//
//  RTKResponseObject.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// forward class declarations
/////////////////////////////
@class RTKApiError;
/////////////////////////////

/**
 Abstract API Response Object.
 This API Response abstract class is the base class from which 
 all API Response objects should derive. They should all implement
 their own parseResponse object.
 */
@interface RTKResponseObject : NSObject {
	
	/**
	 The Error object if the response contained an error.
	 */
	RTKApiError		*error;
	
	/**
	 A boolean describing whether this response object is the root
	 object or a child.  If it is a fragment, then it must have a
	 parent object set.
	 */
	BOOL			isFragment;
	
	/**
	 The parent object who created this object during it's parseResponse
	 method.
	 */
	id				parent;
}

/**
 Initialize a root Response Object from the JSON parser's dictionary
 output.  This method should only be called directly with the response of
 an API request.  All Response Objects that contain other response objects
 should create the children with initFromResponseFragment.
 @param dictionary the JSON Parser's result dictionary
 @returns a response object
 */
- (id)initWithResponseDictionary:(NSDictionary *)dictionary;

/**
 Initialize a root Response Object from a fragment of the JSON parser's dictionary
 output. 
 @param fragment an object that was in the original responses dictionary
 @param objectParent the parent of the Response Object that is being created
 @returns a response object
 */
- (id)initFromResponseFragment:(id)fragment withParent:(id) objectParent;

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain)	RTKApiError		*error;
@property (nonatomic)			BOOL			isFragment;
@property (nonatomic, retain)	id				parent;

@end
