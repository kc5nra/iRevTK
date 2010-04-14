//
//  RTKKanjiDetailViewController.m
//  RevTK
//
//  Created by John Bradley on 4/9/10.
//  Copyright 2010 J. Bradley & Associates, LLC.. All rights reserved.
//

#import "RTKKanjiDetailViewController.h"
#import "RTKKanjiPracticeViewController.h"
#import "RevTKDelegate.h"
#import "RTKManager.h"
#import "Kanji.h"
#import "RTKCardStoriesRequest.h"
#import "RTKStories.h"
#import "RTKStory.h"
#import "RTK.h"
#import "RTKStoriesSearchOperation.h"

@implementation RTKKanjiDetailViewController

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	kanji = [[RTKManager sharedManager] currentStudiedKanji];
	[kanjiLabel setText: [kanji kanji]];
	[keywordLabel setText: [kanji keyword]];
    
    operationQueue = [[NSOperationQueue alloc] init];
	[operationQueue setMaxConcurrentOperationCount: 1];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Refresh"  style:UIBarButtonItemStylePlain target:self action:@selector(refreshStories:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [rightButton release];
    
    [self refreshStories:nil];
}

- (void)refreshStories:(id)result {
    RTKStoriesSearchOperation *searchOperation = [[RTKStoriesSearchOperation alloc] initWithKanji: kanji delegate:self];
    
    [operationQueue addOperation: searchOperation];
    
    [loadingView setAlpha: 0.95];
    [activityIndicator startAnimating];
    
    [searchOperation release];
}

- (void)viewWillAppear:(BOOL)animated
{
	[[[RevTKDelegate sharedRevTKApplication] navigationController] setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[[[RevTKDelegate sharedRevTKApplication] navigationController] setNavigationBarHidden:YES animated:NO];
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
    [operationQueue release];
    [storyArray release];
    [super dealloc];
}

- (void)practice:(id)sender
{
	RTKKanjiPracticeViewController *practiceViewController = 
		[[RTKKanjiPracticeViewController alloc] initWithNibName:@"RTKKanjiPracticeViewController" bundle:nil];
	[self presentModalViewController: practiceViewController animated:YES];
	[practiceViewController release];
}

- (void)updateStories:(RTKStories *)stories
{
    [UIView beginAnimations: nil context:NULL];
    [UIView setAnimationDelay: .25];
    [loadingView setAlpha: 0];
    [activityIndicator stopAnimating];
    [UIView commitAnimations];
    
    if (storyArray) {
        [storyArray release];
        storyArray = 0;
    }
    
    if ([[stories stories] count] > 0) {
        storyArray = [[stories stories] retain];
    }
    
    [storiesTableView reloadData];
    RTKLog(@"Received stories: %@", stories);
    [stories release];
}

#pragma mark -
#pragma mark UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [storyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    UILabel *label = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"Cell"] autorelease];
        
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        [label setLineBreakMode:UILineBreakModeWordWrap];
        [label setMinimumFontSize:FONT_SIZE];
        [label setNumberOfLines:0];
        [label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        [label setTag:1];
        
        [[cell contentView] addSubview:label];
    }
    NSString *text = [[storyArray objectAtIndex:[indexPath row]] text];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    if (!label)
        label = (UILabel*)[cell viewWithTag:1];
    
    [label setText:text];
    [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *text = [[storyArray objectAtIndex:[indexPath row]] text];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 44.0f);
    
    return height + (CELL_CONTENT_MARGIN * 2);
}

#pragma mark -
#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[[RTKManager sharedManager] setCurrentStudiedKanji: [filteredKanjiList objectAtIndex: [indexPath row]]];
//	RTKKanjiDetailViewController *detailedViewController = [[RTKKanjiDetailViewController alloc] initWithNibName:@"RTKKanjiDetailViewController" bundle:nil];
//	[[[RevTKDelegate sharedRevTKApplication] navigationController] pushViewController:detailedViewController animated:YES];
//	[detailedViewController release];
//	[self setPreviouslySelectedIndexPath: indexPath];
}


@end
