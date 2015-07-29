//
//  HLCSettingTableViewCell.h
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/29.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCTableViewCell.h"

typedef NS_ENUM(NSInteger, HLCSettingTableViewCellStyle) {
    HLCSettingTableViewCellStyleContent,    // Title + Content
    HLCSettingTableViewCellStyleAccessory,  // Title + Accessory
};

@interface HLCSettingTableViewCell : HLCTableViewCell

- (instancetype)initWithHLCStyle:(HLCSettingTableViewCellStyle)style reuseIdentifier:reuseIdentifier;

- (void)setTitle:(NSString *)title;
- (void)setContent:(NSString *)content;

@end
