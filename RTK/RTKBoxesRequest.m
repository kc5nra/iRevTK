//
//  RTKBoxesRequest.m
//  RevTK
//
//  Created by John Bradley on 4/1/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKBoxesRequest.h"
#import "RTKBoxes.h"

@implementation RTKBoxesRequest

+ (id)get
{
	RTKBoxesRequest *request = [[self alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/api.php/boxes",kRTKApiRequestURL]]];
	return request;
}

#pragma mark -
#pragma mark Overloaded RTKApiRequest methods

- (id) createResponseObjectInstance {
	return [RTKBoxes alloc];
}

@end
