//
//  AccountHistory.m
//  Allowance
//
//  Created by Pablo Collins on 7/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AccountHistory.h"
#import "HistoryItem.h"
#import "AccountHistoryCell.h"

@implementation AccountHistory

- (TxHistory *)history {
    if (hist == nil) {
        NSArray *a = [[AllowanceAppDelegate currentKid] transactionHistory];
        hist = [[TxHistory alloc] initWithTransactions:a];
    }
    return hist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Account History";
    [self history];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, MMM d"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [hist numberOfWeeks];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSUInteger w = [hist lastWeek] - section;
    NSDateComponents *cmp = [[Cal sharedInstance] components:(NSYearCalendarUnit | NSWeekCalendarUnit) fromDate:[Cal dateForWeeknum:w]];
    return [NSString stringWithFormat:@"%i Week %i",[cmp year], [cmp week]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [hist transactionCountInBucket:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cell";
    AccountHistoryCell *cell = (AccountHistoryCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AccountHistoryCell alloc] init];
    }
    Transaction *tx = [hist transactionAtIndexPath:indexPath];
    NSString *type;
    if ([tx.tag isEqualToString:@"update"]) {
        type = (tx.sourceAccount == [AllowanceAppDelegate masterAccount] ? @"Credit" : @"Debit");
    } else {
        type = [tx.tag capitalizedString];
    }
    NSString *balanceStr = [tx currentBalanceFormatted];

    NSString *dateString = [dateFormatter stringFromDate:tx.transactionDate];
    
    [cell setBalance:balanceStr];
    NSString *amount = [AllowanceAppDelegate priceFromDouble:[tx.amount intValue]/(double)[AllowanceAppDelegate priceDenominator]];
    NSString *prefix = [type isEqualToString:@"Debit"] ? @"-" : @"";
    cell.amountLabel.text = [NSString stringWithFormat:@"%@%@", prefix, amount];
    cell.typeLabel.text = type;
    //cell.notesLabel.text = tx.notes;
    if ([tx.notes length]) {
        cell.dateLabel.text = [NSString stringWithFormat:@"%@: %@", dateString, tx.notes];
    } else {
        cell.dateLabel.text = dateString;
    }
    
    if ([type isEqualToString:@"Credit"]) {
        //cell.iconLabel.textColor = [UIColor greenColor];
        cell.iconLabel.text = @"➘";
    } else if ([type isEqualToString:@"Debit"]) {
        //cell.iconLabel.textColor = [UIColor redColor];
        cell.iconLabel.text = @"➚";
    } else { //allowance
        //cell.iconLabel.textColor = [UIColor grayColor];
        cell.iconLabel.text = @"★";
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryItem *hi = [[HistoryItem alloc] initWithNibName:@"HistoryItem" bundle:nil];
    [hi setAccountHistoryController:self];
    hi.myIndexPath = indexPath;
    Transaction *tx = [hist transactionAtIndexPath:indexPath];
    hi.transaction = tx;
    [self.navigationController pushViewController:hi animated:YES];
}

@end

