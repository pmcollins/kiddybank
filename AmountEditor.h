//
//  AmountEditor.h
//  Allowance
//
//  Created by Pablo Collins on 6/22/10.
//

#import <UIKit/UIKit.h>

@interface AmountEditor : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet UIPickerView *amountPicker;
    int payAmount;
    SEL callback;
    NSObject *callbackObject;
    UILabel *__unsafe_unretained currencyLabel, *__unsafe_unretained decimalLabel;
}

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *currencyLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *decimalLabel;

- (IBAction)save:(id)sender;
- (int)valueAtPosition:(int)pos;
- (void)setAmount:(int)amount;
- (void)setCallback:(SEL)sel withObject:(NSObject *)object;
- (void)cancel:(id)sender;

@end
