//
//  Transaction.h
//  Allowance
//
//  Created by Pablo Collins on 6/13/10.
//

#import <CoreData/CoreData.h>

@class Account;

@interface Transaction : NSManagedObject {
}

@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSNumber *sourceAccountBalance;
@property (nonatomic, strong) NSNumber *targetAccountBalance;
@property (nonatomic, strong) NSDate   *transactionDate;
@property (nonatomic, strong) Account  *sourceAccount;
@property (nonatomic, strong) Account  *targetAccount;

+ (NSArray *)historyForAccount:(Account *)acct;
+ (Transaction *)lastAllowancePaymentForAccount:(Account *)acct;
- (void)updateAccounts;
- (NSString *)formattedAmount;
- (NSString *)currentBalanceFormatted;

@end
