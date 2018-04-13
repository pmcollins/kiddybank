//
//  SettingsEditor.m
//  Allowance
//
//  Created by Pablo Collins on 7/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SettingsEditor.h"

@implementation SettingsEditor

@synthesize opener;

- (void)viewDidLoad {
    self.title = @"Settings";
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
            return @"Allowance Day";
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return section == 0 ? @"Allowance will be credited automatically once a week." : nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch ([indexPath indexAtPosition:0]) {
        case 0:
            cell = [self payDayCell];
            break;
        case 1:
            cell = [self doneCell];
            break;
        default:
            break;
    }
    return cell;
}

- (void)pushAllowanceDayEditor {
    AllowanceDayEditor *e = [[AllowanceDayEditor alloc] initWithNibName:@"AllowanceDayEditor" bundle:nil];
    e.reloadableParent = self;
    [self.navigationController pushViewController:e animated:YES];
}

/*
- (void)pushCurrencyEditor {
    CurrencyEditor *e = [[CurrencyEditor alloc] initWithNibName:@"CurrencyEditor" bundle:nil];
    e.reloadableParent = self;
    [self.navigationController pushViewController:e animated:YES];
    [e release];
}
*/
 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([indexPath section]) {
        case 0:
            [self pushAllowanceDayEditor];
            break;
        default:
            break;
    }
}

- (UITableViewCell *)payDayCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int payDay = [defaults integerForKey:@"payDay"];
    cell.textLabel.text = [WeekDays nameForNum:[NSNumber numberWithInt:payDay]];
    return cell;
}

/*
- (UITableViewCell *)currencyCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [NSString stringWithFormat:@"%@12%@34",[AllowanceAppDelegate currency],[AllowanceAppDelegate delimiter]];
    return cell;
}
*/

- (UITableViewCell *)doneCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
    UIImage *blueImage = [UIImage imageNamed:@"blueButton.png"];
    UIImage *whiteImage = [UIImage imageNamed:@"whiteButton.png"];
    CGRect frame = cell.bounds;
    frame.size.width = 300; //originally 320
    UIButton *btn = [AllowanceAppDelegate newButtonWithTitle:@"Done"
                                                      target:self
                                                    selector:@selector(doneButtonClicked:)
                                                       frame:frame
                                                       image:whiteImage
                                                imagePressed:blueImage
                                               darkTextColor:YES];
    [cell.contentView addSubview:btn];
    return cell;
}

- (void)readAndReload {
    [self.tableView reloadData];
}

- (void)doneButtonClicked:(id)sender {
    [opener dismissModalEditor];
}

@end

