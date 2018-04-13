//
//  WeekDays.h
//  Allowance
//
//  Created by Pablo Collins on 6/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WeekDays : NSObject {
}

+ (NSString *)nameForNum:(NSNumber *)n;
+ (NSNumber *)numForName:(NSString *)name;

@end
