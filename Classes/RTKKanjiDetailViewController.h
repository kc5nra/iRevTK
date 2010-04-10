//
//  RTKKanjiDetailViewController.h
//  RevTK
//
//  Created by John Bradley on 4/9/10.
//  Copyright 2010 J. Bradley & Associates, LLC.. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RTKKanjiDetailViewController : UIViewController {
	IBOutlet UIButton *practiceButton;
	IBOutlet UILabel *keywordLabel;
	IBOutlet UILabel *kanjiLabel;
	IBOutlet UILabel *storyLabel;
	IBOutlet UITableView *storiesTableView;
}

- (void)practice:(id)sender;

@end
