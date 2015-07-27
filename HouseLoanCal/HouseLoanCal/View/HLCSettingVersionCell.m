//
//  HLCSettingVersionCell.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/23.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCSettingVersionCell.h"

//
#import "HLCMacros.h"

@interface HLCSettingVersionCell () {
    UILabel *_titleLabel;
    UILabel *_versionLabel;
}

@end

@implementation HLCSettingVersionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        CGFloat labelOffsetX = 10.0;
        CGFloat labelWidth = 100.0;
        CGFloat labelHeight = 20.0;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelOffsetX, (self.bounds.size.height-labelHeight)*0.5, labelWidth, labelHeight)];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        _titleLabel.textColor = kHLCCellTitleColor;
        _titleLabel.font = [UIFont systemFontOfSize:kHLCCellTitleFont];
        [self.contentView addSubview:_titleLabel];
        
        _versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-labelOffsetX-labelWidth, (self.bounds.size.height-labelHeight)*0.5, labelWidth, labelHeight)];
        _versionLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        _versionLabel.textColor = kHLCCellDetailColor;
        _versionLabel.font = [UIFont systemFontOfSize:kHLCCellDetailFont];
        _versionLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_versionLabel];
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

- (void)setVersion:(NSString *)version {
    _versionLabel.text = version;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

@end
