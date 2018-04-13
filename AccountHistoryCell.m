//
//  AccountHistoryCell.m
//  Allowance
//
//  Created by Pablo Collins on 4/28/11.
//  Copyright 2011 trickbot. All rights reserved.
//

#import "AccountHistoryCell.h"
//#import <QuartzCore/QuartzCore.h>

@implementation AccountHistoryCell

@synthesize typeLabel, dateLabel, amountLabel, xibTableViewCell, notesLabel, balanceLabel, iconLabel;

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    [[NSBundle mainBundle] loadNibNamed:@"AccountHistoryCell" owner:self options:nil];
    [self.contentView addSubview:xibTableViewCell.contentView];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //balanceLabel.layer.cornerRadius = 4;
    return self;
}

- (void)setBalance:(NSString *)b
{
    /*
    CGSize size = [s sizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:CGSizeMake(100, 13)];
    static int padding = 8;
    balanceLabel.frame = CGRectMake(balanceLabel.frame.origin.x - size.width + 60 - padding, balanceLabel.frame.origin.y, size.width + padding, balanceLabel.frame.size.height);
     */
    NSString *s = [NSString stringWithFormat:@"bal. %@", b];
    balanceLabel.text = s;
}


@end

