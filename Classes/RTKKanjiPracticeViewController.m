//
//  RTKKanjiPracticeViewController.m
//  RevTK
//
//  Created by John Bradley on 4/9/10.
//  Copyright 2010 J. Bradley & Associates, LLC.. All rights reserved.
//

#import "RTKKanjiPracticeViewController.h"
#import "RTKManager.h"
#import "Kanji.h"

@implementation RTKKanjiPracticeViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	Kanji *kanji = [[RTKManager sharedManager] currentStudiedKanji];
	[kanjiLabel setText: [kanji kanji]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    
    lastPoint = [touch locationInView:self.view];
    lastPoint.y += 20;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    mouseSwiped = YES;
    
    UITouch *touch = [touches anyObject];   
    CGPoint currentPoint = [touch locationInView:self.view];
    currentPoint.y += 20;
    
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[imageView image] drawInRect: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    [imageView setImage: UIGraphicsGetImageFromCurrentImageContext()];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [[imageView image] drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        [imageView setImage: UIGraphicsGetImageFromCurrentImageContext()];
        UIGraphicsEndImageContext();
    }
}

- (void)displayKanji:(id)sender
{
	int buttonIndex = [segmentedControl selectedSegmentIndex];
	
	[UIView beginAnimations:nil context:NULL];
	if (buttonIndex == 0) {	
		[UIView setAnimationDuration:0.5];
		 //makes text fade in to solid
		[kanjiLabel setAlpha: 0.2];
		[UIView commitAnimations];
	} else {
		[UIView setAnimationDuration:0.5];
		//makes text fade in to solid
		[kanjiLabel setAlpha: 0];
		[UIView commitAnimations];
		
	}
}

- (void)closePractice:(id)sender
{
    // pop this view and return to the previous view controller
    [self dismissModalViewControllerAnimated: YES];
}
- (void)clearImage:(id)sender
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDidStopSelector:@selector(clearImageFinished)];
    [imageView setAlpha: 0];
    
    [UIView commitAnimations];
}

- (void)clearImageFinished
{
    [imageView setImage: nil];
    [imageView setAlpha: 1];
}

- (void)didReceiveMemoryWarning 
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
