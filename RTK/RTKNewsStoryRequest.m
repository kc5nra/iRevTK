//
//  RTKNewsStoryRequest.m
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKNewsStoryRequest.h"
#import "RTKNewsStory.h"

@implementation RTKNewsStoryRequest

+ (id)get:(int)newsStoryId
{
	RTKNewsStoryRequest *request = [[self alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/api.php/news/%d",kRTKApiRequestURL, newsStoryId]]];
	return request;
}

- (id) createResponseObjectInstance {
	return [RTKNewsStory alloc];
}

@end
