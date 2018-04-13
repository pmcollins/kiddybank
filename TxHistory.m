//
//  TxHistory.m
//  Allowance
//
//  Created by Pablo Collins on 7/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TxHistory.h"

@implementation TxHistory

- (void)setup {
    int n = [self numberOfWeeks];
    buckets = [[NSMutableArray alloc] initWithCapacity:n];
    if ([a count] == 0) {
        return;
    }
    for (int i = 0; i < n; i++) {
        [buckets addObject:[[NSMutableArray alloc] init]];
    }
    int lastWk = [self lastWeek];
    for (Transaction *t in a) {
        NSUInteger weekNum = [Cal weekNumForDate:t.transactionDate];
        int bucketNo = lastWk - weekNum;
        NSMutableArray *bucket = [buckets objectAtIndex:bucketNo];
        [bucket addObject:t];
    }
}

- (id)initWithTransactions:(NSArray *)arry {
    self = [super init];
    a = arry;
    [self setup];
    return self;
}

- (NSUInteger)transactionCountInBucket:(NSUInteger)n {
    return [a count] == 0 ? 0 : [[buckets objectAtIndex:n] count];
}

- (Transaction *)transactionAtIndexPath:(NSIndexPath *)indexPath {
    if ([a count] == 0) {
        return nil;
    }
    NSMutableArray *bucket = [buckets objectAtIndex:[indexPath section]];
    return [bucket objectAtIndex:[indexPath row]];
}

- (NSUInteger)count {
    return [a count];
}

- (Transaction *)earliestTransaction {
    return [a lastObject];
}

- (Transaction *)latestTransaction {
    return [a objectAtIndex:0];
}

- (NSInteger)firstWeek {
    if (firstWeek == 0) {
        Transaction *startTx = [self earliestTransaction];
        NSDate *startDate = startTx.transactionDate;
        firstWeek = [Cal weekNumForDate:startDate];
    }
    return firstWeek;
}

- (NSInteger)lastWeek {
    if (lastWeek == 0) {
        Transaction *endTx = [self latestTransaction];
        NSDate *endDate = endTx.transactionDate;
        lastWeek = [Cal weekNumForDate:endDate];
    }
    return lastWeek;
}

- (NSInteger)numberOfWeeks {
    return [a count] == 0 ? 0 : [self lastWeek] - [self firstWeek] + 1;
}


@end
