//
//  AmountEditor.m
//  Allowance
//
//  Created by Pablo Collins on 6/22/10.
//

#import "AmountEditor.h"

@implementation AmountEditor

@synthesize currencyLabel;
@synthesize decimalLabel;

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 10;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 45;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 42;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%d",9-row];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    int n0 = payAmount / 10000;
    int n1 = (payAmount % 10000) / 1000;
    int n2 = (payAmount % 1000) / 100;
    int n3 = (payAmount % 100) / 10;
    int n4 = payAmount % 10;
    [amountPicker selectRow:9-n0 inComponent:0 animated:NO];
    [amountPicker selectRow:9-n1 inComponent:1 animated:NO];
    [amountPicker selectRow:9-n2 inComponent:2 animated:NO];
    [amountPicker selectRow:9-n3 inComponent:3 animated:NO];
    [amountPicker selectRow:9-n4 inComponent:4 animated:NO];
    UIImage *blueImage = [UIImage imageNamed:@"blueButton.png"];
    UIImage *whiteImage = [UIImage imageNamed:@"whiteButton.png"];
    CGRect f1 = CGRectMake(30, 300, 260, 40);
    UIButton *btn = [AllowanceAppDelegate newButtonWithTitle:@"OK"
                                                      target:self
                                                    selector:@selector(save:)
                                                       frame:f1
                                                       image:whiteImage
                                                imagePressed:blueImage
                                               darkTextColor:YES];
    [self.view addSubview:btn];
    currencyLabel.text = [[AllowanceAppDelegate currencyFormatter] currencySymbol];
    if ([AllowanceAppDelegate numCentPlaces] == 0) {
        decimalLabel.text = @"";
    } else {
        decimalLabel.text = [[AllowanceAppDelegate currencyFormatter] currencyDecimalSeparator];
    }
}

- (void)setAmount:(int)amount {
    payAmount = amount;
}

- (void)setCallback:(SEL)sel withObject:(NSObject *)object {
    callback = sel;
    callbackObject = object;
}

- (int)amount {
    return [self valueAtPosition:0] + [self valueAtPosition:1] + [self valueAtPosition:2] +
        [self valueAtPosition:3] + [self valueAtPosition:4];
}

- (void)save:(id)sender {
    [callbackObject performSelector:callback withObject:[NSNumber numberWithInt:[self amount]]]; //foo
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (int)valueAtPosition:(int)pos {
    int v = 9 - [amountPicker selectedRowInComponent:pos];
    int p = 4 - pos;
    return v * pow(10.0, p);
}

@end
