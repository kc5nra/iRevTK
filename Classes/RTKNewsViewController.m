//
//  RTKNewsViewController.m
//  RevTK
//
//  Created by John Bradley on 3/29/10.
//  Copyright J. Bradley & Associates, LLC 2010. All rights reserved.
//

#import "RTKNewsViewController.h"
#import "RevTKDelegate.h"
#import "RTKNewsStory.h"
#import "RTKApiKeyRequest.h"
#import "RTKNewsStoryRequest.h"
#import "RTKNewsStories.h"
#import "RTKNewsRequest.h"
#import "RTKNewsStoryTableViewCell.h"
#import "RTKUtils.h"

@implementation RTKNewsViewController


#pragma mark UITableViewDataSource Methods

- (UITableViewCell *)
tableView:(UITableView *)tv
cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	
	static NSString *CellIdentifier = @"CommentCell";
    RTKNewsStoryTableViewCell *cell = (RTKNewsStoryTableViewCell *)[newsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[[RTKNewsStoryTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
	
	
	RTKNewsStory *story = [newsStories objectAtIndex: [indexPath row]];
	
	
	
	
	
	[cell setNewsStory: story];
	
	
    // perform additional custom work...
	
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
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://kanji.koohii.com"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return COMMENT_ROW_HEIGHT;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellAccessoryDisclosureIndicator;
}


#pragma mark -

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

	RTKNewsRequest *request = [RTKNewsRequest get];
	
	[request startSynchronous];
	
	RTKNewsStories *newsStoryHolder = (RTKNewsStories *)[request object];
	
	newsStories = [newsStoryHolder newsStories];
	
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
    [super dealloc];
}

@synthesize newsTableView;


@end
