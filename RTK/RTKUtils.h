//
//  RTKUtils.h
//  RevTK
//
//  Created by John Bradley on 3/31/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Utility class that contains several static methods.
 */
@interface RTKUtils : NSObject

#pragma mark -
#pragma mark Static Methods

/**
 Converts a NSTimeInterval to a human-readable string.
 @param time an interval of time in seconds
 @returns a human readable string
 */
+ (NSString *)convertIntervalToString: (NSTimeInterval)time;

/**
 Retrieves a NSNumber from a dictionary and convert it to an integer.
 @param dictionary the dictionary to containing the NSNumber
 @param key the key that references a NSNumber
 @returns an integer
 */
+ (int) getJsonIntegerFromDictionary:(NSDictionary*)dictionary withKey:(NSString*)key;

/**
 Retrieves a NSNumber from a dictionary and convert it to a boolean.
 @param dictionary the dictionary to containing the NSNumber
 @param key the key that references a NSNumber
 @returns a boolean
 */
+ (BOOL) getJsonBooleanFromDictionary:(NSDictionary*)dictionary withKey:(NSString*)key;

@end
