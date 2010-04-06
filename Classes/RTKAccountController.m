//
//  RTKAccountController.m
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKAccountController.h"
#import "RTK.h"
#import "RTKManager.h"
#import "RTKApiKey.h"
#import "RTKApiKeyRequest.h"
#import "ASIHTTPRequest.h"
#import "RevTKDelegate.h"

@implementation RTKAccountController


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (void)dealloc {
    [super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    manager = [RTKManager sharedManager];

	[tableView setBackgroundColor: [UIColor clearColor]];
	[[self view] setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed: @"Background.gif"]]];

	[super viewDidLoad];
}

- (void)login:(id)sender {

		
	[loginButton setEnabled: NO];
	
	// start loading animation
	[activityIndicator startAnimating];
	
	RTKApiKeyRequest *request = [RTKApiKeyRequest get:[userNameTextField text] withPassword:[passwordTextField text]];
	
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(requestFinished:)];
	[request startAsynchronous];
}

- (void)autoLogin {
	[loginButton setEnabled: NO];
	//[activityIndicator startAnimating];
	
	usleep(5000000);
	[loginButton setEnabled: YES];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	RTKApiKeyRequest *apiRequest = (RTKApiKeyRequest *)request;
	
	//[activityIndicator stopAnimating];
	// restore state
	[loginButton setEnabled: YES];
	
	// get the api key response
	RTKApiKey *response = (RTKApiKey *)[apiRequest object];
	if (response && ([response apiKey])) {
		// got a new api key, add to preferences
		[manager setStringPreferenceForKey:kRTKPreferencesApiKey withValue: [response apiKey]];
		
		[self dismissModalViewControllerAnimated: YES];
		//RootController *rootController = [[[RootController alloc] initWithNibName:@"RootController" bundle:nil] autorelease];
		//[[self navigationController] pushViewController: rootController animated: YES];
	} else {
		// assume we got an error
		RTKApiError *apiError = (RTKApiError *)[response error];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[apiError message] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	[response release];
	[request release];

	
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	RTKApiKeyRequest *apiRequest = (RTKApiKeyRequest *)request;
	
	
	NSError *error = [apiRequest error];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Communication Error" message:[error description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
	[activityIndicator stopAnimating];
	// restore state
	[loginButton setEnabled: YES];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark Table Delegate

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
                [userNameTextField setText: [manager getStringPreferenceForKey: kRTKPreferencesUsername]];
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




@synthesize manager;
@synthesize activityIndicator;


@end
