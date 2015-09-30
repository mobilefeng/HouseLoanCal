//
//  HLCRootViewController.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCRootViewController.h"

// Macro
#import "HLCMacros.h"

// Controller
#import "HLCProvidentFundLoanController.h"
#import "HLCCommercialLoanController.h"
#import "HLCMixedLoanController.h"
#import "HLCSettingController.h"
#import "HLCBaseNavigationController.h"


@implementation HLCRootViewController

- (id)init {
    if (self = [super init]) {
        // 设置TabBar
        self.tabBar.barTintColor = kHLCTabBarColor;
        self.tabBar.tintColor = kHLCThemeColor;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        
        // 生成各个页面的VC
        HLCProvidentFundLoanController *profundLoanVC = [[HLCProvidentFundLoanController alloc] initViewController];
        HLCCommercialLoanController *commerLoanVC = [[HLCCommercialLoanController alloc] initViewController];
        HLCMixedLoanController *mixedLoanVC = [[HLCMixedLoanController alloc] initViewController];
        HLCSettingController *settingVC = [[HLCSettingController alloc] initViewController];
        
        // 将页面VC添加到navVC
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
