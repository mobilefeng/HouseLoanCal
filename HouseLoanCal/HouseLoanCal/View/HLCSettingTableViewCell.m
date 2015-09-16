//
//  HLCSettingTableViewCell.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/29.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCSettingTableViewCell.h"

//
#import "HLCMacros.h"

@interface HLCSettingTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation HLCSettingTableViewCell

- (instancetype)initWithHLCStyle:(HLCSettingTableViewCellStyle)style reuseIdentifier:reuseIdentifier {
    self = [super initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIdentifier];
    
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
        [self.contentView addSubview:_titleLabel];
        
        switch (style) {
            case HLCSettingTableViewCellStyleContent: {
                _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-labelOffsetX-labelWidth, labelOffsetY, labelWidth, labelHeight)];
                _contentLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
                _contentLabel.textColor = kHLCCellDetailColor;
                _contentLabel.font = [UIFont systemFontOfSize:kHLCCellDetailFont];
                _contentLabel.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_contentLabel];
            }
                break;
            case HLCSettingTableViewCellStyleAccessory: {
                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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

- (void)setContent:(NSString *)content {
    _contentLabel.text = content;
}

@end
