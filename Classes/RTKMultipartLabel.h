//
//  RTKMultipartLabel.h
//  RevTK
//
//  Created by John Bradley on 4/5/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RTKMultipartLabel : UIView {
	IBOutlet UIView *containerView;
	IBOutlet NSMutableArray *labels;
}

-(void)updateNumberOfLabels:(int)numLabels;
-(void)setText:(NSString *)text forLabel:(int)labelNum;

-(void)setText:(NSString *)text andFont:(UIFont*)font forLabel:(int)labelNum;
-(void)setText:(NSString *)text andColor:(UIColor*)color forLabel:(int)labelNum;
-(void)setText:(NSString *)text andFont:(UIFont*)font andColor:(UIColor*)color forLabel:(int)labelNum;


@property (nonatomic, retain) IBOutlet UIView *containerView;
@property (nonatomic, retain) IBOutlet NSMutableArray *labels;

@end
