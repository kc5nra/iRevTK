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

@implementation RTKKanjiDetailViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	Kanji *kanji = [[RTKManager sharedManager] currentStudiedKanji];
	[kanjiLabel setText: [kanji kanji]];
	[keywordLabel setText: [kanji keyword]];
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
    [super dealloc];
}

- (void)practice:(id)sender
{
	RTKKanjiPracticeViewController *practiceViewController = 
		[[RTKKanjiPracticeViewController alloc] initWithNibName:@"RTKKanjiPracticeViewController" bundle:nil];
	[self presentModalViewController: practiceViewController animated:YES];
	[practiceViewController release];
}

@end
