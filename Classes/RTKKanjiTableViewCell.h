//
//  RTKKanjiTableViewCell.h
//  RevTK
//
//  Created by John Bradley on 4/5/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTKMultipartLabel;

@interface RTKKanjiTableViewCell : UITableViewCell {
	IBOutlet UILabel *kanjiLabel;
	IBOutlet UILabel *frameNumberLabel;
	IBOutlet RTKMultipartLabel *matchingLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *kanjiLabel;
@property (nonatomic, retain) IBOutlet UILabel *frameNumberLabel;
@property (nonatomic, retain) IBOutlet RTKMultipartLabel *matchingLabel;
@end
