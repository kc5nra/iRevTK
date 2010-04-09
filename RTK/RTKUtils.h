//
//  RTKUtils.h
//  RevTK
//
//  Created by John Bradley on 3/31/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 An enum used when determining what type of text was entered into a text box.
 */
typedef enum
{
	RTKTextTypeKanji	= 0, 
	RTKTextTypeHiragana	= 1,
	RTKTextTypeKatakana	= 2,
	RTKTextTypeRomaji	= 3,
	RTKTextTypeNumbers	= 4,
	RTKTextTypeUnknown	= 5
} UTF8Type;

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
+ (int)getJsonIntegerFromDictionary:(NSDictionary*)dictionary withKey:(NSString*)key;

/**
 Retrieves a NSNumber from a dictionary and convert it to a boolean.
 @param dictionary the dictionary to containing the NSNumber
 @param key the key that references a NSNumber
 @returns a boolean
 */
+ (BOOL)getJsonBooleanFromDictionary:(NSDictionary*)dictionary withKey:(NSString*)key;


/**
 Determines whether the text is of a certain type.
 @param string the text string to analyze.
 @returns the type of string
 */
+ (UTF8Type)determineTextType:(NSString *)string;

@end
