//
//  KidForm.m
//  Allowance
//
//  Created by Pablo Collins on 6/12/10.
//

#import "NewKidForm.h"

@implementation NewKidForm

@synthesize opener;

- (void)viewDidLoad {
    self.title = @"Add Child";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(cancel:)];
}

- (void)createKid {
    [Kid createWithName:nameField.text andAllowance:startingAmount payToday:payToday];
    [opener dismissModalEditor];
}

- (void)save:(id)sender {
    NSString *name = nameField.text;
    if (![name length]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Child's name cannot be empty."
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    int currentDay = [Cal currentDay];
    int paymentDay = [AllowanceAppDelegate paymentDay];
    if (currentDay == paymentDay) {
        NSString *msg = [NSString stringWithFormat:@"Today is allowance payment day. Make first payment for %@ today?", name];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"First Allowance Payment"
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Yes", nil];
        [alert show];
    } else {
        [self createKid];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    payToday = buttonIndex;
    [self createKid];
}

- (void)cancel:(id)sender {
    [opener dismissModalEditor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)nameCell {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 280, 30)];
    nameField.font = [UIFont systemFontOfSize:20];
    [cell addSubview:nameField];
    [nameField becomeFirstResponder];
    nameField.delegate = self;
    return cell;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location || string.length) {
        //ok to save
        if (self.navigationItem.rightBarButtonItem == nil) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                                   target:self
                                                                                                   action:@selector(save:)];
        }
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    return YES;
}

- (UITableViewCell *)allowanceCell {
    if (allowanceCell == nil) {
        allowanceCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        allowanceCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    allowanceCell.textLabel.text = [AllowanceAppDelegate priceFromDouble:((double)startingAmount/[AllowanceAppDelegate priceDenominator])];
    return allowanceCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([indexPath indexAtPosition:0]) {
        case 0:
            return [self nameCell];
        case 1:
            return [self allowanceCell];
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return nil; //@"Touch 'Done' above to create your child's account.";
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Child's Name";
        case 1:
            return @"Weekly Allowance";
    }
    return nil;
}

- (void)setAmount:(NSNumber *)amount {
    startingAmount = [amount intValue];
    [(UITableView *)self.view reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:1]]
                                    withRowAnimation:UITableViewRowAnimationNone];
}

- (void)pushAllowanceEditor {
    AmountEditor *amountEditor = [[AmountEditor alloc] initWithNibName:@"AmountEditor" bundle:nil];
    amountEditor.title = @"Starting Allowance";
    [amountEditor setCallback:@selector(setAmount:) withObject:self];
    [amountEditor setAmount:startingAmount];
    [self.navigationController pushViewController:amountEditor animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 1) {
        [self pushAllowanceEditor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

@end
