//
//  RTKBoxesViewController.m
//  RevTK
//
//  Created by John Bradley on 4/1/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKBoxesViewController.h"
#import "RTKBoxesRequest.h"
#import "RTKBoxes.h"
#import "RTKBoxGraphView.h"
#import "RTKManager.h"
#import "RTKSimpleBox.h"
#import "RevTKDelegate.h"
#import "QuartzCore/QuartzCore.h"

@implementation RTKBoxesViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// margin is 10% of the barWidth
static const float kRTKBoxGraphBarMargin = 0.1;

- (void)loadView {
//	float tabBarHeight = [RevTKDelegate sharedRevTKApplication].tabBarController.tabBar.bounds.size.height;
//	UIView *initialView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 320, 480-tabBarHeight )];
//	[self setView: initialView];
//	CGRect initialBounds = 	[[self view] bounds];
//	
//	float clientWidth = initialBounds.size.width;
//	float clientHeight = initialBounds.size.height;
//	
//	// we need to create 8 bar graphs
//	float barWidth = clientWidth / 8;
//	// calculate the margin for one side, remember it is applied to the left AND right, so divide by 2
//	float barWidthMargin = (barWidth * kRTKBoxGraphBarMargin) / 2;
//	// adjust the bar width to take margin into account
//	float barWidthMinusMargin = barWidth - (2 * barWidthMargin);
//	
//	NSArray* boxes = [[[RTKManager sharedManager] boxes] boxes];
//	
//	for (int i = 0; i < 8; i++) {
//		CGRect rect;
//		
//		rect.size.height = 1;;
//		rect.size.width = barWidthMinusMargin;
//		
//		rect.origin.x = (i * barWidth) + barWidthMargin;
//		rect.origin.y = [[self view] bounds].origin.y;
//		
//		RTKBoxGraphView *subView = [[RTKBoxGraphView alloc] initWithFrame: rect];
//		for (RTKSimpleBox *box in boxes) {
//			if ([box boxId] == i + 1) {
//				[subView setSimpleBox: box];
//			}
//		}
//		
//		[subView setBackgroundColor: [UIColor blueColor]];
//		[[self view] addSubview:subView];
//		
//	}	
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
