//
//  RevTKAppDelegate.m
//  RevTK
//
//  Created by John Bradley on 3/29/10.
//  Copyright J. Bradley & Associates, LLC 2010. All rights reserved.
//

#import "RevTKDelegate.h"
#import "RTKNewsRequest.h"
#import "RTKNewsStories.h"
#import "RTKBoxesRequest.h"
#import "RTKBoxes.h"
#import "RTKSimpleBox.h"
#import "RTKManager.h"
#import "RTKAccountController.h"
#import "RTKLoadingViewController.h"

int const kRTKTabBarReviewIndex = 1;

@interface RevTKDelegate (Private)

- (void)badgeValuesDidUpdate:(id)notification;

@end


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
    
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(badgeValuesDidUpdate:) name:kRTKNotificationBoxesDidUpdate object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(badgeValuesDidUpdate:) name:kRTKNotificationNewsStoriesDidUpdate object:nil];
	
	accountController = [[RTKAccountController alloc] init];
		
	// make the tab controller the main view
    [window addSubview: [tabBarController view]];
	
	// if we already have an apiKey stored in our preferences, skip the login screen and set it to the request
	NSString *apiKey = [manager getStringPreferenceForKey: kRTKPreferencesApiKey];
	if (apiKey) {
		[RTKApiRequest setApiKey: apiKey];
		[apiKey release];
		[manager addUpdateBoxesToQueue];
		
	} else {
		[tabBarController presentModalViewController:accountController animated:NO];
	}
	
	
	splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 480)];
	[splashView setImage: [UIImage imageNamed:@"Default.png"]];
	[window addSubview:splashView];
	[window bringSubviewToFront:splashView];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:window cache:YES];
	[UIView setAnimationDelegate:self]; 
	[UIView setAnimationDidStopSelector:@selector(startupAnimationDone:finished:context:)];
	[splashView setAlpha: 0.0];
	[splashView setFrame: CGRectMake(-60, -60, 440, 600)];
	[UIView commitAnimations];
	
	
	
}

- (void)startupAnimationDone:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	[splashView removeFromSuperview];
	[splashView release];
}

- (void)badgeValuesDidUpdate:(id)notification {
	RTKBoxes *boxes = [manager boxes];
	
	int newBadgeValue = [boxes untestedCount];
	NSArray *_boxes = [boxes boxes];
	for (RTKSimpleBox *box in _boxes)
	{
		newBadgeValue += [box expiredCards];
	}
	
	if (newBadgeValue <= 0) {
		[[[[tabBarController tabBar] items] objectAtIndex: kRTKTabBarReviewIndex] setBadgeValue: nil];
	}
	
	[[[[tabBarController tabBar] items] objectAtIndex: kRTKTabBarReviewIndex] setBadgeValue: [NSString stringWithFormat:@"%d",newBadgeValue]];
}


- (void)dealloc {
    [accountController release];
	[tabBarController release];
    [window release];
    [super dealloc];
}

@synthesize tabBarController;
@synthesize navigationController;

@end
