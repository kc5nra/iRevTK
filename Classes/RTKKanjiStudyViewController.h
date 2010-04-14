//
//  RTKKanjiStudyView.h
//  RevTK
//
//  Created by John Bradley on 4/5/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

/**
 Kanji Study View.
 The main view for reviewing Kanji and story management.
 */
@interface RTKKanjiStudyViewController :  UIViewController<NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
	
	/**
	 Reference to the main TableView containing the results of the current search.
	 */
	IBOutlet UITableView *kanjiTableView;
	/**
	 Reference to the searchbar.
	 */
	IBOutlet UISearchBar *kanjiSearchBar;
	
	/**
	 Operation Queue for handling all asynchronous kanji lookups.
	 */
	NSOperationQueue *operationQueue;
	
	/**
	 Managed Object Context for synchronizing the fetches.
	 */
	NSManagedObjectContext *managedObjectContext;
	
@private
	/**
	 The main cache that has a frameNumber->kanjiDetails relationship
	 */
	NSArray *kanjiCache;
	
    /**
     The main array containing the filtered results
     */
    NSArray	*filteredKanjiList;
    
	/**
	 This contains a dictionary that refers to the objects in the kanjiCache with a
	 kanji->kanjiDetails relationship.  The kanjiDetails is a reference to the main cache.
	 */
	NSDictionary *lookupByKanjiCache;
	
	/**
	 This contains a dictionary that refers to the objects in the kanjiCache with a
	 keyword->kanjiDetails relationship.  The kanjiDetails is a reference to the main cache.
	 */
	NSDictionary *lookupByKeywordCache;
    
	// Currently unused
	NSDictionary *lookupByOnYomiCache;
	NSDictionary *lookupByKunYomiCache;

	NSIndexPath	 *previouslySelectedIndexPath;
}

@property (retain) IBOutlet UITableView *kanjiTableView;
@property (retain) NSManagedObjectContext *managedObjectContext;
@property (retain) NSArray *filteredKanjiList;
@property (retain) NSIndexPath *previouslySelectedIndexPath;

@end




