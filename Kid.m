// 
//  Kid.m
//  Allowance
//
//  Created by Pablo Collins on 6/13/10.
//

#import "Kid.h"

@implementation Kid 

@dynamic name;
@dynamic payAmount;
@dynamic accounts;
@dynamic lastWeekPaid;

+ (void)createWithName:(NSString *)name andAllowance:(int)amount payToday:(bool)payToday {
    ModelManager *mm = [ModelManager sharedInstance];
    NSManagedObjectContext *ctx = [mm managedObjectContext];
    Kid *kid = (Kid *)[NSEntityDescription
                       insertNewObjectForEntityForName:@"Kid"
                       inManagedObjectContext:ctx];
    kid.name = name;
    kid.payAmount = [NSNumber numberWithInt:amount];
    
    int appPayDay = [AllowanceAppDelegate paymentDay];
    int currentWeek = [Cal currentWeek];
    int currentDay = [Cal currentDay];
    int lastWeekPaid;
    if ((currentDay < appPayDay) || payToday) {
        lastWeekPaid = currentWeek - 1;
    } else {
        lastWeekPaid = currentWeek;
    }
    kid.lastWeekPaid = [NSNumber numberWithInt:lastWeekPaid];
    
    Account *acct = (Account *)[NSEntityDescription
                                insertNewObjectForEntityForName:@"Account"
                                inManagedObjectContext:ctx];
    acct.name = @"savings";
    acct.owner = kid;
    acct.createdAt = [NSDate date];
    [mm save];
    if (payToday) {
        [kid updateAccount];
    }
}

- (Account *)savingsAccount {
    return [self.accounts anyObject]; //fixme
}

- (NSNumber *)savingsBalance {
    return [self savingsAccount].balance;
}

- (NSInteger)updateAccount {
    int out = 0;
    if (self.payAmount == nil) {
        return out;
    }
    int lastWeekPaid = [self.lastWeekPaid intValue];
    int currentWeek = [Cal currentWeek];
    ModelManager *mm = [ModelManager sharedInstance];
    NSManagedObjectContext *ctx = [mm managedObjectContext];
    Account *savings = [self savingsAccount];
    Account *masterAccount = [Account masterAccount];
    int lastWeek = currentWeek - 1;
    int currentDay = [Cal currentDay];
    int paymentDay = [AllowanceAppDelegate paymentDay];
    while ((lastWeekPaid < lastWeek) ||
           (lastWeekPaid == lastWeek && currentDay >= paymentDay)) {
        lastWeekPaid += 1;
        Transaction *tx = (Transaction *)[NSEntityDescription
                                          insertNewObjectForEntityForName:@"Transaction"
                                          inManagedObjectContext:ctx];
        tx.amount = self.payAmount;
        tx.sourceAccount = masterAccount;
        tx.targetAccount = savings;
        tx.tag = @"allowance";
        tx.transactionDate = [Cal dateForWeeknum:lastWeekPaid andWeekday:paymentDay];
        //tx.notes = [NSString stringWithFormat:@"Week %i",lastWeekPaid];
        [tx updateAccounts];
        out += 1;
    }
    self.lastWeekPaid = [NSNumber numberWithInt:lastWeekPaid];
    [mm save];
    return out;
}

- (void)updateAccountBy:(int)amount withNotes:(NSString *)notes {
    ModelManager *mm = [ModelManager sharedInstance];
    NSManagedObjectContext *ctx = [mm managedObjectContext];
    Account *savings = [self savingsAccount];
    Account *masterAccount = [Account masterAccount];
    Transaction *tx = (Transaction *)[NSEntityDescription
                                      insertNewObjectForEntityForName:@"Transaction"
                                      inManagedObjectContext:ctx];
    if (amount < 0) {
        tx.sourceAccount = savings;
        tx.targetAccount = masterAccount;
        amount = -amount;
    } else {
        tx.sourceAccount = masterAccount;
        tx.targetAccount = savings;
    }
    tx.amount = [NSNumber numberWithInt:amount];
    tx.tag = @"update";
    tx.transactionDate = [NSDate date];
    tx.notes = notes;
    [tx updateAccounts];
    [mm save];
}

- (double)balanceCents {
    return [[self savingsAccount].balance intValue]/(double)[AllowanceAppDelegate priceDenominator];
}

- (NSString *)balanceString {
    return [AllowanceAppDelegate priceFromDouble:[self balanceCents]];
}

- (NSArray *)transactionHistory {
    return [[self savingsAccount] transactionHistory];
}

@end
