//
//  RTKBoxesViewController.h
//  RevTK
//
//  Created by John Bradley on 4/1/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTKBoxes;

@interface RTKBoxesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	RTKBoxes *boxes;
}

@property (retain) RTKBoxes *boxes;

@end
