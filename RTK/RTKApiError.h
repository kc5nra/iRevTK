//
//  RTKApiError.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 API Error Object.
 This class holds the information passed back from a service when an
 error occurs.
 */
@interface RTKApiError : NSObject {
	/**
	 A string message describing the error that occured.
	 */
	NSString *message;
	/**
	 An HTTP Status code that described exactly what error occured
	 on the server side.
	 */
	int statusCode;
}

#pragma mark -
#pragma mark Properties

@property (retain)	NSString *message;
@property			int statusCode;

@end
