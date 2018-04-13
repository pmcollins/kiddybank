//
//  AllowanceAppDelegate.m
//  Allowance
//
//  Created by Pablo Collins on 6/10/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "AllowanceAppDelegate.h"

@implementation AllowanceAppDelegate

@synthesize window, navController, kid;

static AllowanceAppDelegate *sharedInstance;
static NSNumberFormatter *currencyFormatter;

+ (NSNumberFormatter *)currencyFormatter {
    if (currencyFormatter == nil) {
        currencyFormatter = [[NSNumberFormatter alloc] init];
        [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    }
    return currencyFormatter;
}

+ (NSString *)priceFromDouble:(double)d {
    NSString *out = [[self currencyFormatter] stringFromNumber:[NSNumber numberWithDouble:d]];
    return out;
}

+ (NSInteger)paymentDay {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"payDay"];
}

+ (NSString *)delimiter {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"delimeter"];
}

+ (NSString *)currency {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"currency"];
}

+ (Kid *)currentKid {
    return sharedInstance.kid;
}

+ (void)setCurrentKid:(Kid *)kid {
    sharedInstance.kid = kid;
}

+ (Account *)masterAccount {
    static Account *masterAcct;
    if (masterAcct == nil) {
        masterAcct = [Account masterAccount];
    }
    return masterAcct;
}

+ (UIButton *)newButtonWithTitle:(NSString *)title
                          target:(id)target
                        selector:(SEL)selector
                           frame:(CGRect)frame
                           image:(UIImage *)image
                    imagePressed:(UIImage *)imagePressed
                   darkTextColor:(BOOL)darkTextColor
{
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	// or you can do this:
	//		UIButton *button = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	
	button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	
	[button setTitle:title forState:UIControlStateNormal];	
	if (darkTextColor) {
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	} else {
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	}
	
	UIImage *newImage = [image stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	[button setBackgroundImage:newImage forState:UIControlStateNormal];
	
	UIImage *newPressedImage = [imagePressed stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	[button setBackgroundImage:newPressedImage forState:UIControlStateHighlighted];
	
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	
    // in case the parent view draws with a custom color or gradient, use a transparent color
	button.backgroundColor = [UIColor clearColor];
	
	return button;
}

static NSNumber *numCentPlaces;

+ (int)numCentPlaces {
    if (numCentPlaces == nil) {
        NSLocale *l = [NSLocale currentLocale];
        NSString *cc = [l objectForKey:NSLocaleCurrencyCode];
        int n;
        double rounding;
        if (cc == nil) { //getting nils here suddenly on simulator
            numCentPlaces = [NSNumber numberWithInt:2];
        } else {
            CFNumberFormatterGetDecimalInfoForCurrencyCode((__bridge CFStringRef)cc, &n, &rounding);
            numCentPlaces = [NSNumber numberWithInt:n];
        }
    }
    return [numCentPlaces intValue];
}

static NSNumber *priceDenominator;
+ (int)priceDenominator {
    if (priceDenominator == nil) {
        priceDenominator = [NSNumber numberWithInt:pow(10, [AllowanceAppDelegate numCentPlaces])];
    }
    return [priceDenominator intValue];
}

- (id)init {
    self = [super init];
    sharedInstance = (AllowanceAppDelegate *)self;
    return self;
}

- (void)updateAccounts {
    NSArray *kids = [[ModelManager sharedInstance] findAll:@"Kid"];
    NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:[kids count]];
    for (Kid *k in kids) {
        int wks = [k updateAccount];
        if (wks) {
            [a addObject:[NSNumber numberWithInt:wks]];
        }
    }
    if ([a count]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Allowance Credited"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)setupDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int payDay = [defaults integerForKey:@"payDay"];
    if (payDay == 0) {
        //first time log in
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome to Kiddy Bank"
                                                        message:@"To start, create an account by touching the '+' button at the top right."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [defaults setInteger:1 forKey:@"payDay"];
    }
    [Account findOrCreateMasterAccount];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [window addSubview:navController.view];
    [window makeKeyAndVisible];
    [self setupDefaults];
	return YES;
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
    [self updateAccounts];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self updateAccounts];
}

@end


