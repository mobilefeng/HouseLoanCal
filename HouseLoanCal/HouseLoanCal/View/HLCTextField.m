//
//  HLCTextField.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/8/10.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCTextField.h"

@implementation HLCTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, self.bounds.size.height)];
        leftView.backgroundColor = [UIColor clearColor];
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

@end
