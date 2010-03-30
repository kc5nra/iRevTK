//
//  RTKApiError.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RTKApiError : NSObject {
	NSString *message;
	int statusCode;
}

@property (retain)	NSString *message;
@property			int statusCode;

@end
