//
//  HLCMacros.h
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#ifndef HouseLoanCal_HLCMacros_h
#define HouseLoanCal_HLCMacros_h



#pragma mark - 系统
// ___________________________________________________________
//
// 版本号
#define HLC_APP_VERSION     ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
// App Store 链接
#define kHLCAppStore        @"https://itunes.apple.com/cn/app/id1043888133"



#pragma mark - 颜色
// ___________________________________________________________
//
// RGB颜色
#define UIColorFromRGB(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])

// TabBar 背景色
#define kHLCTabBarColor             (UIColorFromRGB(0xF0F0F0))

// NavBar 背景色
#define kHLCNavBarColor             (UIColorFromRGB(0x111111))

// 主题色
#define kHLCThemeColor              (UIColorFromRGB(0x2D7DA4))

// NavBar 标题颜色
#define kHLCNavBarTitleColor        (UIColorFromRGB(0xFAFAFA))

// 页面背景颜色
#define kHLCBackgroundColor         (UIColorFromRGB(0xEEEEEE))

// Cell 标题颜色
#define kHLCCellTitleColor          (UIColorFromRGB(0x222222))

// Cell 详情颜色
#define kHLCCellDetailColor         (UIColorFromRGB(0x222222))

// Cell 选中时的颜色
#define kHLCCellSelectedColor       (UIColorFromRGB(0xF6F6F6))

// Cell 分隔线颜色
#define kHLCCellSeparatorLineColor  (UIColorFromRGB(0xD6D6D6))

// Cell TextField 边框颜色
#define kHLCCellTextFieldBoardColor (UIColorFromRGB(0xD6D6D6))

// Cell Bottom Line 颜色
#define kHLCCellBottomLineColor     (UIColorFromRGB(0xA6A6A6))

// ToolBar Bottom Line 颜色
#define kHLCToolBarBottomLineColor  (UIColorFromRGB(0xA6A6A6))

// SegmentedControl 颜色
#define kHLCSegmentedControlColor   (UIColorFromRGB(0x2D7DA4))



#pragma mark - 字体
// ___________________________________________________________
//
// NavBar 标题字体
#define kHLCNavBarTitleFont         (20.0)

// Cell 标题字体
#define kHLCCellTitleFont           (18.0)

// Cell 详情字体
#define kHLCCellDetailFont          (16.0)

// Cell 标题字体（小号）
#define kHLCCellTitleSmallFont       (14.0)

// Cell 详情字体（小号）
#define kHLCCellDetailSmallFont     (14.0)



#pragma mark - 尺寸
// ___________________________________________________________
//
// Cell 高度
#define kHLCHeightForCell           (44.0)

// Cell Header 高度
#define kHLCHeightForCellSeparator  (16.0)



#pragma mark - 友盟事件ID
// ___________________________________________________________
//
// 公积金贷款计算点击
#define kHLCProfundCalClick         @"Profund_Cal_Click"

// 公积金贷款重置点击
#define kHLCProfundResetClick       @"Profund_Reset_Click"

// 商业贷款计算点击
#define kHLCCommerCalClick          @"Commer_Cal_Click"

// 商业贷款重置点击
#define kHLCCommerResetClick        @"Commer_Reset_Click"

// 组合贷款计算点击
#define kHLCMixedCalClick           @"Mixed_Cal_Click"

// 组合贷款重置点击
#define kHLCMixedResetClick         @"Mixed_Reset_Click"

// 五星好评点击
#define kHLCCommentClick            @"Comment_Click"

// 推荐好友点击
#define kHLCRecommendClick          @"Recommend_Click"


#endif
