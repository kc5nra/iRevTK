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
#import "RTK.h"

// model
#import "Kanji.h"


@implementation RTKKanjiStudyView

#pragma mark -
#pragma mark UIView, Init, Dealloc

- (void)viewDidLoad {
	[super viewDidLoad];
	
	NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		 /*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
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

- (void)dealloc {
	[fetchedResultsController release];
	[managedObjectContext release];
	
    [super dealloc];
}

#pragma mark -
#pragma mark Search Bar

#define RTK_LEGAL_CHARACTERS	@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.-1234567890"

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	
//	NSCharacterSet *cs = [NSCharacterSet characterSetWithCharactersInString:RTK_LEGAL_CHARACTERS];
//	NSString *string = [[text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//	RTKLog(@"%@", text);
//	RTKLog(@"%@", string);
//	if([text isEqualToString:string])
//	{
//		UIAlertView *balert = [[UIAlertView alloc] initWithTitle:@"" message:@"Only arabic alphabets are allowed ! Please reset your keyboard to arabic" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//		[balert show];
//	}
//	return (![text isEqualToString:string]);
	
}

- (void)performFetchAndUpdateTable:(UISearchBar *)searchBar {
	NSString *searchText = [searchBar text];
	if ([searchText length] == 0) {
		[[fetchedResultsController fetchRequest] setPredicate: nil];
	} else {
		[NSFetchedResultsController deleteCacheWithName:nil];  
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(kanji like[cd] %@) OR (heisigNumber == %@) OR (keyword BEGINSWITH[cd] %@)", searchText, searchText, searchText];
		[[fetchedResultsController fetchRequest] setPredicate: predicate];
	}
	
	[fetchedResultsController performFetch: nil];
	[[self kanjiTableView] reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	[self performFetchAndUpdateTable: searchBar];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
	searchBar.showsScopeBar = YES;
	[searchBar sizeToFit];
	
	[searchBar setShowsCancelButton:YES animated:YES];
	
	[self performFetchAndUpdateTable: searchBar];
	
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
	[self performFetchAndUpdateTable: searchBar];
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
    return [[fetchedResultsController sections] count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
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
	Kanji *kanji = [fetchedResultsController objectAtIndexPath:indexPath];
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
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
	
	managedObjectContext = [[RTKManager sharedManager] managedObjectContext];
	
    /*
	 Set up the fetched results controller.
	 */
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Kanji" inManagedObjectContext:managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// Set the batch size to a suitable number.
	[fetchRequest setFetchBatchSize:3007];
	
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"heisigNumber" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"KanjiCache"];
	[self setFetchedResultsController: aFetchedResultsController];
	
	[[self fetchedResultsController] setDelegate: self];
	[aFetchedResultsController release];
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
	
	
	return fetchedResultsController;
}


#pragma mark -
#pragma mark Synthesized Properties

@synthesize kanjiTableView;
@synthesize fetchedResultsController;
@synthesize managedObjectContext;
@end

