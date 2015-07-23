//
//  HLCSettingController.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCSettingController.h"

@implementation HLCSettingController

- (instancetype)initViewController {
    if (self = [super initViewController]) {
        UIImage *tabImage = [UIImage imageNamed:@"icon_setting_normal"];
        UIImage *tabSelectImage = [UIImage imageNamed:@"icon_setting_height"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:tabImage selectedImage:tabSelectImage];
        
        [self.navigationItem setTitle:@"设置"];
    }
    return self;
}

#pragma mark - DateSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;//kHLCSettingSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numOfRows = 0;
    
    if (section >= 0 && section < kHLCSettingSectionCount) {
        switch (section) {
            case kHLCSettingSectionAboutUs: {
                numOfRows = kHLCSettingAboutUsCount;
            }
                break;
        }
    }
    
    return numOfRows;
}



@end
