//
//  Review.h
//  RevTK
//
//  Created by John Bradley on 4/5/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Kanji;

@interface Review :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * successCount;
@property (nonatomic, retain) NSNumber * leitnerBox;
@property (nonatomic, retain) NSDate * lastReview;
@property (nonatomic, retain) NSNumber * totalReviews;
@property (nonatomic, retain) NSNumber * failureCount;
@property (nonatomic, retain) NSDate * expiredDate;
@property (nonatomic, retain) Kanji * heisigNumber;

@end



