//
//  TxHistory.h
//  Allowance
//
//  Created by Pablo Collins on 7/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TxHistory : NSObject {
    NSArray *a;
    NSMutableArray *buckets;
    NSInteger lastWeek,firstWeek;
}

- (id)initWithTransactions:(NSArray *)a;
- (NSUInteger)count;
- (NSInteger)numberOfWeeks;
- (NSInteger)firstWeek;
- (NSInteger)lastWeek;
- (NSUInteger)transactionCountInBucket:(NSUInteger)n;
- (Transaction *)transactionAtIndexPath:(NSIndexPath *)indexPath;

@end
