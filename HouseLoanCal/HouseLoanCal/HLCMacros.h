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

// ___________________________________________________________
//

// NavBar 标题字体
#define kHLCNavBarTitleFont         (20.0)



#endif
