//
//  RTKKanjiStudyView.m
//  RevTK
//
//  Created by John Bradley on 4/5/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKKanjiStudyView.h"
#import "RTKManager.h"
#import "RTKKanjiTableViewCell.h"
#import "RTKMultipartLabel.h"
#import "RTKUtils.h"
#import "RTK.h"

// model
#import "Kanji.h"

/**
 Kanji Study View Caching.
 This category contains all the code related to the caching of kanji for
 quicker look ups.
 */
@interface RTKKanjiStudyView (Cache)
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

@end


@implementation RTKKanjiStudyView

#pragma mark -
#pragma mark UIView, Init, Dealloc

- (void)viewDidLoad {
	[super viewDidLoad];
	
	operationQueue = [[NSOperationQueue alloc] init];
	[operationQueue setMaxConcurrentOperationCount: 1];
	
	[self setManagedObjectContext: [[RTKManager sharedManager] managedObjectContext]];
	[self buildCache];

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

#pragma mark -
#pragma mark Cache

- (void)buildLookupByKeywordCache 
{
	
}
- (void)buildLookupByKanjiCache 
{
	
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
	
	RTKLog(@"Kanji!!! %@ !!!!", [[results objectAtIndex:0] kanji]);
	
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
#pragma mark Search Bar

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	return YES;
}

- (void)asynchronousFilter
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	
	[pool release];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	UTF8Type type = [RTKUtils determineTextType: searchText];

	NSArray *arrayToSearch;
	NSPredicate *predicateToUse;
	
	switch (type) {
		case RTKTextTypeKanji: 
		{
			if (filteredKanjiList) {
				[operationQueue cancelAllOperations];
				[filteredKanjiList release];
				filteredKanjiList = 0;
			}
			
			if ([searchText length] > 1) {
				break;
			}
			
			// fast enough not to need background thread
			filteredKanjiList = [[NSArray arrayWithObject: [lookupByKanjiCache valueForKey: searchText]] retain];
			break;
		}
		case RTKTextTypeRomaji:
		{
			if (oldSearchString && ([oldSearchString length] > 0)) {
				if ([oldSearchString length] < [searchText length]) {
					int oldSearchStringLength = [oldSearchString length];
					NSString *searchTextCut = [searchText substringToIndex: oldSearchStringLength];
					
					// use the existing filtered list
					if ([searchTextCut isEqualToString: oldSearchString]) {
					
						if (filteredKanjiList) {
							[operationQueue cancelAllOperations];
							[filteredKanjiList release];
							filteredKanjiList = 0;
						}
						
						arrayToSearch = filteredKanjiList;
						predicateToUse = [NSPredicate predicateWithFormat:@"(keyword BEGINSWITH[cd] %@)", searchText];
						break;
					}
				} else {
					// same file, do nothing
					if ([searchText isEqualToString: oldSearchString]) {
						return;
					}
				}
			}
			
			if (filteredKanjiList) {
				[operationQueue cancelAllOperations];
				[filteredKanjiList release];
				filteredKanjiList = 0;
			}
			
			predicateToUse = [NSPredicate predicateWithFormat:@"(keyword BEGINSWITH[cd] %@)", searchText];
			arrayToSearch = kanjiCache;
			break;
		}
		case RTKTextTypeNumbers:
		{
			if (filteredKanjiList) {
				[operationQueue cancelAllOperations];
				[filteredKanjiList release];
				filteredKanjiList = 0;
			}
			
			// at this point this integer has been validated by determineTextType		
			// subtract one because it is a 0-origin array
			int intValue = [searchText intValue] - 1;
			
			if ((intValue >= 0) && (intValue < [kanjiCache count])) {
				filteredKanjiList = [[NSArray arrayWithObject: [kanjiCache objectAtIndex: intValue]] retain];
			}
			break;
		}
	}
	
	// the user deleted a character, and the searchText became 0 length
	if ([searchText length] == 0) {
		// if we removed all the text, cancel the operations just in case
		[operationQueue cancelAllOperations];
		if (filteredKanjiList) {
			[filteredKanjiList release];
			filteredKanjiList = 0;
		}
	}
	
	if (oldSearchString) {
		[oldSearchString release];
		oldSearchString = 0;
	}
	
	oldSearchString = [searchText retain];
	
	if (filteredKanjiList) {
		[kanjiTableView reloadData];
	} else {

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
#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController*)controller
{
	RTKLog(@"controllerWillChangeContent called");
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return [[fetchedResultsController sections] count];
	return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
//    return [sectionInfo numberOfObjects];
	return [filteredKanjiList count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RTKKanjiTableViewCell *cell = (RTKKanjiTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RTKKanjiTableViewCell"];
    if (cell == nil) {
		// Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"RTKKanjiTableViewCell" owner:self options:nil];
		// Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
		cell = [topLevelObjects objectAtIndex:0];
    }
	
    
	// Configure the cell.
	//Kanji *kanji = [fetchedResultsController objectAtIndexPath:indexPath];
	Kanji *kanji = [filteredKanjiList objectAtIndex: indexPath.row];
	
	[[cell kanjiLabel] setText: [kanji kanji]];
	RTKMultipartLabel *matchingLabel = [cell matchingLabel];
	
	
	[[cell frameNumberLabel] setText: [NSString stringWithFormat:@"[%@]", [[kanji heisigNumber] stringValue]]];
	
	NSString *firstPart = [kanjiSearchBar text];
	
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
	
	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}



#pragma mark -
#pragma mark Synthesized Properties

@synthesize kanjiTableView;
@synthesize managedObjectContext;
@synthesize filteredKanjiList;

@end

