//
//  Cal.m
//  Allowance
//
//  Created by Pablo Collins on 7/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Cal.h"

@implementation Cal

+ (NSCalendar *)sharedInstance {
    static NSCalendar *me;
    if (me == nil) {
        me = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    return me;
}

+ (NSDate *)startDate {
    static NSDate *start;
    if (start == nil) {
        NSCalendar *cal = [Cal sharedInstance];
        NSDateComponents *cmp = [[NSDateComponents alloc] init];
        [cmp setYear:2010];
        [cmp setMonth:1];
        [cmp setDay:3];
        start = [cal dateFromComponents:cmp];
    }
    return start;
}

+ (NSUInteger)weekNumForDate:(NSDate *)d {
    NSDate *startDate = [Cal startDate];
    NSTimeInterval ti = [d timeIntervalSinceDate:startDate];
    int out = ti / (60*60*24*7);
    return out;
}

+ (NSDate *)dateForWeeknum:(NSUInteger)n {
    return [self dateForWeeknum:n andWeekday:1];
}

+ (NSDate *)dateForWeeknum:(NSUInteger)n andWeekday:(NSUInteger)w {
    NSTimeInterval ti = ((n * 7) + w - 1) * 60*60*24;
    return [NSDate dateWithTimeInterval:ti sinceDate:[Cal startDate]];
}

+ (NSInteger)currentWeek {
    return [Cal weekNumForDate:[NSDate date]];
}

+ (NSInteger)currentDay {
    NSCalendar *cal = [Cal sharedInstance];
    NSDateComponents *cmp = [cal components:(NSWeekdayCalendarUnit) fromDate:[NSDate date]];
    return [cmp weekday];
}

@end
