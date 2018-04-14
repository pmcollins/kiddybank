//
//  SettingsEditor.h
//  Allowance
//
//  Created by Pablo Collins on 7/5/10.
//

#import <UIKit/UIKit.h>
#import "ModalEditorDelegate.h"
#import "WeekDays.h"
#import "AllowanceDayEditor.h"
#import "CurrencyEditor.h"

@interface SettingsEditor : UITableViewController <Reloadable> {
    id<ModalEditorDelegate> __unsafe_unretained opener;
}

@property (nonatomic, unsafe_unretained) id<ModalEditorDelegate> opener;

- (UITableViewCell *)doneCell;
- (UITableViewCell *)payDayCell;
- (void)doneButtonClicked:(id)sender;
//- (UITableViewCell *)currencyCell;

@end
