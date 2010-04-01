//
//  RTKManager.m
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKManager.h"
#import "RevTKDelegate.h"
#import "RTKApiRequest.h"
#import "RTKBoxes.h"
#import "RTKSimpleBox.h"
#import "RTKBoxesRequest.h"


NSString * const kRTKPreferencesUsername				= @"username";
NSString * const kRTKPreferencesApiKey					= @"apiKey";
NSString * const kRTKPreferencesAutoLogin				= @"autoLogin";
NSString * const kRTKNotificationBoxesDidUpdate			= @"kRTKNotificationBoxesDidUpdate";
NSString * const kRTKNotificationNewsStoriesDidUpdate	= @"kRTKNotificationNewsStoriesDidUpdate";

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
	
	RevTKDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate setAlertDialogRunning: YES];
	
	[alert release];
	
	return YES;
}

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
	
	[[NSNotificationCenter defaultCenter] postNotificationName: kRTKNotificationBoxesDidUpdate object:nil];
}

#pragma mark Synthesized Properties

@synthesize networkQueue;
@synthesize boxes;

@end
