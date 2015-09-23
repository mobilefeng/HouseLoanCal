//
//  HLCTableViewCell.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/23.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCTableViewCell.h"

//
#import "HLCMacros.h"

@interface HLCTableViewCell () {
    UIView *_topLine;
    UIView *_bottomLine;
}

@end

@implementation HLCTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-0.5)];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-0.5)];
        self.selectedBackgroundView.backgroundColor = kHLCCellSelectedColor;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addBottomSeparatorLineLayer];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _topLine.frame = CGRectMake(0, 0, self.bounds.size.width, 0.5);
    _bottomLine.frame = CGRectMake(0, self.bounds.size.height-0.5, self.bounds.size.width, 0.5);
}

- (void)addTopSeparatorLineLayer {
    [self addTopSeparatorLineLayerWithColor:kHLCCellBottomLineColor];
}

- (void)addTopSeparatorLineLayerWithColor:(UIColor *)aColor {
    if (_topLine == nil) {
        _topLine = [[UIView alloc] initWithFrame:CGRectZero];
        _topLine.backgroundColor = aColor;
        [self.contentView addSubview:_topLine];
    }
}

- (void)addBottomSeparatorLineLayer {
    [self addBottomSeparatorLineLayerWithColor:kHLCCellBottomLineColor];
}

- (void)addBottomSeparatorLineLayerWithColor:(UIColor *)aColor {
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = aColor;
        [self.contentView addSubview:_bottomLine];
    }
}

@end
