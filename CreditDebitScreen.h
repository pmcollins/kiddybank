//
//  CreditDebitScreen.h
//  Allowance
//
//  Created by Pablo Collins on 7/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmountEditor.h"
#import "EditableCell.h"
#import "Reloadable.h"

@interface CreditDebitScreen : UITableViewController {
    NSString *type;
    NSNumber *amount;
    id<Reloadable> __unsafe_unretained reloadableParent;
    EditableCell *notesCell;
}

@property (unsafe_unretained, nonatomic) id<Reloadable> reloadableParent;

- (void)setType:(NSString *)t;
- (void)saveAmount:(NSNumber *)n;
- (void)applyBtnClicked:(id)sender;
- (UIButton *)applyButton;
- (UIButton *)cancelButton;
- (void)cancelBtnClicked:(id)sender;

@end
