//
//  RTKApiKeyRequest.m
//  RevTK
//
//  Created by John Bradley on 3/30/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKApiKeyRequest.h"
#import "RTKApiKey.h"

@implementation RTKApiKeyRequest

+ (RTKApiKeyRequest *)get: (NSString *)username withPassword:(NSString *)password
{
	RTKApiKeyRequest *request = [[self alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/api.php/rest/apiKey",kRTKApiRequestURL]]];
	[request setUsername: username];
	[request setPassword: password];
	return request;
}

#pragma mark -
#pragma mark Overloaded RTKApiRequest methods

- (id) createResponseObjectInstance {
	return [RTKApiKey alloc];
}

@end
