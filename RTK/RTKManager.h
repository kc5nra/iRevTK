//
//  RTKManager.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RTKApiRequest;
@class ASIHTTPRequest;

extern NSString* const kRTKPreferencesUsername;
extern NSString* const kRTKPreferencesApiKey;
extern NSString* const kRTKPreferencesAutoLogin;

@interface RTKManager : NSObject {
	NSUserDefaults		*preferences;
	NSOperationQueue	*networkQueue;
	
//	NSManagedObjectModel *managedObjectModel;
//    NSManagedObjectContext *managedObjectContext;	    
//    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	
}

- (BOOL)getBoolPreferenceForKey:(NSString *)key;
- (NSString *)getStringPreferenceForKey: (NSString *)key;
- (void)setBoolPreferenceForKey:(NSString *)key withValue:(BOOL)value;
- (void)setStringPreferenceForKey:(NSString *)key withValue:(NSString *)value;

- (void)pushAsyncApiRequest:(RTKApiRequest *)request;
- (void)requestFinished:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;



+ (RTKManager *)sharedManager;

@property (retain) NSOperationQueue *networkQueue;

@end
