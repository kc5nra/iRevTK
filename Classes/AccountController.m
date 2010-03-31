//
//  EditAccountController.m
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "AccountController.h"
#import "RTK.h"
#import "RTKManager.h"
#import "RTKApiKey.h"
#import "RTKApiKeyRequest.h"

@implementation AccountController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[tableView setBackgroundColor: [UIColor clearColor]];
	[[self view] setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed: @"Background.gif"]]];
	manager = [RTKManager sharedManager];
	
//	// Create a 'right hand button' that is a activity Indicator
//	CGRect frame = CGRectMake(0.0, 0.0, 25.0, 25.0);
//	self.activityIndicator = [[UIActivityIndicatorView alloc]
//							  initWithFrame:frame];
//	[self.activityIndicator sizeToFit];
//	self.activityIndicator.autoresizingMask =
//    (UIViewAutoresizingFlexibleLeftMargin |
//	 UIViewAutoresizingFlexibleRightMargin |
//	 UIViewAutoresizingFlexibleTopMargin |
//	 UIViewAutoresizingFlexibleBottomMargin);
//	
//	UIBarButtonItem *loadingView = [[UIBarButtonItem alloc] 
//									initWithCustomView:self.activityIndicator];
//	loadingView.target = self;
//	self.navigationItem.rightBarButtonItem = loadingView;
	
}

- (void)login:(id)sender {

	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {	
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([indexPath row]) {
		case 0:
            if (indexPath.section == 0) {
                [userNameTextField setText: [manager getStringPreference: kRTKPreferencesUsername]];
                [userNameTextField setClearButtonMode: UITextFieldViewModeWhileEditing];
                return userNameTableViewCell;
            }
            
            break;
			
        case 1:
            passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
            return passwordTableViewCell;
            break;
			
        default:
            break;
    }
	
    return nil;
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@synthesize manager;
//@synthesize activityIndicator;


@end
