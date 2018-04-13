//
//  WeekDays.m
//  Allowance
//
//  Created by Pablo Collins on 6/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WeekDays.h"

@implementation WeekDays

+ (NSArray *)names {
    static NSArray *names;
    if (names == nil) {
        names = [[NSArray alloc] initWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",nil];
    }
    return names;
}

+ (NSArray *)numbers {
    NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:7];
    for (int i = 1; i < 7; i++) {
        [a addObject:[NSNumber numberWithInt:i]];
    }
    return a;
}

+ (NSDictionary *)index {
    static NSDictionary *index;
    if (index == nil) {
        [NSDictionary dictionaryWithObjects:[self names] forKeys:[self numbers]];
    }
    return index;
}

+ (NSString *)nameForNum:(NSNumber *)n {
    return [[self names] objectAtIndex:[n unsignedIntValue]-1];
}

+ (NSNumber *)numForName:(NSString *)name {
    return [[self index] objectForKey:name];
}

@end
