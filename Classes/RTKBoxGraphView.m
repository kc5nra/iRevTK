//
//  RTKBoxGraphView.m
//  RevTK
//
//  Created by John Bradley on 4/1/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKBoxGraphView.h"


@implementation RTKBoxGraphView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect    myFrame = self.bounds;
	
    CGContextSetLineWidth(context, 10);
	
    [[UIColor redColor] set];
    UIRectFrame(myFrame);
}


@end
