//
//  Account.h
//  Allowance
//
//  Created by Pablo Collins on 6/13/10.
//

#import <CoreData/CoreData.h>

@class Kid;

@interface Account :  NSManagedObject {
}

@property (nonatomic, strong) NSNumber * isExpenseType;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSSet* debitTransactions;
@property (nonatomic, strong) Kid * owner;
@property (nonatomic, strong) NSSet* creditTransactions;
@property (nonatomic, strong) NSNumber * balance;

+ (void)findOrCreateMasterAccount;
+ (Account *)masterAccount;
- (NSArray *)transactionHistory;

@end

@interface Account (CoreDataGeneratedAccessors)
- (void)addDebitTransactionsObject:(NSManagedObject *)value;
- (void)removeDebitTransactionsObject:(NSManagedObject *)value;
- (void)addDebitTransactions:(NSSet *)value;
- (void)removeDebitTransactions:(NSSet *)value;

- (void)addCreditTransactionsObject:(NSManagedObject *)value;
- (void)removeCreditTransactionsObject:(NSManagedObject *)value;
- (void)addCreditTransactions:(NSSet *)value;
- (void)removeCreditTransactions:(NSSet *)value;

@end

