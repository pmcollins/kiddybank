//
//  TableViewData.m
//  XReader
//
//  Created by Pablo Collins on 1/30/11.
//  Copyright 2011 trickbot. All rights reserved.
//

#import "TableViewData.h"
#import "TableViewSection.h"

@implementation TableViewData

- (id)init {
	self = [super init];
	sections = [[NSMutableArray alloc] init];
	return self;
}

- (void)addSection:(TableViewSection *)s {
	[sections addObject:s];
}

- (NSInteger)numberOfSections {
	return [sections count];
}

- (NSString *)titleForHeaderInSection:(NSInteger)section {
	TableViewSection *s = [sections objectAtIndex:section];
	return s.title;
}

- (NSString *)titleForFooterInSection:(NSInteger)section {
	TableViewSection *s = [sections objectAtIndex:section];
	return s.footerTitle;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
	TableViewSection *s = [self section:section];
	return [s rowCount];
}

- (TableViewSection *)section:(NSInteger)section {
	 return [sections objectAtIndex:section];
}

- (TableViewRow *)rowAtIndexPath:(NSIndexPath *)indexPath
{
	TableViewSection *s = [self section:[indexPath section]];
	return [s rowAtIndex:[indexPath row]];
}


@end
