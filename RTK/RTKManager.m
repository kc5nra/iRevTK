//
//  RTKManager.m
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKManager.h"
#import "RevTKDelegate.h"
#import "RTK.h"
#import "RTKApiRequest.h"
#import "RTKBoxes.h"
#import "RTKSimpleBox.h"
#import "RTKBoxesRequest.h"

// Model
#import "Kanji.h"


NSString * const kRTKPreferencesUsername				= @"username";
NSString * const kRTKPreferencesApiKey					= @"apiKey";
NSString * const kRTKPreferencesAutoLogin				= @"autoLogin";
NSString * const kRTKInternalIsKanjiDatabaseBuiltKey	= @"isKanjiDatabaseBuilt";
NSString * const kRTKNotificationBoxesDidUpdate			= @"kRTKNotificationBoxesDidUpdate";
NSString * const kRTKNotificationNewsStoriesDidUpdate	= @"kRTKNotificationNewsStoriesDidUpdate";
NSString * const kRTKCoreDataDatabaseName				= @"RTK.sqlite";
NSString * const kRTKDataPlist							= @"RTKData";

@interface RTKManager (Private)
- (void)addAsyncOperation:(SEL)anOperation withArg:(id)anArg;
- (void)asyncUpdateBoxes:(id)arg;
@end

@implementation RTKManager

static RTKManager *sharedManager;

+ (RTKManager *)sharedManager
{
	if (!sharedManager) {
		sharedManager = [[RTKManager alloc] init];
	}
	
	return sharedManager;
}

+ (id)alloc
{
	NSAssert(sharedManager == nil, @"Attempted to allocate a second instance of the shared RTK Manager");
	
	sharedManager = [super alloc];
	return sharedManager;
}

- (void)dealloc {
	[networkQueue release];
	[super dealloc];
}

- (id)init 
{
	preferences = [NSUserDefaults standardUserDefaults];
	
	if (![self networkQueue]) {
		[self setNetworkQueue:[[NSOperationQueue alloc] init]];
	}
	
	sharedApplication = [RevTKDelegate sharedRevTKApplication];
	
	NSString *apiKey = [preferences stringForKey: kRTKPreferencesApiKey];
	
	// if we already have an apiKey, set it in the RTKApiRequest
	if (apiKey) {
		[RTKApiRequest setApiKey: apiKey];
	}
	
	[apiKey release];
	
	managedObjectContext = [self managedObjectContext];
	
	[self preloadKanjiData];
	
	return self;
}

- (BOOL)getBoolPreferenceForKey:(NSString *)key 
{
	return [preferences boolForKey: key];
}

- (NSString *)getStringPreferenceForKey: (NSString *)key
{
	return [preferences stringForKey: key];
}

- (void)setBoolPreferenceForKey:(NSString *)key withValue:(BOOL)value
{
	[preferences setBool:value forKey:key];
}

- (void)setStringPreferenceForKey:(NSString *)key withValue:(NSString *)value
{
	[preferences setObject:value forKey:key];
}


#pragma mark Error Handling

- (BOOL)handleError:(NSError *)error 
{
	//TODO: Handle more than the default error case
	UIAlertView *alert = nil;
	
	alert = [[UIAlertView alloc] initWithTitle: @"Error in communicating with RevTK REST Services" 
									   message: [error localizedDescription]
									  delegate: self
							 cancelButtonTitle: @"OK"
							 otherButtonTitles: nil];
	
	[alert show];
	
	RevTKDelegate *delegate = (RevTKDelegate *)[[UIApplication sharedApplication] delegate];
	[delegate setAlertDialogRunning: YES];
	
	[alert release];
	
	return YES;
}
#pragma mark -
#pragma mark Asynchronous Methods

- (void)addAsyncOperation:(SEL)anOperation withArg:(id)anArg 
{
    if (![self respondsToSelector:anOperation]) {
        return;
    }
	
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:anOperation object:anArg];
    [networkQueue addOperation:op];
    [op release];
}

- (void)addUpdateBoxesToQueue
{
	[self addAsyncOperation:@selector(asyncUpdateBoxes:) withArg:nil];
	
}

-(void)asyncUpdateBoxes:(id)arg
{

	// if we had the api key, go ahead and update the current expired flashcards badge
	// TODO: push a async request to the manager and have it use NSNotification's to tell the view to update the badge
	RTKBoxesRequest *request = [RTKBoxesRequest get];	
	[request startSynchronous];
	RTKBoxes *_boxes = (RTKBoxes *)[request object];
	[self setBoxes: _boxes];
	RTKLog(@"Response: %@", _boxes);
	
	[[NSNotificationCenter defaultCenter] postNotificationName: kRTKNotificationBoxesDidUpdate object:nil];
}

#pragma mark -
#pragma mark Database preloading

-(void)preloadKanjiData 
{
	NSString* plistPath = [[NSBundle mainBundle] pathForResource:kRTKDataPlist ofType:@"plist"];
	
	RTKLogO(@"Loading %@...", plistPath);
	NSDictionary* kanjis = [[NSDictionary alloc] initWithContentsOfFile: plistPath];
	// delete all entries in the Kanji database
	RTKLogO(@"Deleting existing objects in database...");
	[self deleteAllObjects: @"Kanji"];
	
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Kanji" inManagedObjectContext:managedObjectContext];
	
	RTKLogO(@"Creating %d objects to commit to the database...", [kanjis count]);
	for (id kanjiNumber in kanjis) {
		NSDictionary *kanji = [kanjis objectForKey:kanjiNumber];
		
		Kanji *newKanji = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:managedObjectContext];
		[newKanji setValuesForKeysWithDictionary: kanji];
	}
	NSError *error;
	
	RTKLogO(@"Saving objects to the database...");
	if (![managedObjectContext save: &error]) {
		RTKLog(@"Error saving Kanji List - error:%@", error);
		NSArray *array = [[error userInfo] objectForKey: NSDetailedErrorsKey];
		for (NSError *err in array) {
			RTKLog(@"Error saving Kanji List - error:%@", err);
			RTKLog(@"Detailed: %@", [err userInfo]);
		}
	}
	
	RTKLogO(@"Done preloading Kanji data.");
	

	
}

- (void) deleteAllObjects: (NSString *) entityDescription {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
	
    NSError *error;
    NSArray *items = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
	
	
    for (NSManagedObject *managedObject in items) {
        [managedObjectContext deleteObject:managedObject];
    }
    if (![managedObjectContext save:&error]) {
        RTKLog(@"Error deleting %@ - error:%@",entityDescription, error);
    }
	
}

#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext 
{
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel 
{
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator 
{
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: kRTKCoreDataDatabaseName]];
	
	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    
	
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory 
{
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Synthesized Properties

@synthesize networkQueue;
@synthesize boxes;
@synthesize currentStudiedKanji;

@end
