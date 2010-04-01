//
//  RTKNewsStoryTableViewCell.m
//  RevTK
//
//  Based on WordPress Label
//  Created by Josh Bassett on 2/07/09.
//

#import "RTKNewsStoryTableViewCell.h"
#import "RTKVerticallyAlignedLabel.h"
#import "RTKNewsStory.h"
#import "RTKUtils.h"

#define PADDING                     5
#define CELL_PADDING                8

#define TOP_OFFSET                  CELL_PADDING
#define LEFT_OFFSET                 CELL_PADDING

#define NAME_FONT_SIZE              17
#define COMMENT_FONT_SIZE           13

#define COMMENT_LABEL_HEIGHT        40
#define COMMENT_LABEL_WIDTH         280

#define OTHER_LABEL_WIDTH           220
#define DATE_LABEL_HEIGHT           20
#define NAME_LABEL_HEIGHT           17
#define URL_LABEL_HEIGHT            15
#define POST_LABEL_HEIGHT           15

#define GRAVATAR_WIDTH              47
#define GRAVATAR_HEIGHT             47
#define GRAVATAR_LEFT_OFFSET        LEFT_OFFSET + GRAVATAR_WIDTH + CELL_PADDING
#define GRAVATAR_TOP_OFFSET         TOP_OFFSET + GRAVATAR_HEIGHT + PADDING


@interface RTKNewsStoryTableViewCell (Private)

- (void)updateLayout:(BOOL)editing;
- (void)addCheckButton;
- (void)addNameLabel;
- (void)addURLLabel;
- (void)addPostLabel;
- (void)addCommentLabel;
- (void)addGravatarImageView;

@end


@implementation RTKNewsStoryTableViewCell


- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
		
        [self addNameLabel];
        [self addURLLabel];
        [self addPostLabel];
        [self addCommentLabel];
        [self addGravatarImageView];
    }
	
    return self;
}

- (void)dealloc {
    [nameLabel release];
    [dateLabel release];
    [postLabel release];
    [commentLabel release];
    [gravatarImageView release];
    [super dealloc];
}


- (void)setNewsStory:(RTKNewsStory *)newsStory {
	
    NSString *author = @"ファブリス";
    nameLabel.text = author;
	
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd MMMM yyyy"];
	NSDate *newsStoryDate = [df dateFromString: [newsStory date]];
	
	NSTimeInterval timeInterval = [newsStoryDate timeIntervalSinceNow];
	NSString *timeSincePost = [RTKUtils convertIntervalToString:timeInterval];
	
	[dateLabel setText: timeSincePost];
	
    
    NSString *postTitle = [newsStory subject];
    [postLabel setText: postTitle];
	
    NSString *content = [newsStory text];
    [commentLabel setText: content];
	
}

#pragma mark Private Methods

- (void)updateLayout:(BOOL)editing {
    CGRect rect;
    int buttonOffset = 0;
    
    rect = gravatarImageView.frame;
    rect.origin.x = LEFT_OFFSET + buttonOffset;
    gravatarImageView.frame = rect;
    
    rect = nameLabel.frame;
    rect.origin.x = GRAVATAR_LEFT_OFFSET + buttonOffset;
    rect.size.width = OTHER_LABEL_WIDTH - buttonOffset;
    nameLabel.frame = rect;
    
    rect = dateLabel.frame;
    rect.origin.x = GRAVATAR_LEFT_OFFSET + buttonOffset;
    rect.size.width = OTHER_LABEL_WIDTH - buttonOffset;
    dateLabel.frame = rect;
    
    rect = postLabel.frame;
    rect.origin.x = GRAVATAR_LEFT_OFFSET + buttonOffset;
    rect.size.width = OTHER_LABEL_WIDTH - buttonOffset;
    postLabel.frame = rect;
    
    rect = [commentLabel frame];
    rect.origin.x = LEFT_OFFSET + buttonOffset;
    rect.size.width = COMMENT_LABEL_WIDTH - buttonOffset;
    [commentLabel setFrame: rect];
}

- (void)addGravatarImageView {
    CGRect rect = CGRectMake(LEFT_OFFSET, TOP_OFFSET, GRAVATAR_WIDTH, GRAVATAR_HEIGHT);
   // 
	gravatarImageView = [[UIImageView alloc] initWithFrame:rect];
	UIImage *myImage = [UIImage imageNamed: @"SmallKanji.gif"];
	[gravatarImageView setImage: myImage];
    [self.contentView addSubview:gravatarImageView];
	
}

- (void)addNameLabel {
    CGRect rect = CGRectMake(GRAVATAR_LEFT_OFFSET, TOP_OFFSET, OTHER_LABEL_WIDTH, NAME_LABEL_HEIGHT);
	
    nameLabel = [[UILabel alloc] initWithFrame:rect];
    nameLabel.font = [UIFont boldSystemFontOfSize:NAME_FONT_SIZE];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.highlightedTextColor = [UIColor whiteColor];
    nameLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
	
    [self.contentView addSubview:nameLabel];
}

- (void)addURLLabel {
    CGRect rect = CGRectMake(GRAVATAR_LEFT_OFFSET, nameLabel.frame.origin.y + NAME_LABEL_HEIGHT, OTHER_LABEL_WIDTH, URL_LABEL_HEIGHT);
	
    dateLabel = [[UILabel alloc] initWithFrame:rect];
    dateLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8];
    dateLabel.highlightedTextColor = [UIColor whiteColor];
    dateLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
	
    [self.contentView addSubview:dateLabel];
}

- (void)addPostLabel {
    CGRect rect = CGRectMake(GRAVATAR_LEFT_OFFSET, dateLabel.frame.origin.y + URL_LABEL_HEIGHT, OTHER_LABEL_WIDTH, POST_LABEL_HEIGHT);
    
    postLabel = [[UILabel alloc] initWithFrame:rect];
    postLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
    postLabel.backgroundColor = [UIColor clearColor];
    postLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8];
	postLabel.highlightedTextColor = [UIColor whiteColor];
    postLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    
    [self.contentView addSubview:postLabel];
}

- (void)addCommentLabel {
    CGRect rect = CGRectMake(LEFT_OFFSET, GRAVATAR_TOP_OFFSET, COMMENT_LABEL_WIDTH, COMMENT_LABEL_HEIGHT);
	
    commentLabel = [[RTKVerticallyAlignedLabel alloc] initWithFrame:rect];
    [commentLabel setFont: [UIFont systemFontOfSize:COMMENT_FONT_SIZE]];
	[commentLabel setBackgroundColor: [UIColor clearColor]];
	[commentLabel setTextColor: [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8]];
	[commentLabel setHighlightedTextColor: [UIColor whiteColor]];
	[commentLabel setAutoresizingMask: UIViewAutoresizingFlexibleRightMargin];
	[commentLabel setNumberOfLines: 2];
	[commentLabel setLineBreakMode: UILineBreakModeTailTruncation];
	
    [[self contentView] addSubview: commentLabel];
}

@end
