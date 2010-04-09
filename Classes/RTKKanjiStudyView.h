//
//  RTKKanjiStudyView.h
//  RevTK
//
//  Created by John Bradley on 4/5/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface RTKKanjiStudyView :  UIViewController<NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
	
	IBOutlet UITableView *kanjiTableView;
	IBOutlet UISearchBar *kanjiSearchBar;
	
	NSOperationQueue *operationQueue;
	
	NSManagedObjectContext *managedObjectContext;
	
@private
	/**
	 The main cache that has a frameNumber->kanjiDetails relationship
	 */
	NSArray *kanjiCache;
	
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
	
	NSArray	*filteredKanjiList;
	
	NSString *oldSearchString;
}

@property (retain) IBOutlet UITableView *kanjiTableView;
@property (retain) NSManagedObjectContext *managedObjectContext;
@property (retain) NSArray *filteredKanjiList;

@end




