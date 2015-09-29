//
//  HLCLoanOutputTableViewCell.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/29.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCLoanOutputTableViewCell.h"

//
#import "HLCMacros.h"

@interface HLCLoanOutputTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation HLCLoanOutputTableViewCell

- (instancetype)initWithHLCStyle:(HLCLoanOutputTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self) {
        CGFloat cellWidth = self.bounds.size.width;
        CGFloat cellHeight = self.bounds.size.height;
        
        CGFloat labelHeight = 28.0;
        CGFloat labelOffSetY = (cellHeight - labelHeight) / 2;
        CGFloat labelOffSetX = 15.0;
        CGFloat labelWidth = cellWidth/2 - labelOffSetX;
        
        // titleLabel
        CGRect titleRect = CGRectMake(labelOffSetX, labelOffSetY, labelWidth, labelHeight);
        _titleLabel = [[UILabel alloc] initWithFrame:titleRect];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        _titleLabel.textColor = kHLCCellTitleColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        switch (style) {
            case HLCLoanOutputTableViewCellStyleLarge: {
                _titleLabel.font = [UIFont systemFontOfSize:kHLCCellTitleFont];
            }
                break;
            case HLCLoanOutputTableViewCellStyleSmall: {
                _titleLabel.font = [UIFont systemFontOfSize:kHLCCellTitleSmallFont];
            }
                break;
        }
        [self.contentView addSubview:_titleLabel];
        
        // detailLabel
        CGRect detailRect = CGRectMake(cellWidth/2, labelOffSetY, labelWidth, labelHeight);
        _detailLabel = [[UILabel alloc] initWithFrame:detailRect];
        _detailLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        _detailLabel.textColor = kHLCCellDetailColor;
        _detailLabel.textAlignment = NSTextAlignmentRight;
        switch (style) {
            case HLCLoanOutputTableViewCellStyleLarge: {
                _detailLabel.font = [UIFont systemFontOfSize:kHLCCellDetailFont];
            }
                break;
            case HLCLoanOutputTableViewCellStyleSmall: {
                _detailLabel.font = [UIFont systemFontOfSize:kHLCCellDetailSmallFont];
            }
                break;
        }
        [self.contentView addSubview:_detailLabel];
    }
    
    return self;
}

#pragma mark - Set Methods
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setDetail:(NSString *)detail {
    self.detailLabel.text = detail;
}

@end
