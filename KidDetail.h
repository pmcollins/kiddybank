//
//  KidDetail.h
//  Allowance
//
//  Created by Pablo Collins on 6/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kid.h"
#import "ModalEditorDelegate.h"
#import "Reloadable.h"
#import "EditableCurrencyCell.h"
#import "AmountEditor.h"
#import "AllowanceDayEditor.h"
#import "WeekDays.h"
#import "CreditDebitScreen.h"
#import "AccountHistory.h"

@interface KidDetail : UITableViewController<Reloadable,UIAlertViewDelegate> {
    NSMutableArray *cellIndex;
    id<Reloadable> __unsafe_unretained kidsTable;
}

@property (nonatomic, unsafe_unretained) id<Reloadable> kidsTable;

- (void)deleteBtnClicked:(id)sender;
- (void)readAndReload;
- (UITableViewCell *)kidNameCell;
- (UITableViewCell *)kidAllowanceCell;
- (UITableViewCell *)kidBalanceCell;
- (UITableViewCell *)kidDeleteCell;
- (UITableViewCell *)kidCreditCell;
- (UITableViewCell *)kidDebitCell;

@end
