//
//  HLCProvidentFundLoanController.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCProvidentFundLoanController.h"

//
#import "HLCMacros.h"

@implementation HLCProvidentFundLoanController

- (instancetype)initViewController {
    if (self = [super initViewController]) {
        UIImage *tabImage = [UIImage imageNamed:@"icon_profund_normal"];
        UIImage *tabSelectImage = [UIImage imageNamed:@"icon_profund_height"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"公积金贷款" image:tabImage selectedImage:tabSelectImage];
    }
    return self;
}

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"公积金贷款"];
}

#pragma mark - DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return kHLCLoanSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numOfRows = 0;
    
    switch (section) {
        case kHLCLoanSectionInput: {
            numOfRows = 5;
        }
            break;
        case kHLCLoanSectionOutputSummary: {
            
        }
            break;
        case kHLCLoanSectionOutputDetail: {
            
        }
            break;
        default:
            break;
    }
    
    return numOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kHLCHeightForCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 16;
}

@end
