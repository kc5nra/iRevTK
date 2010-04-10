//
//  RevTKAppDelegate.h
//  RevTK
//
//  Created by John Bradley on 3/29/10.
//  Copyright J. Bradley & Associates, LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTKManager;
@class RTKAccountController;
@class RTKLoadingViewController;
@class RootController;

@interface RevTKDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    
	IBOutlet RTKAccountController       *accountController;
    IBOutlet RTKLoadingViewController   *loadingViewController;
	IBOutlet UIWindow                   *window;
	IBOutlet UITabBarController         *tabBarController;
	IBOutlet UINavigationController     *navigationController;
	
	BOOL                                alertDialogRunning;
	RTKManager                          *manager;
}

+ (RevTKDelegate *)sharedRevTKApplication;

@property (nonatomic, retain) IBOutlet UITabBarController		*tabBarController;
@property (nonatomic, retain) IBOutlet UINavigationController	*navigationController;
@property (nonatomic, retain) IBOutlet UIWindow					*window;
@property (nonatomic)					BOOL					alertDialogRunning;

@end

