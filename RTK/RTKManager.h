//
//  RTKManager.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RevTKDelegate;
@class RTKApiRequest;
@class ASIHTTPRequest;
@class RTKBoxes;

extern NSString* const kRTKPreferencesUsername;
extern NSString* const kRTKPreferencesApiKey;
extern NSString* const kRTKPreferencesAutoLogin;
extern NSString * const kRTKNotificationBoxesDidUpdate;
extern NSString * const kRTKNotificationNewsStoriesDidUpdate;

@interface RTKManager : NSObject {
	NSUserDefaults		*preferences;
	NSOperationQueue	*networkQueue;
	
	NSManagedObjectModel			*managedObjectModel;
    NSManagedObjectContext			*managedObjectContext;	    
    NSPersistentStoreCoordinator	*persistentStoreCoordinator;
	
	RevTKDelegate		*sharedApplication;
	
	RTKBoxes			*boxes;
}

- (BOOL)getBoolPreferenceForKey:(NSString *)key;
- (NSString *)getStringPreferenceForKey: (NSString *)key;
- (void)setBoolPreferenceForKey:(NSString *)key withValue:(BOOL)value;
- (void)setStringPreferenceForKey:(NSString *)key withValue:(NSString *)value;

- (void)addUpdateBoxesToQueue;

- (NSString *)applicationDocumentsDirectory;

- (void)deleteAllObjects: (NSString *) entityDescription;
- (void)preloadKanjiData ;

+ (RTKManager *)sharedManager;

@property (retain) NSOperationQueue *networkQueue;
@property (retain) RTKBoxes *boxes;

@property (nonatomic, retain, readonly) NSManagedObjectModel			*managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext			*managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator	*persistentStoreCoordinator;


@end
