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

@implementation RevTKDelegate

@synthesize window;
@synthesize viewController;
@synthesize newsStories;
@synthesize alertDialogRunning;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
	RTKNewsRequest *request = [RTKNewsRequest newsRequestUsingGETMethod];
	
	[request startSynchronous];
	
	RTKNewsStories *stories = (RTKNewsStories *)[request object];
	
	[self setNewsStories:[stories newsStories]];
	
	[request release];
	
    // Override point for customization after app launch    
    [window addSubview: [viewController view]];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[newsStories release];
    [viewController release];
    [window release];
    [super dealloc];
}


@end
