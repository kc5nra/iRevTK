//
//  RTKManager.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const kRTKPreferencesUsername;
extern NSString* const kRTKPreferencesApiKey;
extern NSString* const kRTKPreferencesAutoLogin;

@interface RTKManager : NSObject {
	NSUserDefaults	*preferences;
}

- (BOOL)getBoolPreference:(NSString *)key;
- (NSString *)getStringPreference: (NSString *)key;

+ (RTKManager *)sharedManager;



@end
