//
//  RTKCardStoriesRequest.m
//  RevTK
//
//  Created by ジョン ブラッドリー on 4/13/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKCardStoriesRequest.h"
#import "RTKStories.h"

@implementation RTKCardStoriesRequest

+ (RTKCardStoriesRequest *)get:(int)cardId
{
	RTKCardStoriesRequest *request = 
        [[self alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/api.php/cards/%d/stories",kRTKApiRequestURL, cardId]]];
	return request;
}

#pragma mark -
#pragma mark Overloaded RTKApiRequest methods

- (id) createResponseObjectInstance {
	return [RTKStories alloc];
}

@end
