//
//  TableViewData.h
//  XReader
//
//  Created by Pablo Collins on 1/30/11.
//  Copyright 2011 trickbot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TableViewSection, TableViewRow;

@interface TableViewData : NSObject {
    NSMutableArray *sections;
}

- (void)addSection:(TableViewSection *)s;
- (NSInteger)numberOfSections;
- (NSString *)titleForHeaderInSection:(NSInteger)section;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (TableViewSection *)section:(NSInteger)section;
- (TableViewRow *)rowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)titleForFooterInSection:(NSInteger)section;

@end
