//
//  KidDetail.m
//  Allowance
//
//  Created by Pablo Collins on 6/15/10.
//

#import "KidDetail.h"

@implementation KidDetail

@synthesize kidsTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [AllowanceAppDelegate currentKid].name;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 2 ? 2 : 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Touch balance to view account history";
        default:
            return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Balance";
        case 1:
            return @"Weekly Allowance";
        case 2:
            return @"Updates";
        default:
            return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch ([indexPath indexAtPosition:0]) {
        case 0:
            cell = [self kidBalanceCell];
            break;
        case 1:
            cell = [self kidAllowanceCell];
            break;
        case 2:
            switch ([indexPath indexAtPosition:1]) {
                case 0:
                    cell = [self kidCreditCell];
                    break;
                case 1:
                    cell = [self kidDebitCell];
                    break;
                default:
                    break;
            }
            break;
        case 3:
            cell = [self kidDeleteCell];
            break;
        default:
            break;
    }
    return cell;
}

- (Kid *)kid {
    return [AllowanceAppDelegate currentKid];
}

- (UITableViewCell *)kidNameCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [AllowanceAppDelegate currentKid].name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UITableViewCell *)kidAllowanceCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    double dollars = [[AllowanceAppDelegate currentKid].payAmount intValue]/(double)[AllowanceAppDelegate priceDenominator];
    cell.textLabel.text = [AllowanceAppDelegate priceFromDouble:dollars];
    return cell;
}

- (UITableViewCell *)kidBalanceCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [[AllowanceAppDelegate currentKid] balanceString];
    return cell;
}

- (UITableViewCell *)kidCreditCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"Credit";
    return cell;
}

- (UITableViewCell *)kidDebitCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"Debit";
    return cell;
}

- (UITableViewCell *)kidDeleteCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    NSString *t = [NSString stringWithFormat:@"Delete Account"];
    [btn setTitle:t forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    CGRect frame = cell.bounds;
    frame.size.width = 300; //originally 320
    btn.frame = frame;
    [btn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:btn];
    return cell;
}

- (void)deleteKid {
     [[ModelManager sharedInstance] delete:[AllowanceAppDelegate currentKid]];
     [self.kidsTable readAndReload];    
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)deleteBtnClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm Delete" message:@"Are you sure you want to delete this account?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self deleteKid];
    }
}

- (void)readAndReload {
    [self.tableView reloadData];
}

- (void)pushCreditDebitScreenWithType:(NSString *)type {
    CreditDebitScreen *s = [[CreditDebitScreen alloc] initWithStyle:UITableViewStyleGrouped];
    [s setType:type];
    s.title = type;
    s.reloadableParent = self;
    [self.navigationController pushViewController:s animated:YES];
}

- (void)pushAllowanceEditor {
    AmountEditor *amountEditor = [[AmountEditor alloc] initWithNibName:@"AmountEditor" bundle:nil];
    amountEditor.title = @"Allowance";
    Kid *kid = [AllowanceAppDelegate currentKid];
    int payAmount = [kid.payAmount intValue];
    [amountEditor setCallback:@selector(saveAmount:) withObject:self];
    [amountEditor setAmount:payAmount];
    [self.navigationController pushViewController:amountEditor animated:YES];
}

- (void)pushAccountHistory {
    AccountHistory *a = [[AccountHistory alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:a animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([indexPath indexAtPosition:0]) {
        case 0:
            [self pushAccountHistory];
            break;
        case 1:
            [self pushAllowanceEditor];
            break;
        case 2:
            switch ([indexPath indexAtPosition:1]) {
                case 0:
                    [self pushCreditDebitScreenWithType:@"Credit"];
                    break;
                case 1:
                    [self pushCreditDebitScreenWithType:@"Debit"];
                    break;
                default:
                    break;
            }
        default:
            break;
    }
}

- (void)saveAmount:(NSNumber *)amount {
    Kid *kid = [AllowanceAppDelegate currentKid];
    kid.payAmount = amount;
    [[ModelManager sharedInstance] save];
    [self readAndReload];
}

@end
