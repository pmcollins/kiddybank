//
//  EditableCurrencyCell.h
//  Allowance
//
//  Created by Pablo Collins on 6/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
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
