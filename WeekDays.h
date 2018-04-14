//
//  WeekDays.h
//  Allowance
//
//  Created by Pablo Collins on 6/27/10.
//

#import <Foundation/Foundation.h>


@interface WeekDays : NSObject {
}

+ (NSString *)nameForNum:(NSNumber *)n;
+ (NSNumber *)numForName:(NSString *)name;

@end
