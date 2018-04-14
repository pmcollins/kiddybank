// 
//  Transaction.m
//  Allowance
//
//  Created by Pablo Collins on 6/13/10.
//

#import "Transaction.h"
#import "Account.h"

@implementation Transaction 

@dynamic amount;
@dynamic notes;
@dynamic tag;
@dynamic sourceAccountBalance;
@dynamic targetAccountBalance;
@dynamic transactionDate;
@dynamic sourceAccount;
@dynamic targetAccount;

+ (Transaction *)lastAllowancePaymentForAccount:(Account *)acct {
    ModelManager *mm = [ModelManager sharedInstance];
    NSManagedObjectContext *ctx = [mm managedObjectContext];
    NSEntityDescription *d = [NSEntityDescription entityForName:@"Transaction" inManagedObjectContext:ctx];
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    [req setEntity:d];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"(targetAccount == %@) AND (tag == 'allowance')",acct];
    [req setPredicate:p];
    NSSortDescriptor *ordering = [[NSSortDescriptor alloc] initWithKey:@"transactionDate" ascending:NO];
    [req setSortDescriptors:[NSArray arrayWithObject:ordering]];
    [req setFetchLimit:1];
    NSError *e;
    NSArray *txs = [ctx executeFetchRequest:req error:&e];
    if ([txs count] > 0) {
        return [txs objectAtIndex:0];
    } else {
        return nil;
    }
}

+ (NSArray *)historyForAccount:(Account *)acct {
    ModelManager *mm = [ModelManager sharedInstance];
    NSManagedObjectContext *ctx = [mm managedObjectContext];
    NSEntityDescription *d = [NSEntityDescription entityForName:@"Transaction" inManagedObjectContext:ctx];
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    [req setEntity:d];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"(targetAccount == %@) OR (sourceAccount == %@)",acct,acct];
    [req setPredicate:p];
    NSSortDescriptor *ordering = [[NSSortDescriptor alloc] initWithKey:@"transactionDate" ascending:NO];
    [req setSortDescriptors:[NSArray arrayWithObject:ordering]];
    NSError *e;
    NSArray *out = [ctx executeFetchRequest:req error:&e];
    return out;
}

- (void)updateAccounts {
    int amt = [self.amount intValue];
    int sourceBalance = [self.sourceAccount.balance intValue];
    self.sourceAccountBalance = [NSNumber numberWithInt:sourceBalance];
    sourceBalance -= amt;
    self.sourceAccount.balance = [NSNumber numberWithInt:sourceBalance];
    int targetBalance = [self.targetAccount.balance intValue];
    self.targetAccountBalance = [NSNumber numberWithInt:targetBalance];
    targetBalance += amt;
    self.targetAccount.balance = [NSNumber numberWithInt:targetBalance];
}

+ (NSString *)formatAmount:(NSInteger)i
{
    return [AllowanceAppDelegate priceFromDouble:i/(double)[AllowanceAppDelegate priceDenominator]];
}

- (NSString *)formattedAmount
{
    return [Transaction formatAmount:[self.amount intValue]];
}

- (NSInteger)currentBalance
{
    if (self.sourceAccount == [AllowanceAppDelegate masterAccount]) {
        return [self.targetAccountBalance intValue] + [self.amount intValue];
    } else {
        return [self.sourceAccountBalance intValue] - [self.amount intValue];
    }
}

- (NSString *)currentBalanceFormatted
{
    return [Transaction formatAmount:[self currentBalance]];
}

@end
