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

- (id)executeApiRequest:(RTKApiRequest *)request withErrorHandling:(BOOL)shouldHandleErrors {
	
	[request startSynchronous];
	
	RTKResponseObject *responseObject = [request object];
	
	return responseObject;
	
}

@end
