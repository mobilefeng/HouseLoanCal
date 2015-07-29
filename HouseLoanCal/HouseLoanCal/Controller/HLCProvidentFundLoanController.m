//
//  HLCProvidentFundLoanController.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCProvidentFundLoanController.h"

@implementation HLCProvidentFundLoanController

- (instancetype)initViewController {
    if (self = [super initViewController]) {
        UIImage *tabImage = [UIImage imageNamed:@"icon_profund_normal"];
        UIImage *tabSelectImage = [UIImage imageNamed:@"icon_profund_height"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"公积金贷款" image:tabImage selectedImage:tabSelectImage];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"公积金贷款"];
}

#pragma mark - DataSource


@end
