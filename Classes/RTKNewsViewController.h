//
//  RTKNewsViewController.h
//  RevTK
//
//  Created by John Bradley on 3/29/10.
//  Copyright J. Bradley & Associates, LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTKNewsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	
	UITableView *newsTableView;
	NSArray *newsStories;
}

@property (nonatomic, retain) IBOutlet UITableView *newsTableView;

@end