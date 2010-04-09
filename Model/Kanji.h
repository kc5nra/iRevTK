//
//  Kanji.h
//  RevTK
//
//  Created by John Bradley on 4/5/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Kanji :  NSManagedObject  

@property (nonatomic, retain) NSString * onYomi;
@property (nonatomic, retain) NSNumber * lessonNumber;
@property (nonatomic, retain) NSNumber * heisigNumber;
@property (nonatomic, retain) NSNumber * strokeCount;
@property (nonatomic, retain) NSString * kanji;
@property (nonatomic, retain) NSString * keyword;

@end



