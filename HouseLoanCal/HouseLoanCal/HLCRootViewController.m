//
//  HLCRootViewController.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCRootViewController.h"

//
#import "HLCMacros.h"

//
#import "HLCProvidentFundLoanController.h"
#import "HLCCommercialLoanController.h"
#import "HLCMixedLoanController.h"
#import "HLCSettingController.h"

//
#import "HLCBaseNavigationController.h"

@implementation HLCRootViewController

- (id)init {
    if (self = [super init]) {
        //
        self.tabBar.barTintColor = kHLCTabBarColor;
        self.tabBar.tintColor = kHLCThemeColor;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        
        //
        HLCProvidentFundLoanController *profundLoanVC = [[HLCProvidentFundLoanController alloc] initViewController];
        HLCCommercialLoanController *commerLoanVC = [[HLCCommercialLoanController alloc] initViewController];
        HLCMixedLoanController *mixedLoanVC = [[HLCMixedLoanController alloc] initViewController];
        HLCSettingController *settingVC = [[HLCSettingController alloc] initViewController];
        
        //
        HLCBaseNavigationController *navProfundLoan = [[HLCBaseNavigationController alloc] initWithRootViewController:profundLoanVC];
        HLCBaseNavigationController *navCommerLoan = [[HLCBaseNavigationController alloc] initWithRootViewController:commerLoanVC];
        HLCBaseNavigationController *navMixedLoan = [[HLCBaseNavigationController alloc] initWithRootViewController:mixedLoanVC];
        HLCBaseNavigationController *navSetting = [[HLCBaseNavigationController alloc] initWithRootViewController:settingVC];
        
        self.viewControllers = [NSArray arrayWithObjects:
                                navProfundLoan,
                                navCommerLoan,
                                navMixedLoan,
                                navSetting,
                                nil];
    }
    return self;
}

@end
