//
//  RTKStoriesSearchOperation.m
//  RevTK
//
//  Created by ジョン ブラッドリー on 4/13/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKStoriesSearchOperation.h"
#import "Kanji.h"
#import "RTKCardStoriesRequest.h"
#import "RTKStories.h"

@implementation RTKStoriesSearchOperation

- (id)initWithKanji:(Kanji *)kanjiToQuery delegate: (id)del
{
    if (![super init]) {
        return nil;
    }
    
    [self setDelegate: del];
    [self setKanji: kanjiToQuery];
    
    return self;
}

- (void)main
{
   
    RTKCardStoriesRequest *request = [RTKCardStoriesRequest get: [[kanji heisigNumber] intValue]];
    [request startSynchronous];
    
    RTKStories *stories = (RTKStories *)[request object];
    if (![self isCancelled]) {
        [delegate performSelectorOnMainThread:@selector(updateStories:) withObject:stories waitUntilDone:YES];
    }
    
    [request release];
}

- (void)cancel
{
    [super cancel];
}

#pragma mark -
#pragma mark NSObject Methods

- (void)dealloc
{
    [delegate release];
    [super dealloc];
}

@synthesize delegate;
@synthesize kanji;

@end
