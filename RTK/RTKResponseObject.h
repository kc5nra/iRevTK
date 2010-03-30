//
//  RTKResponseObject.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RTKApiError;

@interface RTKResponseObject : NSObject {
	RTKApiError		*error;
	BOOL			isFragment;
	id				parent;
}

- (id)initWithResponseDictionary:(NSDictionary *)dictionary;
- (id)initFromResponseFragment:(id)fragment withParent:(id) objectParent;
- (void)parseResponse: (id) responseObject;

@property (nonatomic, retain)	RTKApiError		*error;
@property (nonatomic)			BOOL			isFragment;
@property (nonatomic, retain)	id				parent;

@end
