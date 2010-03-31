//
//  EditAccountController.h
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTKManager;

@interface AccountController : UIViewController<UITextFieldDelegate> {
	
	IBOutlet UITableView		*tableView;
	
	IBOutlet UITableViewCell	*userNameTableViewCell;
    IBOutlet UITableViewCell	*passwordTableViewCell;
	IBOutlet UITableViewCell	*apiKeyTableViewCell;
	
	IBOutlet UITextField		*userNameTextField;
    IBOutlet UITextField		*passwordTextField;
	
    IBOutlet UILabel			*userNameLabel;
    IBOutlet UILabel			*passwordLabel;
	IBOutlet UILabel			*apiKeyLabel;
	
	IBOutlet UIButton			*loginButton;
	
//	UIActivityIndicatorView		*activityIndicator;
	
	RTKManager					*manager;
}

- (void)login:(id)sender;

@property (nonatomic, retain)	RTKManager *manager;
//@property (nonatomic, retain)	UIActivityIndicatorView *activityIndicator;
@end
