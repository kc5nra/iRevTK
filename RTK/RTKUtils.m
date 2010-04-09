//
//  RTKUtils.m
//  RevTK
//
//  Created by John Bradley on 3/31/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

// RevTK Specific Imports
#import "RTKUtils.h"

@implementation RTKUtils

+ (NSString *)convertIntervalToString: (NSTimeInterval)interval
{
	// the time interval 
	NSTimeInterval theTimeInterval = interval;
	
	// get the system calendar
	NSCalendar *sysCalendar = [NSCalendar currentCalendar];
	
	// create the NSDates
	NSDate *date1 = [[NSDate alloc] init];
	NSDate *date2 = [[NSDate alloc] initWithTimeIntervalSinceNow: fabs(theTimeInterval)]; 
	
	// get conversion to months, days, hours, minutes
	unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit;
	
	NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:date1  toDate:date2  options:0];
	
	int minutes = [breakdownInfo minute];
	int hours = [breakdownInfo hour];
	int days = [breakdownInfo day];
	int months = [breakdownInfo month];
	
	// return the string representation from broken down time
	// FIXME: come up with a more accurate method of doing this
	
	if ((minutes >= 0) && ((hours+days+months) == 0)) {
		if (minutes == 1) {
			return [[NSString alloc] initWithString: @"1 second ago"];
		} else {
			return [[NSString alloc] initWithFormat: @"%d seconds ago", minutes];
		}
	} else {
		if ((hours >= 0) && ((days+months) == 0)) {
			if (hours == 1) {
				return [[NSString alloc] initWithString: @"1 hour ago"];
			} else {
				return [[NSString alloc] initWithFormat: @"%d hours ago", hours];
			}
		} else {
			if ((days >= 0) && ((months) == 0)) {
				if (days == 1) {
					return [[NSString alloc] initWithString: @"1 day ago"];
				} else {
					return [[NSString alloc] initWithFormat: @"%d days ago", days];
				}
			} else {
				if ((months) == 1) {
					return [[NSString alloc] initWithString: @"1 month ago"];
				} else {
					return [[NSString alloc] initWithFormat: @"%d months ago", months];
				}	
			}
		}
	}
	
	[date1 release];
	[date2 release];
	
}

+ (int) getJsonIntegerFromDictionary:(NSDictionary*)dictionary withKey:(NSString*)key
{
	NSNumber* _int = [dictionary valueForKey:key];
	return [_int integerValue];
}

+ (BOOL) getJsonBooleanFromDictionary:(NSDictionary*)dictionary withKey:(NSString*)key
{
	NSNumber* _int = [dictionary valueForKey:key];
	return ([_int integerValue] == 1) ? TRUE : FALSE;
}

+ (UTF8Type)determineTextType:(NSString *)string
{
	if ([[NSScanner scannerWithString: string] scanInt: nil]) {
		return RTKTextTypeNumbers;
	}
	
	if ([string length] > 0) {
		
		// get the character
		unichar myChar = [string characterAtIndex: 0];

		// kanji
		if ((myChar >= 0x4E00) && (myChar <= 0x9FAF)) 
		{	
			return RTKTextTypeKanji;
		} 
		// hiragana
		else if ((myChar >= 0x3040) && (myChar <= 0x3096))
		{
			return RTKTextTypeHiragana;
		} 
		// katakana
		else if (((myChar >= 0x30A1) && (myChar <= 0x30FA))	||
				 ((myChar >= 0x31F0) && (myChar <= 0x31FF))	||
				 ((myChar >= 0xFF66) && (myChar <= 0xFF9D)))
		{
			return RTKTextTypeKatakana;
		} else {
			return RTKTextTypeRomaji;
		}
	}
	return RTKTextTypeUnknown;
}

@end
