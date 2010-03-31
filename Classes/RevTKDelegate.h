//
//  RevTKAppDelegate.h
//  RevTK
//
//  Created by John Bradley on 3/29/10.
//  Copyright J. Bradley & Associates, LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTKManager;

@interface RevTKDelegate : NSObject <UIApplicationDelegate> {
    IBOutlet UIWindow				*window;
	IBOutlet UINavigationController *navigationController;
	
	BOOL alertDialogRunning;
	RTKManager *manager;
}

+ (RevTKDelegate *)sharedRevTKApplication;


@property (nonatomic, retain) IBOutlet	UIWindow				*window;
@property (nonatomic, retain) IBOutlet	UINavigationController	*navigationController;
@property (nonatomic)					BOOL					alertDialogRunning;

@end

