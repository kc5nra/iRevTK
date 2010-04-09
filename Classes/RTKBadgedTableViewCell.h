//
//  RTKBadgedTableViewCell.h
//  RevTK
//
//  Created by John Bradley on 4/8/10.
//  Copyright 2010 J. Bradley & Associates, LLC.. All rights reserved.
//
//	Based off of http://github.com/tmdvs/TDBadgedCell/
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface RTKBadgeTableViewCellBadgeView : UIView
{
	NSInteger width;
	NSInteger badgeNumber;
	
	CGSize numberSize;
	UIFont *font;
	NSString *countString;
	UITableViewCell *parent;
	
	UIColor *badgeColor;
	UIColor *badgeColorHighlighted;
	
}

@property (readonly)			NSInteger			width;
@property						NSInteger			badgeNumber;
@property (nonatomic,retain)	UITableViewCell		*parent;
@property (nonatomic, retain)	UIColor				*badgeColor;
@property (nonatomic, retain)	UIColor				*badgeColorHighlighted;

@end

@interface RTKBadgedTableViewCell : UITableViewCell {
	NSInteger badgeNumber;
	RTKBadgeTableViewCellBadgeView *badge;
	UIColor *badgeColor;
	UIColor *badgeColorHighlighted;
}

@property						NSInteger						badgeNumber;
@property (readonly, retain)	RTKBadgeTableViewCellBadgeView	*badge;
@property (nonatomic, retain)	UIColor							*badgeColor;
@property (nonatomic, retain)	UIColor							*badgeColorHighlighted;

@end
