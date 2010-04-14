//
//  RTKKanjiStudyView.m
//  RevTK
//
//  Created by John Bradley on 4/5/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

// application
#import "RevTKDelegate.h"
// 
#import "RTKKanjiStudyViewController.h"
#import "RTKKanjiDetailViewController.h"
#import "RTKManager.h"
#import "RTKKanjiTableViewCell.h"
#import "RTKMultipartLabel.h"
#import "RTKPredicateSearchOperation.h"
#import "RTKUtils.h"
#import "RTK.h"

// model
#import "Kanji.h"

/**
 Kanji Study View Private Category.
 */
@interface RTKKanjiStudyViewController (Private)

/**
 Builds the relationship cache for keywords.  This method must be called after the main
 cache has already been built.
 */
- (void)buildLookupByKeywordCache;

/**
 Builds the relationship cache for kanji.  This method must be called after the main
 cache has already been built.
 */
- (void)buildLookupByKanjiCache;

/**
 Builds the main cache and calls the other cache builder methods.
 */
- (void)buildCache;

/**
 Handles the input and searching of the cache when a Kanji UTF8 character is entered.
 This populates the filteredKanjiArray as well as calling for the table to be updated.
 @param text the kanji character to look for
 */
- (void)handleKanjiInput:(NSString *)text;

/**
 Handles the input and searching of the cache when a UTF8 Number (ASCII or Widechar) character is entered.
 This populates the filteredKanjiArray as well as calling for the table to be updated.
 @param text the String formatted number to look for
 */
- (void)handleNumberInput:(NSString *)text;

/**
 Handles the input and searching of the cache when a UTF8 keyword (ascii) character is entered.
 This populates the filteredKanjiArray as well as calling for the table to be updated.
 @param previousText the previous value of the search string
 @param newText the new value of the search string
 */
- (void)handleRomajiInput:(NSString *)previousText withNewText: (NSString *)newText;

/**
 Does a @synchronized update of the filteredKanjiList and calls for the Table to redisplay. 
 @param newFilteredArray the new filtered array to use as the datasource for the table
 */
- (void)updateFilteredArray:(NSArray *)newFilteredArray;



@end


@implementation RTKKanjiStudyViewController

#pragma mark -
#pragma mark UIView Methods

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[[[RevTKDelegate sharedRevTKApplication] navigationController] setNavigationBarHidden: YES];
	
	operationQueue = [[NSOperationQueue alloc] init];
	[operationQueue setMaxConcurrentOperationCount: 1];
	
	[self setManagedObjectContext: [[RTKManager sharedManager] managedObjectContext]];
	[self buildCache];
	
}

- (void)viewDidAppear:(BOOL)animated
{
	if (previouslySelectedIndexPath) {
		[kanjiTableView deselectRowAtIndexPath: [self previouslySelectedIndexPath] animated:YES];
	}
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

#pragma mark -
#pragma mark NSObject Methods

- (void)dealloc {
    [kanjiCache release];
	[operationQueue release];
    [previouslySelectedIndexPath release];
    [filteredKanjiList release];
    [super dealloc];
}

#pragma mark -
#pragma mark Public Methods

- (void)handleKanjiInput:(NSString *)text 
{
    if (filteredKanjiList) {
        [filteredKanjiList release];
        filteredKanjiList = 0;
    }
	
	[operationQueue cancelAllOperations];
    
    filteredKanjiList = [[NSArray arrayWithObject: [lookupByKanjiCache valueForKey: text]] retain];
    
    [kanjiTableView reloadData];
}

- (void)handleNumberInput:(NSString *)text 
{
    if (filteredKanjiList) {
        [filteredKanjiList release];
        filteredKanjiList = 0;
    }
	
	[operationQueue cancelAllOperations];
    
    // at this point this integer has been validated by determineTextType		
    // subtract one because it is a 0-origin array
    int intValue = [text intValue] - 1;
    
    if ((intValue >= 0) && (intValue < [kanjiCache count])) {
        filteredKanjiList = [[NSArray arrayWithObject: [kanjiCache objectAtIndex: intValue]] retain];
    }
    
    [kanjiTableView reloadData];
}

- (void)handleRomajiInput:(NSString *)previousText withNewText: (NSString *)newText 
{
    if (filteredKanjiList) {
        [filteredKanjiList release];
        filteredKanjiList = 0;
    }

    [operationQueue cancelAllOperations];
    
    // create the predicate for the search
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(keyword BEGINSWITH[cd] %@)", newText];
    RTKPredicateSearchOperation *operation = 
	[[RTKPredicateSearchOperation alloc] initWithPredicate: predicate withArray: kanjiCache delegate: self];
	// add operation to queue
	[operationQueue addOperation: operation];
    [operation release];
}

- (void)updateFilteredArray:(NSArray *)newFilteredArray;
{
    @synchronized (kanjiTableView) {
		[self setFilteredKanjiList: newFilteredArray];
		[kanjiTableView reloadData];
		
    }
}

- (void)buildCache
{
	NSManagedObjectContext *context = [self managedObjectContext];
	
	NSEntityDescription * entity = [NSEntityDescription entityForName: @"Kanji" inManagedObjectContext: context];
    NSFetchRequest * fetch = [[NSFetchRequest alloc] init];
    [fetch setEntity: entity]; 

	// sort number heisig number
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"heisigNumber" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetch setSortDescriptors: sortDescriptors];
	
	// fetch all the kanji
    NSArray * results = [context executeFetchRequest: fetch error: nil];
	[results retain];
	
	kanjiCache = results;
	
	lookupByKanjiCache = [[NSMutableDictionary alloc] init];
	lookupByKeywordCache = [[NSMutableDictionary alloc] init];
	
	for (Kanji *kanji in results) {
		[lookupByKanjiCache setValue:kanji forKey:[kanji kanji]];
		[lookupByKeywordCache setValue:kanji forKey:[kanji keyword]];
	}
		
	[sortDescriptor release];
	[sortDescriptors release];
	[fetch release];
	
}

