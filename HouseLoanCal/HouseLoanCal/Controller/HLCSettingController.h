//
//  HLCSettingController.h
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCBaseTableViewController.h"

/*
 *  Aboutus Section Row
 */
enum {
    // 版本
    kHLCSettingVersion = 0,
    // 评分
    kHLCSettingScore,
    // 推荐给朋友
    kHLCSettingRecommend,
    // Row 数
    kHLCSettingAboutUsCount,
};

@interface HLCSettingController : HLCBaseTableViewController

@end
