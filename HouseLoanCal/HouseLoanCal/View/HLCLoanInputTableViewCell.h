//
//  HLCLoanInputTableViewCell.h
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/29.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCTableViewCell.h"

typedef NS_ENUM(NSInteger, HLCLoanInputTableViewCellStyle) {
    HLCLoanInputTableViewCellStyleTextField,            // Title + TextField
    HLCLoanInputTableViewCellStyleDatePicker,           // Title + DataPicker
    HLCLoanInputTableViewCellStyleSegmentedControl,     // Title + SegmentedControl
};

@interface HLCLoanInputTableViewCell : HLCTableViewCell

- (instancetype)initWithHLCStyle:(HLCLoanInputTableViewCellStyle)style reuseIdentifier:reuseIdentifier;

- (void)setTitle:(NSString *)title;

@end
