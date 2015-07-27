//
//  HLCSettingController.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCSettingController.h"

//
#import "HLCMacros.h"

#import "HLCSettingVersionCell.h"
#import "HLCSettingScoreCell.h"
#import "HLCSettingRecommendCell.h"

@implementation HLCSettingController

- (instancetype)initViewController {
    if (self = [super initViewController]) {
        UIImage *tabImage = [UIImage imageNamed:@"icon_setting_normal"];
        UIImage *tabSelectImage = [UIImage imageNamed:@"icon_setting_height"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:tabImage selectedImage:tabSelectImage];
        }
    return self;
}

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"设置"];
}

#pragma mark - DateSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kHLCSettingAboutUsCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kHLCHeightForCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case kHLCSettingVersion: {
            static NSString *versionCellIndentifier = @"VersionCellIndetifier";
            HLCSettingVersionCell *cell = [tableView dequeueReusableCellWithIdentifier:versionCellIndentifier];
            if (!cell) {
                cell = [[HLCSettingVersionCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:versionCellIndentifier];
            }
            [cell setTitle:@"版本"];
            [cell setVersion:@"1.0.0"];
            
            return cell;
        }
            break;
        case kHLCSettingScore: {
            static NSString *scoreCellIndentifier = @"ScoreCellIndentifier";
            HLCSettingScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:scoreCellIndentifier];
            if (!cell) {
                cell = [[HLCSettingScoreCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:scoreCellIndentifier];
            }
            [cell setTitle:@"评分"];
            
            return cell;
        }
            break;
        case kHLCSettingRecommend: {
            static NSString *recommendCellIndentifier = @"RecommendCellIndentifier";
            HLCSettingRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCellIndentifier];
            if (!cell) {
                cell = [[HLCSettingRecommendCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:recommendCellIndentifier];
            }
            [cell setTitle:@"推荐给朋友"];
            
            return cell;
        }
            break;
        default:
            break;
    }
    
    return [[UITableViewCell alloc] init];
}


@end
