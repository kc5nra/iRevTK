//
//  RTKUtils.m
//  RevTK
//
//  Created by John Bradley on 3/31/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKUtils.h"


@implementation RTKUtils

+ (NSString *)convertIntervalToString: (NSTimeInterval)interval
{
	// The time interval 
	NSTimeInterval theTimeInterval = interval;
	
	// Get the system calendar
	NSCalendar *sysCalendar = [NSCalendar currentCalendar];
	
	// Create the NSDates
	NSDate *date1 = [[NSDate alloc] init];
	NSDate *date2 = [[NSDate alloc] initWithTimeIntervalSinceNow: fabs(theTimeInterval)]; 
	
	// Get conversion to months, days, hours, minutes
	unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit;
	
	NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:date1  toDate:date2  options:0];
	
	int minutes = [breakdownInfo minute];
	int hours = [breakdownInfo hour];
	int days = [breakdownInfo day];
	int months = [breakdownInfo month];
	
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

@end
