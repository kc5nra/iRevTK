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

NSString* const kRTKPreferencesUsername		= @"username";
NSString* const kRTKPreferencesApiKey		= @"apiKey";
NSString* const kRTKPreferencesAutoLogin	= @"autoLogin";

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

- (void)pushAsyncApiRequest:(RTKApiRequest *)request 
{
	[request setDidFailSelector: @selector(requestFailed:)];
	[request setDidFinishSelector: @selector(requestFinished:)];
	[request setDelegate: self];
	
	[[self networkQueue] addOperation: request];
}

- (void)requestFailedProxy:(ASIHTTPRequest *)request
{

}

- (void)requestFinishedProxy:(ASIHTTPRequest *)request
{

}

@synthesize networkQueue;

@end
