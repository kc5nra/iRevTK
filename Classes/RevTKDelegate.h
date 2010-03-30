//
//  RevTKAppDelegate.h
//  RevTK
//
//  Created by John Bradley on 3/29/10.
//  Copyright J. Bradley & Associates, LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootController;

@interface RevTKDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RootController *viewController;
	NSArray *newsStories;
	
	BOOL alertDialogRunning;
}

@property (nonatomic, retain) IBOutlet	UIWindow		*window;
@property (nonatomic, retain) IBOutlet	RootController	*viewController;
@property (nonatomic)					BOOL			alertDialogRunning;
@property (nonatomic, retain)			NSArray			*newsStories;

@end

