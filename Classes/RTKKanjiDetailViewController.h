//
//  RTKKanjiDetailViewController.h
//  RevTK
//
//  Created by John Bradley on 4/9/10.
//  Copyright 2010 J. Bradley & Associates, LLC.. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RTKStoriesSearchOperation;
@class RTKStories;
@class Kanji;

/**
 Kanji Study Detail View.
 This view is for setting a particular story for a kanji and allows the user to open a screen for practicing kanji.
 */
@interface RTKKanjiDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
	/**
     Reference to the button that when pressed brings up a screen for practicing kanji.
     */
    IBOutlet UIButton *practiceButton;
    
    /**
     Reference to the label that displays the keyword.
     */
	IBOutlet UILabel *keywordLabel;
    
    /**
     Reference to the label that displays the kanji.
     */
	IBOutlet UILabel *kanjiLabel;
    
    /**
     Reference to the label that displays the story.
     */
	IBOutlet UILabel *storyLabel;
    
    /**
     Reference to the table containing the top stories aquired from the public api.
     */
	IBOutlet UITableView *storiesTableView;
    
    IBOutlet UIView *loadingView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    
    /**
	 Operation Queue for handling all asynchronous kanji lookups.
	 */
	NSOperationQueue *operationQueue;
    
    /**
     The list of stories used to populate the story table view.
     */
    NSArray *storyArray;
    
    Kanji *kanji;
}

/**
 Event handler for when the practiceButton is clicked.
 */
- (void)practice:(id)sender;

/**
 Event handler for when an update of the stories table is requested.
 */
- (void)updateStories:(RTKStories *)stories;

- (void)refreshStories:(id)result;

@end
