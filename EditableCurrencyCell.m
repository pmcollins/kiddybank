//
//  EditableCurrencyCell.m
//  Allowance
//
//  Created by Pablo Collins on 6/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EditableCurrencyCell.h"


@implementation EditableCurrencyCell

- (id)initWithPlaceholder:(NSString *)placeholder {
    id out = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    textField.placeholder = placeholder;
    return out;
}

- (id)initwithValue:(NSString *)value {
    id out = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    textField.text = value;
    return out;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    fieldInput = [[NSMutableString alloc] init];
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        CGRect frame = self.contentView.frame;
        frame.origin.x = 20;
        textField = [[UITextField alloc] initWithFrame:frame];
        textField.delegate = self;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:textField];
    }
    return self;
}

- (NSMutableString *)fieldInput {
    if (fieldInput == nil) {
        fieldInput = [NSMutableString stringWithFormat:@"%f",([textField.text doubleValue] * [AllowanceAppDelegate priceDenominator])];
    }
    return fieldInput;
}

- (double)doubleValue {
    return [[self fieldInput] intValue] / [AllowanceAppDelegate priceDenominator];
}

- (NSString *)formattedInput {
    return [NSString stringWithFormat:@"%.2f", [self doubleValue]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
}

- (BOOL)textField:(UITextField *)tf shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string length] == 0) { //delete btn pushed
        range.location -= 1;
        [[self fieldInput] deleteCharactersInRange:range];
    } else {
        [[self fieldInput]
         appendString:string];
    }
    textField.text = [self formattedInput];
    return NO;
}


@end
