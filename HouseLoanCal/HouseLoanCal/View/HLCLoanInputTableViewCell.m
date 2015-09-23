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

#import "HLCTextField.h"

@interface HLCLoanInputTableViewCell () <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSMutableArray *pickerArray;

@end

@implementation HLCLoanInputTableViewCell

- (instancetype)initWithHLCStyle:(HLCLoanInputTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTag:(NSInteger)tag{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        // Title Frame
        CGFloat titleWidth = 170.0;
        CGFloat titleHeight = 28.0;
        CGFloat titleOffsetX = 15.0;
        CGFloat titleOffsetY = (self.bounds.size.height-titleHeight)*0.5;
        
        // 添加 Title
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleOffsetX, titleOffsetY, titleWidth, titleHeight)];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        _titleLabel.textColor = kHLCCellTitleColor;
        _titleLabel.font = [UIFont systemFontOfSize:kHLCCellTitleFont];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        // Detail Frame
        CGFloat detailWidth = self.bounds.size.width - titleWidth - 2*titleOffsetX;
        CGFloat detailHeight = titleHeight;
        CGFloat detailOffsetX = titleOffsetX + titleWidth;
        CGFloat detailOffsetY = titleOffsetY;
        
        CGRect detailRect = CGRectMake(detailOffsetX, detailOffsetY, detailWidth, detailHeight);
        
        switch (style) {
            case HLCLoanInputTableViewCellStyleTextField: {
                [self initTextFieldWithFrame:detailRect];
                _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                _textField.delegate = self;
                _textField.tag = tag;
                _textField.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
                [self.contentView addSubview:_textField];
            }
                break;
            case HLCLoanInputTableViewCellStylePickerView: {
                [self initTextFieldWithFrame:detailRect];
                _textField.font = [UIFont systemFontOfSize:kHLCCellDetailFont];
                _textField.delegate = self;
                _textField.tag = tag;
                _textField.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
                [self.contentView addSubview:_textField];
                
                // 设置 pickerView
                [self initPickerView];
                _textField.inputView = _pickerView;
            }
                break;
            case HLCLoanInputTableViewCellStyleDatePicker: {
                // 设置 textField
                [self initTextFieldWithFrame:detailRect];
                _textField.font = [UIFont systemFontOfSize:kHLCCellDetailFont];
                _textField.delegate = self;
                _textField.tag = tag;
                _textField.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
                [self.contentView addSubview:_textField];
                
                // 设置 datePicker
                [self initDatePicker];
                _textField.inputView = _datePicker;
            }
                break;
            case HLCLoanInputTableViewCellStyleSegmentedControl: {
                NSArray *segmentedArray = [[NSArray alloc] initWithObjects:@"等额本息", @"等额本金", nil];
                _segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
                _segmentedControl.frame = detailRect;
                _segmentedControl.selectedSegmentIndex = 0;
                _segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
                [_segmentedControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
                [self.contentView addSubview:_segmentedControl];
            }
                break;
            default:
                break;
        }
        [self initInputAccessoryView];
    }
    
    return self;
}

#pragma mark - Set Method

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

- (void)setPlaceHold:(NSString *)placeHold {
    _textField.placeholder = placeHold;
}

- (void)setTextFieldValue:(NSString *)value {
    _textField.text = value;
}

- (void)setTextFieldBlank {
    _textField.text = nil;
}

#pragma mark - Init Method

- (void)initTextFieldWithFrame:(CGRect)rect {
    _textField = [[HLCTextField alloc] initWithFrame:rect];
    _textField.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    _textField.textColor = kHLCCellDetailColor;
    _textField.font = [UIFont systemFontOfSize:kHLCCellDetailFont];
    _textField.textAlignment = NSTextAlignmentLeft;
    
    _textField.layer.cornerRadius = 4.0f;
    _textField.layer.masksToBounds = YES;
    _textField.layer.borderColor = kHLCCellTextFieldBoardColor.CGColor;
    _textField.layer.borderWidth = 1.0f;
    
    _textField.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void)initPickerView {
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    _pickerView.delegate = self;
    
    _pickerArray = [[NSMutableArray alloc] init];
    [_pickerArray addObject:[NSNumber numberWithDouble:0.5]];
    for (int index = 1; index <= 30; index ++) {
        [_pickerArray addObject:[NSNumber numberWithInt:index]];
    }
    
    // 默认选中30年
    [_pickerView selectRow:([_pickerArray count]-1) inComponent:0 animated:YES];
    _textField.text = [NSString stringWithFormat:@"%@", [_pickerArray objectAtIndex:([_pickerArray count]-1)]];
}

