//
//  RootController.m
//  RevTK
//
//  Created by John Bradley on 3/29/10.
//  Copyright J. Bradley & Associates, LLC 2010. All rights reserved.
//

#import "RootController.h"
#import "RevTKDelegate.h"
#import "RTKNewsStory.h"
#import "RTKApiKeyRequest.h"
#import "RTKNewsStoryRequest.h"

@implementation RootController

@synthesize tableView;

- (IBAction)login:(id)sender {
	//RTKApiKeyRequest *request = [RTKApiKeyRequest apiKeyRequestUsingGETMethodUsingUsername:@"admin" withPassword:@"admin"];
//	[request startSynchronous];
//	
//	//NSString *apiKey = [request apiKey];
//	
//	[RTKApiRequest setApiKey: apiKey];
	
	//[apiKeyLabel setText: apiKey];
	
}

#pragma mark UITableViewDataSource Methods

- (UITableViewCell *)
	tableView:(UITableView *)tv
	cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =
	[ tv dequeueReusableCellWithIdentifier:@"cell"];
    if( nil == cell ) {
        cell = [ [[UITableViewCell alloc]
				  initWithFrame:CGRectZero reuseIdentifier:@"cell"] autorelease];
    }
	
	RTKNewsStory *newsStory = [newsStories objectAtIndex: [indexPath row]];
	[[cell textLabel] setText: [newsStory subject]];
	[newsStory release];
	
    return cell;
}
- (NSInteger)tableView:(UITableView *)tv
 numberOfRowsInSection:(NSInteger)section
{
    return [newsStories count];
}

#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tv
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	RTKNewsStory *briefStory = [newsStories objectAtIndex: [indexPath row]];
	
	RTKNewsStoryRequest *request = [RTKNewsStoryRequest newsStoryRequestUsingGETMethod: [briefStory newsId]];
	
	[request startSynchronous];
	
	RTKNewsStory *story = (RTKNewsStory *)[request object];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle: [story subject] message: [story text] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
	[story release];
	[request release];
}

#pragma mark -

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	RevTKDelegate *delegate = (RevTKDelegate*)[[UIApplication sharedApplication] delegate];
	newsStories = [delegate newsStories];
	
    [super viewDidLoad];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	
	[newsStories release];
	[tableView release];
    [super dealloc];
}


@end
