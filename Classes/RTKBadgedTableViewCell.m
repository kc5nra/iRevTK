//
//  RTKBadgedTableViewCell.m
//  RevTK
//
//  Created by John Bradley on 4/8/10.
//  Copyright 2010 J. Bradley & Associates, LLC.. All rights reserved.
//
//	Based off of http://github.com/tmdvs/TDBadgedCell/
//

#import "RTKBadgedTableViewCell.h"

@implementation RTKBadgeTableViewCellBadgeView

- (id) initWithFrame:(CGRect)frame
{
	
	if (self = [super initWithFrame:frame])
	{
		font = [UIFont boldSystemFontOfSize: 14];
		[font retain];
		self.backgroundColor = [UIColor clearColor];
	}
	
	return self;
	
}


- (void) drawRect:(CGRect)rect
{
	
	countString = [NSString stringWithFormat: @"%d", self.badgeNumber];
	[countString retain];
	
	numberSize = [countString sizeWithFont: font];
	
	width = numberSize.width + 16;
	
	CGRect bounds = CGRectMake(0 , 0, numberSize.width + 16 , 18);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	float radius = bounds.size.height / 2.0;
	
	CGContextSaveGState(context);
	
	if(parent.highlighted || parent.selected)
	{
		UIColor *col;
		
		if(self.badgeColorHighlighted)
			col = self.badgeColorHighlighted;
		else
			col = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.000];
		
		CGContextSetFillColorWithColor(context, [col CGColor]);
	}
	else
	{
		UIColor *col;
		
		if(self.badgeColor)
			col = self.badgeColor;
		else
			col = [UIColor colorWithRed:0.530 green:0.600 blue:0.738 alpha:1.000];
		
		CGContextSetFillColorWithColor(context, [col CGColor]);
	}
	
	CGContextBeginPath(context);
	CGContextAddArc(context, radius, radius, radius, M_PI / 2 , 3 * M_PI / 2, NO);
	CGContextAddArc(context, bounds.size.width - radius, radius, radius, 3 * M_PI / 2, M_PI / 2, NO);
	CGContextClosePath(context);
	CGContextFillPath(context);
	CGContextRestoreGState(context);
	
	bounds.origin.x = (bounds.size.width - numberSize.width) / 2 +0.5;
	
	CGContextSetBlendMode(context, kCGBlendModeClear);
	
	[countString drawInRect: bounds withFont: font];
	
}

- (void) dealloc
{
	[super dealloc];
	[font release];
	[countString release];
}

@synthesize width;
@synthesize badgeNumber;
@synthesize parent;
@synthesize badgeColor;
@synthesize badgeColorHighlighted;

@end


@implementation RTKBadgedTableViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		badge = [[RTKBadgeTableViewCellBadgeView alloc] initWithFrame:CGRectZero];
		[badge setParent:self];
		
		//redraw cells in accordance to accessory
		float version = [[[UIDevice currentDevice] systemVersion] floatValue];
		
		if (version <= 3.0)
			[self addSubview:self.badge];
		else 
			[self.contentView addSubview:self.badge];
		
		
		[self.badge setNeedsDisplay];
		
		[badge release];
    }
    return self;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	if(self.badgeNumber > 0)
	{
		//force badges to hide on edit.
		if(self.editing)
			[self.badge setHidden:YES];
		else
			[self.badge setHidden:NO];
		
		
		CGSize badgeSize = [[NSString stringWithFormat: @"%d", self.badgeNumber] sizeWithFont:[UIFont boldSystemFontOfSize: 14]];
		
		float version = [[[UIDevice currentDevice] systemVersion] floatValue];
		
		CGRect badgeframe;
		
		if (version <= 3.0)
		{
			badgeframe = CGRectMake(self.contentView.frame.size.width - (badgeSize.width+16), round((self.contentView.frame.size.height - 18) / 2), badgeSize.width+16, 18);
		}
		else
		{
			badgeframe = CGRectMake(self.contentView.frame.size.width - (badgeSize.width+16) - 10, round((self.contentView.frame.size.height - 18) / 2), badgeSize.width+16, 18);
		}
		
		[self.badge setFrame:badgeframe];
		[badge setBadgeNumber:self.badgeNumber];
		[badge setParent:self];
		
		if ((self.textLabel.frame.origin.x + self.textLabel.frame.size.width) >= badgeframe.origin.x)
		{
			CGFloat badgeWidth = self.textLabel.frame.size.width - badgeframe.size.width - 10.0;
			
			self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, badgeWidth, self.textLabel.frame.size.height);
		}
		
		//set badge highlighted colours or use defaults
		if(self.badgeColorHighlighted)
			badge.badgeColorHighlighted = self.badgeColorHighlighted;
		else 
			badge.badgeColorHighlighted = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.000];
		
		//set badge colours or impose defaults
		if(self.badgeColor)
			badge.badgeColor = self.badgeColor;
		else
			badge.badgeColor = [UIColor colorWithRed:0.530 green:0.600 blue:0.738 alpha:1.000];
	}
	else
	{
		[self.badge setHidden:YES];
	}
	
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
	[super setHighlighted:highlighted animated:animated];
	[badge setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	[badge setNeedsDisplay];
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated
{
	[super setEditing:editing animated:animated];
	
	if (editing) {
		badge.hidden = YES;
		[badge setNeedsDisplay];
		[self setNeedsDisplay];
	}
	else 
	{
		badge.hidden = NO;
		[badge setNeedsDisplay];
		[self setNeedsDisplay];
	}
}


- (void)dealloc {
	[badge release];
	[badgeColor release];
	[badgeColorHighlighted release];
    [super dealloc];
}

@synthesize badgeNumber;
@synthesize badge;
@synthesize badgeColor;
@synthesize badgeColorHighlighted;

@end