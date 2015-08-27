//
//  HLCMacros.h
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#ifndef HouseLoanCal_HLCMacros_h
#define HouseLoanCal_HLCMacros_h

// ___________________________________________________________
//

// RGB颜色
#define UIColorFromRGB(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])

// TabBar 背景色
#define kHLCTabBarColor             (UIColorFromRGB(0xF7F7F7))

// NavBar 背景色
#define kHLCNavBarColor             (UIColorFromRGB(0xF7F7F7))

// 主题色
#define kHLCThemeColor              (UIColorFromRGB(0xFF4683))

// NavBar 标题颜色
#define kHLCNavBarTitleColor        (UIColorFromRGB(0x111111))

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


// ___________________________________________________________
//

// Cell 高度
#define kHLCHeightForCell           (44.0)

// Cell Header 高度
#define kHLCHeightForCellHeader     (16.0)



#endif
