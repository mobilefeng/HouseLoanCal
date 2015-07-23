//
//  HLCCommercialLoanController.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCCommercialLoanController.h"

@implementation HLCCommercialLoanController

- (instancetype)initViewController {
    if (self = [super initViewController]) {
        UIImage *tabImage = [UIImage imageNamed:@"icon_commer_normal"];
        UIImage *tabSelectImage = [UIImage imageNamed:@"icon_commer_height"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"商业贷款" image:tabImage selectedImage:tabSelectImage];
    }
    return self;
}

@end
