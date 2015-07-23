//
//  HLCMixedLoanController.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCMixedLoanController.h"

@implementation HLCMixedLoanController

- (instancetype)initViewController {
    if (self = [super initViewController]) {
        UIImage *tabImage = [UIImage imageNamed:@"icon_mixed_normal"];
        UIImage *tabSelectImage = [UIImage imageNamed:@"icon_mixed_height"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"混合贷款" image:tabImage selectedImage:tabSelectImage];
    }
    return self;
}

@end
