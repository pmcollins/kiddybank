//
//  KidFormCellFactory.h
//  Allowance
//
//  Created by Pablo Collins on 6/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KidFormCell.h"


@interface KidFormCellFactory : NSObject {
}

- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath;

@end
