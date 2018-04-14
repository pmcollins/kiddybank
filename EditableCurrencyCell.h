//
//  EditableCurrencyCell.h
//  Allowance
//
//  Created by Pablo Collins on 6/19/10.
//

#import <Foundation/Foundation.h>


@interface EditableCurrencyCell : UITableViewCell<UITextFieldDelegate> {
    UITextField *textField;
    NSMutableString *fieldInput;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (double)doubleValue;
- (id)initWithPlaceholder:(NSString *)placeholder;
- (id)initwithValue:(NSString *)value;

@end
