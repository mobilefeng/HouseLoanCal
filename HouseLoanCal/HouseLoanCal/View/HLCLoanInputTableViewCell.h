//
//  HLCLoanInputTableViewCell.h
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/29.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCTableViewCell.h"

@protocol HLCLoanInputTableViewCellDelegate;

typedef NS_ENUM(NSInteger, HLCLoanInputTableViewCellStyle) {
    HLCLoanInputTableViewCellStyleTextField,            // Title + TextField
    HLCLoanInputTableViewCellStyleDatePicker,           // Title + DataPicker
    HLCLoanInputTableViewCellStyleSegmentedControl,     // Title + SegmentedControl
};

@interface HLCLoanInputTableViewCell : HLCTableViewCell

@property (nonatomic, weak)id <HLCLoanInputTableViewCellDelegate>delegate;

- (instancetype)initWithHLCStyle:(HLCLoanInputTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTag:(NSInteger)tag;

- (void)setTitle:(NSString *)title;
- (void)setPlaceHold:(NSString *)placeHold;
- (void)setTextFieldValue:(NSString *)value;
- (void)setTextFieldBlank;

@end

// _____________________________________________________________________________________
//
@protocol HLCLoanInputTableViewCellDelegate <NSObject>

@required

- (void)resetButtonDidClick:(UITextField *)textField;

- (void)calculateButtonDidClick:(UITextField *)textField;

- (void)inputFieldDidEndEditing:(UITextField *)textField;

- (void)segmentedControlDidChange:(UISegmentedControl *)segmentedControl;

@end
