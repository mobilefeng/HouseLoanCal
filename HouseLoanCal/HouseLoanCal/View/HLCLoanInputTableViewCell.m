//
//  HLCLoanInputTableViewCell.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/29.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCLoanInputTableViewCell.h"

//
#import "HLCMacros.h"

@interface HLCLoanInputTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end

@implementation HLCLoanInputTableViewCell

- (instancetype)initWithHLCStyle:(HLCLoanInputTableViewCellStyle)style reuseIdentifier:reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        CGFloat labelWidth = 100.0;
        CGFloat labelHeight = 20.0;
        CGFloat labelOffsetX = 10.0;
        CGFloat labelOffsetY = (self.bounds.size.height-labelHeight)*0.5;
        
        // 添加title
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelOffsetX, labelOffsetY, labelWidth, labelHeight)];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        _titleLabel.textColor = kHLCCellTitleColor;
        _titleLabel.font = [UIFont systemFontOfSize:kHLCCellTitleFont];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        CGRect detailRect = CGRectMake(self.bounds.size.width-labelOffsetX-labelWidth, labelOffsetY, labelWidth, labelHeight);
        
        switch (style) {
            case HLCLoanInputTableViewCellStyleTextField: {
                _textField = [[UITextField alloc] initWithFrame:detailRect];
                _textField.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
                _textField.textColor = kHLCCellDetailColor;
                _textField.font = [UIFont systemFontOfSize:kHLCCellDetailFont];
                _textField.textAlignment = NSTextAlignmentLeft;
                [self.contentView addSubview:_textField];
            }
                break;
            case HLCLoanInputTableViewCellStyleDatePicker: {
                _datePicker = [[UIDatePicker alloc] initWithFrame:detailRect];
                _datePicker.datePickerMode = UIDatePickerModeDate;
                
                // 设置时间
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-DD"];
                
                NSString *minDateString = @"1900-01-01";
                NSDate *minDate = [dateFormatter dateFromString:minDateString];
                _datePicker.minimumDate = minDate;
                
                NSString *maxDateString = @"2099-12-31";
                NSDate *maxDate = [dateFormatter dateFromString:maxDateString];
                _datePicker.maximumDate = maxDate;
                
                _datePicker.date = [NSDate date];
                
                [self.contentView addSubview:_datePicker];
            }
                break;
            case HLCLoanInputTableViewCellStyleSegmentedControl: {
                NSArray *segmentedArray = [[NSArray alloc] initWithObjects:@"等额本息", @"等额本金", nil];
                _segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
                _segmentedControl.frame = detailRect;
                _segmentedControl.selectedSegmentIndex = 0;
                [self.contentView addSubview:_segmentedControl];
            }
                break;
            default:
                break;
        }
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

@end
