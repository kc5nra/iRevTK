//
//  RTKVerticallyAlignedLabel.h
//  RevTK
//
//  Created by John Bradley on 3/31/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
	VerticalAlignmentTop = 0, // default
	VerticalAlignmentMiddle,
	VerticalAlignmentBottom,
} VerticalAlignment;

@interface RTKVerticallyAlignedLabel : UILabel
{
@private
	VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

@end
