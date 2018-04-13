//
//  HistoryItem.h
//  Allowance
//
//  Created by Pablo Collins on 4/20/11.
//  Copyright 2011 trickbot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewData.h"
#import "EditableCell.h"
#import "AccountHistory.h"

@interface HistoryItem : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate> {
    UITableView *tableView;
    TableViewData *tableData;
    Transaction *transaction;
    EditableCell *notesCell;
    AccountHistory *accountHistoryController;
    NSIndexPath *myIndexPath;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) Transaction *transaction;
@property (nonatomic, strong) NSIndexPath *myIndexPath;

- (void)setAccountHistoryController:(AccountHistory *)ahc;

@end
