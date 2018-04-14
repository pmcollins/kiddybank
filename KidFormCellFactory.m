//
//  KidFormCellFactory.m
//  Allowance
//
//  Created by Pablo Collins on 6/16/10.
//

#import "KidFormCellFactory.h"


@implementation KidFormCellFactory

- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath {
    return [[KidFormCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
}

@end
