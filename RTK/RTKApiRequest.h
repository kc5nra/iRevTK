//
//  RTKApiRequest.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"

extern NSString* const kRTKApiRequestURL;

@class RTKApiError;
@class RTKResponseObject;

@interface RTKApiRequest : ASIHTTPRequest {
	RTKResponseObject	*object;
}

// creates an instance of the correct subclass
- (id) createResponseObjectInstance;

// Shared API key
+ (NSString *)apiKey;
+ (void)setApiKey:(NSString *)newApiKey;

#pragma mark JSON Helper Methods

+ (int) getJsonIntegerFromDictionary:(NSDictionary*)dictionary withKey:(NSString*)key;
+ (BOOL) getJsonBooleanFromDictionary:(NSDictionary*)dictionary withKey:(NSString*)key;

@property (nonatomic, retain) RTKResponseObject	*object;

@end