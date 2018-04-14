//
//  HistoryItem.m
//  Allowance
//
//  Created by Pablo Collins on 4/20/11.
//

#import "HistoryItem.h"
#import "TableViewSection.h"
#import "TableViewRow.h"
#import "ModelManager.h"

@implementation HistoryItem

@synthesize tableView, transaction, myIndexPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self) return nil;
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tableData = [[TableViewData alloc] init];
    
    TableViewSection *section = [[TableViewSection alloc] initWithTitle:@"Transaction Details"];
    [tableData addSection:section];
    
    TableViewRow *row = [[TableViewRow alloc] init];
    row.cellMaker = ^{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
        cell.textLabel.text = @"Type";
        cell.detailTextLabel.text = transaction.tag;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    };
    [section addRow:row];
    
    row = [[TableViewRow alloc] init];
    row.cellMaker = ^{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
        cell.textLabel.text = @"Amount";
        cell.detailTextLabel.text = [transaction formattedAmount];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    };
    [section addRow:row];
    
    row = [[TableViewRow alloc] init];
    row.cellMaker = ^{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
        cell.textLabel.text = @"Date";
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        [f setDateStyle:NSDateFormatterMediumStyle];
        NSString *dateString = [f stringFromDate:transaction.transactionDate];
        cell.detailTextLabel.text = dateString;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    };
    [section addRow:row];
    
    
    section = [[TableViewSection alloc] initWithTitle:@"Notes"];
    [tableData addSection:section];
    row = [[TableViewRow alloc] init];
    row.cellMaker = ^{
        notesCell = [[EditableCell alloc] initWithStyle:UITableViewCellStyleValue2 placeholder:nil];
        [notesCell.textLabel setText:transaction.notes];
        [notesCell setTextViewDelegate:self];
        return (UITableViewCell *)notesCell;
    };
    row.height = 85;
    [section addRow:row];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    NSLog(@"viewDidUnload");
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillDisappear:(BOOL)animated
{
    transaction.notes = [notesCell.textLabel text];
    [[ModelManager sharedInstance] save];
    [accountHistoryController.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:myIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// pragma stuffs

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableData rowAtIndexPath:indexPath].cellMaker();
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat f = [tableData rowAtIndexPath:indexPath].height;
    return f ? f : 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [tableData numberOfSections];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [tableData titleForHeaderInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [tableData titleForFooterInSection:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}

- (void)doneTouched:(id)sender
{
    NSLog(@"doneTouched");
    [notesCell hideKeyboard];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    CGRect fr = self.view.frame;
    fr.origin.y = -120;
    self.view.frame = fr;
    [UIView commitAnimations];
    //self.navigationController.navigationBar s
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    [self.navigationItem setRightBarButtonItem:doneBtn animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    CGRect fr = self.view.frame;
    fr.origin.y = 0;
    self.view.frame = fr;
    [UIView commitAnimations];
}

- (void)setAccountHistoryController:(AccountHistory *)ahc
{
    accountHistoryController = ahc;
}

@end
