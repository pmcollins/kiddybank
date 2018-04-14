// 
//  Account.m
//  Allowance
//
//  Created by Pablo Collins on 6/13/10.
//

#import "Account.h"

#import "Kid.h"

@implementation Account 

@dynamic isExpenseType;
@dynamic name;
@dynamic createdAt;
@dynamic debitTransactions;
@dynamic owner;
@dynamic creditTransactions;
@dynamic balance;

+ (void)findOrCreateMasterAccount {
    Account *mst = [Account masterAccount];
    if (mst != nil) {
        return;
    }
    ModelManager *mm = [ModelManager sharedInstance];
    NSManagedObjectContext *ctx = [mm managedObjectContext];
    mst = (Account *)[NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:ctx];
    mst.name = @"master";
    mst.isExpenseType = [NSNumber numberWithBool:YES];
    mst.createdAt = [NSDate date];
    [mm save];
}

+ (Account *)masterAccount {
    ModelManager *mm = [ModelManager sharedInstance];
    NSManagedObjectContext *ctx = [mm managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:ctx];
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    [req setEntity:entity];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"name == 'master'"];
    [req setPredicate:p];
    [req setFetchLimit:1];
    NSError *err;
    NSArray *accounts = [ctx executeFetchRequest:req error:&err];
    if ([accounts count] > 0) {
        return [accounts objectAtIndex:0];
    } else {
        return nil;
    }
}

- (NSArray *)transactionHistory {
    return [Transaction historyForAccount:self];
}

@end
