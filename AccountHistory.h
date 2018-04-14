//
//  AccountHistory.h
//  Allowance
//
//  Created by Pablo Collins on 7/17/10.
//

#import <UIKit/UIKit.h>
#import "TxHistory.h"

@interface AccountHistory : UITableViewController {
    TxHistory *hist;
    NSDateFormatter *dateFormatter;
}

@end
