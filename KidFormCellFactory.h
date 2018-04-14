//
//  KidFormCellFactory.h
//  Allowance
//
//  Created by Pablo Collins on 6/16/10.
//

#import <Foundation/Foundation.h>
#import "KidFormCell.h"


@interface KidFormCellFactory : NSObject {
}

- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath;

@end
