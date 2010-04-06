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
	
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section;
- (void)controllerWillChangeContent:(NSFetchedResultsController*)controller;


@property (retain) IBOutlet UITableView *kanjiTableView;
@property (retain) NSFetchedResultsController *fetchedResultsController;
@property (retain) NSManagedObjectContext *managedObjectContext;
@end




