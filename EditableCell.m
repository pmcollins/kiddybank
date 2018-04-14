//
//  EditableCell.m
//  Allowance
//
//  Created by Pablo Collins on 6/12/10.
//

#import "EditableCell.h"

@implementation EditableCell

- (id)initWithStyle:(UITableViewCellStyle)style placeholder:(NSString *)text {
    if ((self = [super initWithStyle:style reuseIdentifier:@"cell"])) {
        //self.contentView.frame = CGRectMake(4, 4, 320, 40);
        textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 8, 280, 70)];
        //textView.font = [UIFont fontWithName:@"Marker Felt" size:18];
        textView.font = [UIFont systemFontOfSize:18];
        //NSLog(@"%@", [[UIFont familyNames] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]);
        //textArea.returnKeyType = UIReturnKeyDone;
        //textArea.placeholder = text;
        //textArea.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        //textArea.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        textView.delegate = self;
        [self addSubview:textView];
    }
    return self;
}

- (void)setText:(NSString *)text {
    textView.text = text;
}

- (NSString *)text {
    return textView.text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
}

- (void)hideKeyboard
{
    [textView resignFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)tv
{
    [textViewDelegate textViewDidBeginEditing:tv];
}

- (void)textViewDidEndEditing:(UITextView *)tv
{
    [textViewDelegate textViewDidEndEditing:tv];
}

- (void)setTextViewDelegate:(id<UITextViewDelegate>)d
{
    textViewDelegate = d;
}

@end
