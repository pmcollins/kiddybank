//
//  KidForm.h
//  Allowance
//
//  Created by Pablo Collins on 6/12/10.
//

#import <UIKit/UIKit.h>
#import "EditableCell.h"
#import "EditableCurrencyCell.h"
#import "ModalEditorDelegate.h"
#import "AmountEditor.h"

@interface NewKidForm : UIViewController<UITableViewDelegate, UIAlertViewDelegate, UITextFieldDelegate> {
    id<ModalEditorDelegate> __unsafe_unretained opener;
    UITableViewCell *allowanceCell;
    UITextField *nameField;
    int startingAmount;
    bool payToday;
}

@property (nonatomic, unsafe_unretained) id<ModalEditorDelegate> opener;

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (void)setAmount:(NSNumber *)amount;
- (void)save:(id)sender;
- (void)cancel:(id)sender;
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
