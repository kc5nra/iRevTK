//
//  RTKPredicateSearchOperation.h
//  RevTK
//
//  Created by ジョン ブラッドリー on 4/9/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RTKPredicateSearchOperation : NSOperation {
    NSPredicate *filterPredicate;
    NSArray *arrayToSearch;
    id delegate;
}

- (id)initWithPredicate:(NSPredicate *)predicate withArray:(NSArray *)array delegate:(id)del;

@property (retain) NSPredicate  *filterPredicate;
@property (retain) NSArray      *arrayToSearch;
@property (retain) id           delegate;

@end
