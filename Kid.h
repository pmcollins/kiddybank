//
//  Kid.h
//  Allowance
//
//  Created by Pablo Collins on 6/13/10.
//

#import <CoreData/CoreData.h>
#import "Account.h"
#import "Transaction.h"
#import "Cal.h"

@interface Kid : NSManagedObject {
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *payAmount;
@property (nonatomic, strong) NSNumber *lastWeekPaid;
@property (nonatomic, strong) NSSet *accounts;

+ (void)createWithName:(NSString *)name andAllowance:(int)amount payToday:(bool)payToday;
- (Account *)savingsAccount;
- (NSNumber *)savingsBalance;
- (NSInteger)updateAccount;
- (void)updateAccountBy:(int)amount withNotes:(NSString *)notes;
- (NSString *)balanceString;
- (NSArray *)transactionHistory;

@end

@interface Kid (CoreDataGeneratedAccessors)

- (void)addAccountsObject:(NSManagedObject *)value;
- (void)removeAccountsObject:(NSManagedObject *)value;
- (void)addAccounts:(NSSet *)value;
- (void)removeAccounts:(NSSet *)value;

@end
