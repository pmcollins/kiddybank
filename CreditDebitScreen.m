//
//  CreditDebitScreen.m
//  Allowance
//
//  Created by Pablo Collins on 7/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CreditDebitScreen.h"

@implementation CreditDebitScreen

@synthesize reloadableParent;

- (void)viewDidLoad {
    //[self.tableView addSubview:[self applyButton]];
    //[self.tableView addSubview:[self cancelButton]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Amount";
        case 1:
            return @"Notes";
        default:
            return @"";
    }
}

- (UITableViewCell *)amountCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = amount == nil ?
        [AllowanceAppDelegate priceFromDouble:0.0] :
        [AllowanceAppDelegate priceFromDouble:[amount intValue]/(double)[AllowanceAppDelegate priceDenominator]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (EditableCell *)notesCell {
    if (notesCell == nil) {
        notesCell = [[EditableCell alloc] initWithStyle:UITableViewCellStyleDefault placeholder:@"Notes"];
    }
    return notesCell;
}

- (void)applyBtnClicked:(id)sender {
    Kid *kid = [AllowanceAppDelegate currentKid];
    int amt = [amount intValue];
    if ([type isEqualToString:@"Credit"]) {
        [kid updateAccountBy:amt withNotes:[self notesCell].textLabel.text];
    } else {
        [kid updateAccountBy:-amt withNotes:[self notesCell].textLabel.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
    [self.reloadableParent readAndReload];
}

- (void)cancelBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)applyButton {
    NSString *t = [NSString stringWithFormat:@"Apply %@",type];
    CGRect frame = CGRectMake(10, 300, 300, 42);
    UIImage *blueImage = [UIImage imageNamed:@"blueButton.png"];
    UIImage *whiteImage = [UIImage imageNamed:@"whiteButton.png"];
    UIButton *btn = [AllowanceAppDelegate newButtonWithTitle:t
                                                      target:self
                                                    selector:@selector(applyBtnClicked:)
                                                       frame:frame
                                                       image:whiteImage
                                                imagePressed:blueImage
                                               darkTextColor:YES];
    return btn;
}

- (UIButton *)cancelButton {
    NSString *t = [NSString stringWithFormat:@"Cancel"];
    CGRect frame = CGRectMake(10, 280, 300, 42);
    UIImage *buttonBackground = [UIImage imageNamed:@"whiteButton.png"];
    UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"blueButton.png"];
    UIButton *btn = [AllowanceAppDelegate newButtonWithTitle:t
                                                      target:self
                                                    selector:@selector(cancelBtnClicked:)
                                                       frame:frame
                                                       image:buttonBackground
                                                imagePressed:buttonBackgroundPressed
                                               darkTextColor:YES    ];
    return btn;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch ([indexPath indexAtPosition:0]) {
        case 0:
            cell = [self amountCell];
            break;
        case 1:
            cell = [self notesCell];
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath indexAtPosition:0]) {
        case 1:
            return 85;
        default:
            return 44;
    }
}

- (void)pushAmountEditor {
    AmountEditor *e = [[AmountEditor alloc] initWithNibName:@"AmountEditor" bundle:nil];
    e.title = @"Amount";
    [e setCallback:@selector(saveAmount:) withObject:self];
    [self.navigationController pushViewController:e animated:YES];
}

- (void)saveAmount:(NSNumber *)n {
    amount = n;
    [(UITableView *)self.view reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]]
                                    withRowAnimation:UITableViewRowAnimationNone];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                           target:self
                                                                                           action:@selector(applyBtnClicked:)];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([indexPath indexAtPosition:0]) {
        case 0:
            [self pushAmountEditor];
            break;
        case 1:
            break;
        default:
            break;
    }
}

- (void)setType:(NSString *)t {
    type = t;
}

@end
