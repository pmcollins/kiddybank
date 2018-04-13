//
//  TableViewSection.h
//  XReader
//
//  Created by Pablo Collins on 1/30/11.
//  Copyright 2011 trickbot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewData.h"
#import "TableViewRow.h"

@interface TableViewSection : NSObject {
	NSString *title, *footerTitle;
	//NSMutableArray *handlers;
	NSMutableArray *rows;
}

@property (nonatomic, strong) NSString *title, *footerTitle;

- (id)initWithTitle:(NSString *)t;
- (NSInteger)rowCount;

- (void)addRow:(TableViewRow *)row;
- (TableViewRow *)rowAtIndex:(NSInteger)i;

@end
