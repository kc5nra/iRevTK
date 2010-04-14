//
//  RTKPredicateSearchOperation.m
//  RevTK
//
//  Created by ジョン ブラッドリー on 4/9/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKPredicateSearchOperation.h"
#import "RTK.h"

@implementation RTKPredicateSearchOperation

- (id)initWithPredicate:(NSPredicate *)predicate withArray:(NSArray *)array delegate:(id)del
{
    if (![super init]) {
        return nil;
    }
    
    [self setFilterPredicate: predicate];
    [self setArrayToSearch: array];
    [self setDelegate: del];
    
    return self;
}

- (void)main
{
    NSArray *result = [arrayToSearch filteredArrayUsingPredicate: filterPredicate];
    if (![self isCancelled]) {
        [delegate performSelectorOnMainThread:@selector(updateFilteredArray:) withObject:result waitUntilDone:YES];
    }
}

- (void)cancel
{
    [super cancel];
}

#pragma mark -
#pragma mark NSObject Methods

- (void)dealloc
{
    [arrayToSearch release];
    [filterPredicate release];
    [delegate release];
    [super dealloc];
}

@synthesize arrayToSearch;
@synthesize filterPredicate;
@synthesize delegate;

@end
