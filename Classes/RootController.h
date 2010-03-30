//
//  RootController.h
//  RevTK
//
//  Created by John Bradley on 3/29/10.
//  Copyright J. Bradley & Associates, LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
	
	UITableView *tableView;
	NSArray *newsStories;
}

- (IBAction)login:(id)sender;

@property (nonatomic, retain) IBOutlet UITableView	*tableView;
	

@end

