//
//  RTKNewsRequest.m
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKNewsRequest.h"
#import "RTKNewsStories.h"

@implementation RTKNewsRequest

+ (id)get
{
	RTKNewsRequest *request = [[self alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/api.php/news",kRTKApiRequestURL]]];
	return request;
}

#pragma mark -
#pragma mark Overloaded RTKApiRequest methods

- (id) createResponseObjectInstance {
	return [RTKNewsStories alloc];
}

@end
