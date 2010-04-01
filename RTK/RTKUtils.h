//
//  RTKUtils.h
//  RevTK
//
//  Created by John Bradley on 3/31/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RTKUtils : NSObject {	
	
}

+ (NSString *)convertIntervalToString: (NSTimeInterval)time;
+ (int) getJsonIntegerFromDictionary:(NSDictionary*)dictionary withKey:(NSString*)key;
+ (BOOL) getJsonBooleanFromDictionary:(NSDictionary*)dictionary withKey:(NSString*)key;

@end