- (void)initDatePicker {
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    
    // 时间格式
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy年MM月"];
    [_dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    
    // 时间范围
    NSString *minDateString = @"1900-01-01";
    NSDate *minDate = [_dateFormatter dateFromString:minDateString];
    _datePicker.minimumDate = minDate;
    NSString *maxDateString = @"2099-12-31";
    NSDate *maxDate = [_dateFormatter dateFromString:maxDateString];
    _datePicker.maximumDate = maxDate;
    
    // 获取当前时间
    _datePicker.date = [NSDate date];
    
    // 设置时间默认值为当前时间
    _textField.text = [_dateFormatter stringFromDate:_datePicker.date];
    
    // 当日期变化时，修改显示的时间
    [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)initInputAccessoryView {
    CGFloat toolBarWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat toolBarHeight = 44.0;
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, toolBarWidth, toolBarHeight)];
    
    CGFloat buttonWidth = 50.0;
    CGFloat buttonHeight = 30.0;
    
    // 空白区域，用于讲两个按钮挤到右侧
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = toolBarWidth - 3*buttonWidth;
    
    // 重置按钮
    UIButton *resetButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
    [resetButton setTitle:@"重置" forState:UIControlStateNormal];
    [resetButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [resetButton.layer setMasksToBounds:YES];
    [resetButton.layer setCornerRadius:5.0];
    [resetButton.layer setBorderWidth:1.0];
    [resetButton.layer setBorderColor:[UIColor blueColor].CGColor];
    [resetButton addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:resetButton];
    
    // 计算按钮
    UIButton *calculButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
    [calculButton setTitle:@"计算" forState:UIControlStateNormal];
    [calculButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [calculButton.layer setMasksToBounds:YES];
    [calculButton.layer setCornerRadius:5.0];
    [calculButton.layer setBorderWidth:1.0];
    [calculButton.layer setBorderColor:[UIColor blueColor].CGColor];
    [calculButton addTarget:self action:@selector(calculateAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:calculButton];
    
    // 将几个控件塞进 toolBar
    toolBar.items = [NSArray arrayWithObjects:fixedSpace, item1, item2, nil];
    
    // toolBar 底部加条分割线
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, toolBarHeight-0.5, toolBarWidth, 0.5)];
    bottomLine.backgroundColor = kHLCToolBarBottomLineColor;
    [toolBar addSubview:bottomLine];

    _textField.inputAccessoryView = toolBar;
}

#pragma mark - UITableViewCell Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(inputFieldDidEndEditing:)]) {
        [_delegate inputFieldDidEndEditing:textField];
    }
}


#pragma mark - UIPickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_pickerArray count];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSNumber *pickerNum = [_pickerArray objectAtIndex:row];
    if (0 == row) {
        return [NSString stringWithFormat:@"%.1f年（%.0f期）", pickerNum.doubleValue, pickerNum.doubleValue*12];
    } else {
        return [NSString stringWithFormat:@"%.0f年（%.0f期）", pickerNum.doubleValue, pickerNum.doubleValue*12];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _textField.text = [NSString stringWithFormat:@"%@", [_pickerArray objectAtIndex:row]];
    if ([_delegate respondsToSelector:@selector(inputFieldDidEndEditing:)]) {
        [_delegate inputFieldDidEndEditing:_textField];
    }
}

#pragma mark - Action Method

- (void)dateChanged:(UIDatePicker *)sender {
    NSDate *selectedDate = sender.date;
    NSString *dateString = [self.dateFormatter stringFromDate:selectedDate];
    self.textField.text = dateString;
}

- (void)resetAction:(id)sender {
    [self.textField resignFirstResponder];
    if ([_delegate respondsToSelector:@selector(resetButtonDidClick:)]) {
        [_delegate resetButtonDidClick:sender];
    }
}

- (void)calculateAction:(UITextField *)textField {
    [self.textField resignFirstResponder];
    if ([_delegate respondsToSelector:@selector(calculateButtonDidClick:)]) {
        [_delegate calculateButtonDidClick:textField];
    }
}

- (void)segmentedControlAction:(UISegmentedControl *)segmentedControl {
    if ([_delegate respondsToSelector:@selector(segmentedControlDidChange:)]) {
        [_delegate segmentedControlDidChange:segmentedControl];
    }
}

@end
