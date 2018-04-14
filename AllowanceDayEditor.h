//
//  AllowanceDayEditor.h
//  Allowance
//
//  Created by Pablo Collins on 6/27/10.
//

#import <UIKit/UIKit.h>
#import "WeekDays.h"
#import "Reloadable.h"


@interface AllowanceDayEditor : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet UIPickerView *dayPicker;
    id<Reloadable> __unsafe_unretained reloadableParent;
}

@property (unsafe_unretained, nonatomic) id<Reloadable> reloadableParent;

- (IBAction)save:(id)sender;

@end
