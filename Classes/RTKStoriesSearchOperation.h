//
//  RTKStoriesSearchOperation.h
//  RevTK
//
//  Created by ジョン ブラッドリー on 4/13/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Kanji;

/**
 Stories Search Operation.
 This does a asynchronous stories api request to retrieve the latest news entries. 
 */
@interface RTKStoriesSearchOperation : NSOperation {
    /**
     The Kanji to query stories for.
     */
    Kanji *kanji;
    /**
     The delegate to notify when the filter has completed.
     */
    id delegate;
}

/**
 Creates a RTKStoriesSearchOperation with the specified delegate.
 @param del the delegate to notify when the operation is complete
 @returns an instance of RTKStoriesSearchOperation
 */
- (id)initWithKanji: (Kanji *)kanjiToQuery delegate: (id)del;

@property (retain) id delegate;
@property (retain) Kanji *kanji;
@end
