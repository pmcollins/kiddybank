//
//  Cal.h
//  Allowance
//
//  Created by Pablo Collins on 7/24/10.
//

#import <Foundation/Foundation.h>

@interface Cal : NSObject {}

+ (int)currentWeek;
+ (int)currentDay;
+ (NSUInteger)weekNumForDate:(NSDate *)d;
+ (NSDate *)dateForWeeknum:(NSUInteger)n andWeekday:(NSUInteger)w;
+ (NSDate *)dateForWeeknum:(NSUInteger)n;
+ (NSCalendar *)sharedInstance;

@end
