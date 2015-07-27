//
//  HLCSettingController.h
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCBaseTableViewController.h"

/*
 *  AboutUs Section Row
 */
enum {
    // 版本
    kHLCSettingVersion = 0,
    // 评分
    kHLCSettingScore,
    // 推荐给朋友
    kHLCSettingRecommend,
    //
    kHLCSettingAboutUsCount,
};

@interface HLCSettingController : HLCBaseTableViewController

@end
