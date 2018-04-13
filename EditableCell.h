//
//  EditableCell.h
//  Allowance
//
//  Created by Pablo Collins on 6/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditableCell : UITableViewCell <UITextViewDelegate> {
    UITextView *textView;
    id<UITextViewDelegate> textViewDelegate;
}

- (id)initWithStyle:(UITableViewCellStyle)style placeholder:(NSString *)text;
- (NSString *)text;
- (void)setText:(NSString *)text;
- (void)setTextViewDelegate:(id<UITextViewDelegate>)d;
- (void)hideKeyboard;

@end
