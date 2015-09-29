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
#import "HLCSettingTableViewCell.h"

// 友盟统计
#import "MobClick.h"

// 友盟分享
#import "UMSocial.h"

@interface HLCSettingController ()<UMSocialUIDelegate>

@end

@implementation HLCSettingController

- (instancetype)initViewController {
    if (self = [super initViewController]) {
        UIImage *tabImage = [UIImage imageNamed:@"icon_setting_normal"];
        UIImage *tabSelectImage = [UIImage imageNamed:@"icon_setting_height"];
        tabSelectImage = [tabSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:tabImage selectedImage:tabSelectImage];
        }
    return self;
}

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"设置"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PageSetting"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PageSetting"];
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
            HLCSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:versionCellIndentifier];
            if (!cell) {
                cell = [[HLCSettingTableViewCell alloc] initWithHLCStyle:(HLCSettingTableViewCellStyleContent) reuseIdentifier:versionCellIndentifier];
            }
            [cell setTitle:@"当前版本"];
            [cell setContent:[NSString stringWithFormat:@"%@", HLC_APP_VERSION]];
            
            return cell;
        }
            break;
        case kHLCSettingComment: {
            static NSString *scoreCellIndentifier = @"ScoreCellIndentifier";
            HLCSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:scoreCellIndentifier];
            if (!cell) {
                cell = [[HLCSettingTableViewCell alloc] initWithHLCStyle:(HLCSettingTableViewCellStyleAccessory) reuseIdentifier:scoreCellIndentifier];
            }
            [cell setTitle:@"五星好评"];
            
            return cell;
        }
            break;
        case kHLCSettingRecommend: {
            static NSString *recommendCellIndentifier = @"RecommendCellIndentifier";
            HLCSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCellIndentifier];
            if (!cell) {
                cell = [[HLCSettingTableViewCell alloc] initWithHLCStyle:(HLCSettingTableViewCellStyleAccessory) reuseIdentifier:recommendCellIndentifier];
            }
            [cell setTitle:@"推荐朋友"];
            
            return cell;
        }
            break;
    }
    
    return [[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case kHLCSettingComment: {
            [MobClick event:kHLCCommentClick];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kHLCAppStore]];
        }
            break;
        case kHLCSettingRecommend: {
            [MobClick event:kHLCRecommendClick];
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:@"5602ae2de0f55ace17001418"
                                              shareText:@"极简房贷计算器 From @xuyang"
                                             shareImage:[UIImage imageNamed:@"shareAppIcon"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession, UMShareToWechatTimeline, UMShareToSina, nil]
                                               delegate:self];
        }
            break;
    }
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    //根据 responseCode 得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

@end
