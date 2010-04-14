//
//  RTKPredicateSearchOperation.h
//  RevTK
//
//  Created by ジョン ブラッドリー on 4/9/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Predicate Search Operation.
 This does a asynchronous filter on an array with a predicate and notifies the delegate when it has completed.
 */
@interface RTKPredicateSearchOperation : NSOperation {
    /**
     The predicate used to filter the array.
     */
    NSPredicate *filterPredicate;
    
    /**
     The original unmodified array that the filter is applied to.
     */
    NSArray *arrayToSearch;
    
    /**
     The delegate to notify when the filter has completed.
     */
    id delegate;
}

/**
 Creates a RTKPredicateSearchOperation with the specified predicate, array and delegate.
 @param predicate the predicate used to filter the array
 @param array the array to apply to the filter to
 @param del the delegate to notify when the filter has completed
 @returns an instance of RTKPredicateSearchOperation
 */
- (id)initWithPredicate:(NSPredicate *)predicate withArray:(NSArray *)array delegate:(id)del;

@property (retain) NSPredicate  *filterPredicate;
@property (retain) NSArray      *arrayToSearch;
@property (retain) id           delegate;

@end
