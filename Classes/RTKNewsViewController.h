//
//  RTKNewsViewController.h
//  RevTK
//
//  Created by John Bradley on 3/29/10.
//  Copyright J. Bradley & Associates, LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTKNewsViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate> {
	
	UITableView *newsTableView;
	
	UITableViewCell *newsCell;
	UILabel *newsDate;
	UILabel *newsSubject;
	UITextView *textView;
	NSArray *newsStories;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section;

@property (nonatomic, retain) IBOutlet UITableView *newsTableView;

@end