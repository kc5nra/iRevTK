//
//  RTKKanjiPracticeViewController.h
//  RevTK
//
//  Created by John Bradley on 4/9/10.
//  Copyright 2010 J. Bradley & Associates, LLC.. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RTKKanjiPracticeViewController : UIViewController {
	CGPoint lastPoint;
	BOOL mouseSwiped;
	IBOutlet UIImageView *imageView;
	IBOutlet UILabel *kanjiLabel;
	IBOutlet UISegmentedControl *segmentedControl;
}

- (void)displayKanji:(id)sender;


@end
