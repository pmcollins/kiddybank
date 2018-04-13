//
//  CurrencyEditor.h
//  Allowance
//
//  Created by Pablo Collins on 8/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reloadable.h"


@interface CurrencyEditor : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet UIPickerView *picker;
    IBOutlet UILabel *label;
    NSArray *symbols, *delims;
    id<Reloadable> __unsafe_unretained reloadableParent;
}

@property (unsafe_unretained, nonatomic) id<Reloadable> reloadableParent;

- (void)print;

@end
