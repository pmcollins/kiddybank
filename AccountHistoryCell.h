//
//  AccountHistoryCell.h
//  Allowance
//
//  Created by Pablo Collins on 4/28/11.
//

#import <UIKit/UIKit.h>

@interface AccountHistoryCell : UITableViewCell {
    UILabel *typeLabel, *dateLabel, *amountLabel, *notesLabel, *balanceLabel, *iconLabel;
    UITableViewCell *xibTableViewCell;
}

@property (nonatomic, strong) IBOutlet UILabel *typeLabel, *dateLabel,
                                                *amountLabel, *notesLabel,
                                                *balanceLabel, *iconLabel;
@property (nonatomic, strong) IBOutlet UITableViewCell *xibTableViewCell;

- (void)setBalance:(NSString *)b;

@end
