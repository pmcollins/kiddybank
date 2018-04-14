//
//  AllowanceDayEditor.m
//  Allowance
//
//  Created by Pablo Collins on 6/27/10.
//

#import "AllowanceDayEditor.h"

@implementation AllowanceDayEditor

@synthesize reloadableParent;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Allowance Day";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int i = [defaults integerForKey:@"payDay"];
    [dayPicker selectRow:i-1 inComponent:0 animated:NO];
    UIImage *blueImage = [UIImage imageNamed:@"blueButton.png"];
    UIImage *whiteImage = [UIImage imageNamed:@"whiteButton.png"];
    CGRect f1 = CGRectMake(10, 240, 300, 40);
    UIButton *btn = [AllowanceAppDelegate newButtonWithTitle:@"OK"
                                                      target:self
                                                    selector:@selector(save:)
                                                       frame:f1
                                                       image:whiteImage
                                                imagePressed:blueImage
                                               darkTextColor:YES];
    [self.view addSubview:btn];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 7;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 200;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 42;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [WeekDays nameForNum:[NSNumber numberWithInt:row+1]];
}

- (IBAction)save:(id)sender {
    NSInteger weekDay = [dayPicker selectedRowInComponent:0] + 1;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:weekDay forKey:@"payDay"];
    [reloadableParent readAndReload];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
