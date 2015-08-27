//
//  HLCLoanOutputTableViewCell.h
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/29.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCTableViewCell.h"

typedef NS_ENUM(NSInteger, HLCLoanOutputTableViewCellStyle) {
    HLCLoanOutputTableViewCellStyleLarge,   // 大号字体
    HLCLoanOutputTableViewCellStyleSmall,   // 小号字体
};

@interface HLCLoanOutputTableViewCell : HLCTableViewCell

- (instancetype)initWithHLCStyle:(HLCLoanOutputTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setTitle:(NSString *)title;
- (void)setDetail:(NSString *)detail;

@end
