//
//  HLCSettingScoreCell.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/27.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCSettingScoreCell.h"

//
#import "HLCMacros.h"

@interface HLCSettingScoreCell () {
    UILabel *_titleLabel;
}

@end

@implementation HLCSettingScoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        CGFloat labelOffsetX = 10.0;
        CGFloat labelWidth = 100.0;
        CGFloat labelHeight = 20.0;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelOffsetX, (self.bounds.size.height-labelHeight)*0.5, labelWidth, labelHeight)];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        _titleLabel.textColor = kHLCCellTitleColor;
        _titleLabel.font = [UIFont systemFontOfSize:kHLCCellTitleFont];
        [self.contentView addSubview:_titleLabel];
        
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

@end
