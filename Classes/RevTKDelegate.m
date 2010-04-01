//
//  RevTKAppDelegate.m
//  RevTK
//
//  Created by John Bradley on 3/29/10.
//  Copyright J. Bradley & Associates, LLC 2010. All rights reserved.
//

#import "RevTKDelegate.h"
#import "RootController.h"
#import "RTKNewsRequest.h"
#import "RTKNewsStories.h"
#import "RTKManager.h"
#import "AccountController.h"

@implementation RevTKDelegate

static RevTKDelegate *rtkApp = NULL;

@synthesize window;
@synthesize alertDialogRunning;

- (id)init 
{
	if (!rtkApp) {
		rtkApp = [super init];
		manager = [RTKManager sharedManager];
	}
	
	return rtkApp;
	
}

+ (RevTKDelegate *)sharedRevTKApplication {
	if (!rtkApp) {
		rtkApp = [[RevTKDelegate alloc] init];
	}
	
	return rtkApp;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
	accountController = [[AccountController alloc] init];
		
	// make the tab controller the main view
    [window addSubview: [tabBarController view]];
	
	// if we already have an apiKey stored in our preferences, skip the login screen and set it to the request
	NSString *apiKey = [manager getStringPreferenceForKey: kRTKPreferencesApiKey];
	if (apiKey) {
		[RTKApiRequest setApiKey: apiKey];
		[apiKey release];
	} else {
		[tabBarController presentModalViewController:accountController animated:NO];
	}
	
}


- (void)dealloc {
    [accountController release];
	[tabBarController release];
    [window release];
    [super dealloc];
}

@synthesize tabBarController;

@end
