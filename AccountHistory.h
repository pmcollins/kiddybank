//
//  AccountHistory.h
//  Allowance
//
//  Created by Pablo Collins on 7/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TxHistory.h"

@interface AccountHistory : UITableViewController {
    TxHistory *hist;
    NSDateFormatter *dateFormatter;
}

@end
