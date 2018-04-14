//
//  AllowanceAppDelegate.h
//  Allowance
//
//  Created by Pablo Collins on 6/10/10.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Kid.h"

@interface AllowanceAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *__unsafe_unretained navController;
    Kid *__unsafe_unretained kid;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, unsafe_unretained) IBOutlet UINavigationController *navController;

@property (nonatomic, unsafe_unretained) Kid *kid;

+ (Kid *)currentKid;
+ (void)setCurrentKid:(Kid *)kid;
+ (int)paymentDay;
+ (NSString *)delimiter;
+ (NSString *)currency;
+ (Account *)masterAccount;
+ (UIButton *)newButtonWithTitle:(NSString *)title
                          target:(id)target
                        selector:(SEL)selector
                           frame:(CGRect)frame
                           image:(UIImage *)image
                    imagePressed:(UIImage *)imagePressed
                   darkTextColor:(BOOL)darkTextColor;
+ (NSString *)priceFromDouble:(double)d;
+ (NSNumberFormatter *)currencyFormatter;
+ (int)numCentPlaces;
+ (int)priceDenominator;

@end
