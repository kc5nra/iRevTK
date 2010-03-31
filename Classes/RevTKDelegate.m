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
@synthesize navigationController;
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
    
	AccountController *accountController = [[AccountController alloc] init];
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController: accountController];
	[self setNavigationController: aNavigationController];
	
    // Override point for customization after app launch    
    [window addSubview: [navigationController view]];
    [window makeKeyAndVisible];
	
	[accountController release];
}


- (void)dealloc {
    [navigationController release];
    [window release];
    [super dealloc];
}


@end
