//
//  CurrencyEditor.m
//  Allowance
//
//  Created by Pablo Collins on 8/15/10.
//

#import "CurrencyEditor.h"

@implementation CurrencyEditor

@synthesize reloadableParent;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Format";
    delims = [NSArray arrayWithObjects:@".",@",",@"",nil];
    symbols = [NSArray arrayWithObjects:@"$",@"£",@"€",@"¥",@"₩",@"₪",@"₨",@"¤",@"♥",nil];
    UIImage *blueImage = [UIImage imageNamed:@"blueButton.png"];
    UIImage *whiteImage = [UIImage imageNamed:@"whiteButton.png"];
    CGRect f1 = CGRectMake(10, 260, 300, 40);
    UIButton *btn = [AllowanceAppDelegate newButtonWithTitle:@"OK"
                                                      target:self
                                                    selector:@selector(save:)
                                                       frame:f1
                                                       image:whiteImage
                                                imagePressed:blueImage
                                               darkTextColor:YES];
    NSString *delim = [AllowanceAppDelegate delimiter];
    NSString *currency = [AllowanceAppDelegate currency];
    [picker selectRow:[symbols indexOfObject:currency] inComponent:0 animated:NO];
    [picker selectRow:[delims indexOfObject:delim] inComponent:1 animated:NO];
    [self print];
    [self.view addSubview:btn];
}
 
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 60;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [symbols count];
    } else {
        return [delims count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [symbols objectAtIndex:row];
    } else {
        return [NSString stringWithFormat:@"'%@'",[delims objectAtIndex:row]];
    }
}

- (void)print {
    NSInteger currencyRow = [picker selectedRowInComponent:0];
    NSInteger delimRow = [picker selectedRowInComponent:1];
    NSString *symbol = [symbols objectAtIndex:currencyRow];
    NSString *delim = [delims objectAtIndex:delimRow];
    label.text = [NSString stringWithFormat:@"%@12%@34",symbol,delim];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self print];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)save:(id)sender {
    int c0 = [picker selectedRowInComponent:0];
    int c1 = [picker selectedRowInComponent:1];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *symbol = [symbols objectAtIndex:c0];
    NSString *delim = [delims objectAtIndex:c1];
    [defaults setObject:symbol forKey:@"currency"];
    [defaults setObject:delim forKey:@"delimeter"];
    [reloadableParent readAndReload];
    [self.navigationController popViewControllerAnimated:YES];    
}

@end
