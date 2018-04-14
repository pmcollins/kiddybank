//
//  TableViewSection.m
//  XReader
//
//  Created by Pablo Collins on 1/30/11.
//  Copyright 2011 trickbot. All rights reserved.
//

#import "TableViewSection.h"

@implementation TableViewSection

@synthesize title, footerTitle;

- (id)initWithTitle:(NSString *)t {
    self = [super init];
    title = t;
    rows = [[NSMutableArray alloc] init];
    return self;
}

- (void)addRow:(TableViewRow *)row
{
    [rows addObject:row];
}

- (TableViewRow *)rowAtIndex:(NSInteger)i
{
    return [rows objectAtIndex:i];
}

- (NSInteger)rowCount {
    return [rows count];
}


@end
