//
//  KidsTable.m
//  Allowance
//
//  Created by Pablo Collins on 6/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "KidsTable.h"

@implementation KidsTable

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self readAndReload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [self addButton];
    self.navigationItem.leftBarButtonItem = [self settingsButton];
    [self readKids];
}

- (UIBarButtonItem *)settingsButton {
    if (settingsButton == nil) {
        settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                           style:UIBarButtonItemStylePlain
                                                          target:self
                                                          action:@selector(pushedSettings:)];
    }
    return settingsButton;
}

- (UIBarButtonItem *)addButton {
    if (addButton == nil) {
        addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                   target:self
                                                                   action:@selector(pushedAdd:)];
    }
    return addButton;
}

- (void)pushedAdd:(id)sender {
    NewKidForm *kidForm = [[NewKidForm alloc] initWithNibName:@"KidForm" bundle:nil];
    kidForm.opener = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:kidForm];
    [self presentModalViewController:navController animated:YES];
}

- (void)pushedSettings:(id)sender {
    SettingsEditor *settingsEditor = [[SettingsEditor alloc] initWithNibName:@"SettingsEditor" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:settingsEditor];
    settingsEditor.opener = self;
    [self presentModalViewController:navController animated:YES];
}

- (void)readKids {
    kids = [[ModelManager sharedInstance] findAll:@"Kid"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [kids count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellID";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                    reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSUInteger i = [indexPath indexAtPosition:1];
    Kid *kid = [kids objectAtIndex:i];
    cell.textLabel.text = kid.name;
    cell.detailTextLabel.text = [kid balanceString];
    return cell;
}

- (void)dismissModalEditor {
    [self dismissModalViewControllerAnimated:YES];
    [self readAndReload];
}

- (void)readAndReload {
    [self readKids];
    [((UITableView *)self.view) reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KidDetail *kidDetail = [[KidDetail alloc] initWithNibName:@"KidDetail" bundle:nil];
    kidDetail.kidsTable = self;
    Kid *kid = [kids objectAtIndex:[indexPath indexAtPosition:1]];
    [AllowanceAppDelegate setCurrentKid:kid];
    [self.navigationController pushViewController:kidDetail animated:YES];
}

@end

