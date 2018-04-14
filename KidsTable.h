//
//  KidsTable.h
//  Allowance
//
//  Created by Pablo Collins on 6/10/10.
//

#import <UIKit/UIKit.h>
#import "NewKidForm.h"
#import "KidDetail.h"
#import "Kid.h"
#import "Reloadable.h"
#import "SettingsEditor.h"


@interface KidsTable : UITableViewController<ModalEditorDelegate, Reloadable> {
    UIBarButtonItem *addButton, *settingsButton;
    NSArray *kids;
}

- (UIBarButtonItem *)addButton;
- (UIBarButtonItem *)settingsButton;
- (void)pushedAdd:(id)sender;
- (void)pushedSettings:(id)sender;
- (void)readKids;
- (void)readAndReload;

@end
