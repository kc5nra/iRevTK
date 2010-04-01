//
//  RTKNewsStoryTableViewCell.m
//  RevTK
//
//  Based on WordPress Label
//  Created by Josh Bassett on 2/07/09.
//

#import <Foundation/Foundation.h>

@class RTKVerticallyAlignedLabel;
@class RTKNewsStory;

#define COMMENT_ROW_HEIGHT 100

@interface RTKNewsStoryTableViewCell : UITableViewCell {
	
    UILabel *nameLabel;
    UILabel *dateLabel;
    UILabel *postLabel;
    RTKVerticallyAlignedLabel *commentLabel;
    UIImageView *gravatarImageView;
	
    BOOL checked;
}

- (void)setNewsStory:(RTKNewsStory *)newsStory;

@end
