//
//  HLCBaseNavigationController.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCBaseNavigationController.h"

// Macro
#import "HLCMacros.h"

@interface HLCBaseNavigationController () <UINavigationControllerDelegate>

@end

@implementation HLCBaseNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        // 设置navBar属性
        [self.navigationBar setTintColor:kHLCThemeColor];
        [[UINavigationBar appearance] setBarTintColor:kHLCNavBarColor];
        [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                    [UIFont systemFontOfSize:kHLCNavBarTitleFont], NSFontAttributeName,
                                                    kHLCNavBarTitleColor, NSForegroundColorAttributeName,
                                                    nil]];
        [self setNeedsStatusBarAppearanceUpdate];
        self.delegate = self;
    }
    return self;
}

@end