#pragma mark -
#pragma mark UISearchBarDelegate Methods

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText 
{
	UTF8Type type = [RTKUtils determineTextType: searchText];

    // clear the kanji 
    if ((searchText) && ([searchText length] == 0)) {
        [operationQueue cancelAllOperations];
        [filteredKanjiList release];
        filteredKanjiList = 0;
        [kanjiTableView reloadData];
        return;
    }
	
	switch (type) {
		case RTKTextTypeKanji: 
		{
			[self handleKanjiInput:searchText];
            break;
		}
		case RTKTextTypeRomaji:
		{
			[self handleRomajiInput:[searchBar text] withNewText:searchText];
            break;
		}
		case RTKTextTypeNumbers:
		{
            [self handleNumberInput:searchText];
            break;
		}
	}
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
	searchBar.showsScopeBar = YES;
	[searchBar sizeToFit];
	
	[searchBar setShowsCancelButton:YES animated:YES];
		
	return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
	searchBar.showsScopeBar = NO;
	[searchBar sizeToFit];
	
	[searchBar setShowsCancelButton:NO animated:YES];
	
	return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
}

// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

// called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController*)controller
{
	RTKLog(@"controllerWillChangeContent called");
}

#pragma mark -
#pragma mark UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [filteredKanjiList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RTKKanjiTableViewCell *cell = (RTKKanjiTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RTKKanjiTableViewCell"];
    if (cell == nil) {
		// load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"RTKKanjiTableViewCell" owner:self options:nil];
		// grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
		cell = [topLevelObjects objectAtIndex:0];
    }
	
	// load the kanji corresponding to this cell's row index
	Kanji *kanji = [filteredKanjiList objectAtIndex: indexPath.row];
	
	// set the kanji to the kanji label
	[[cell kanjiLabel] setText: [kanji kanji]];
	
	// set the right handle heisig card index number
	[[cell frameNumberLabel] setText: [NSString stringWithFormat:@"[%@]", [[kanji heisigNumber] stringValue]]];
    
	// create the styled matching label
	RTKMultipartLabel *matchingLabel = [cell matchingLabel];
		
	//create two labels for the matching label
	NSString *firstPart = [kanjiSearchBar text];

    if ([firstPart length] > [[kanji keyword] length]) {
        return cell;
    }
    
	if (([[NSScanner scannerWithString: firstPart] scanInt: nil]) || [firstPart isEqualToString: [kanji kanji]]) {
		[matchingLabel updateNumberOfLabels: 1];
		NSString *firstPart = [kanji keyword];
		[matchingLabel setText: firstPart andColor:[UIColor blackColor] forLabel:0];
	} else {
		[matchingLabel updateNumberOfLabels: 2];
		NSString *secondPart = [[kanji keyword] substringFromIndex: [firstPart length]];
		[matchingLabel setText: firstPart andColor:[UIColor blackColor] forLabel:0];
		[matchingLabel setText: secondPart andColor:[UIColor lightGrayColor] forLabel:1];
	}
	
	[cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
	
	return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[RTKManager sharedManager] setCurrentStudiedKanji: [filteredKanjiList objectAtIndex: [indexPath row]]];
	RTKKanjiDetailViewController *detailedViewController = [[RTKKanjiDetailViewController alloc] initWithNibName:@"RTKKanjiDetailViewController" bundle:nil];
	[[[RevTKDelegate sharedRevTKApplication] navigationController] pushViewController:detailedViewController animated:YES];
	[detailedViewController release];
	[self setPreviouslySelectedIndexPath: indexPath];
}

#pragma mark -
#pragma mark Synthesized Properties

@synthesize kanjiTableView;
@synthesize managedObjectContext;
@synthesize filteredKanjiList;
@synthesize previouslySelectedIndexPath;

@end

