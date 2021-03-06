//
//  HLCBaseTableViewController.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCBaseTableViewController.h"

// Macro
#import "HLCMacros.h"

@implementation HLCBaseTableViewController

- (id)initViewController {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        // 设置下滑时键盘收起
        self.tableView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeInteractive;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView属性
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundView = [[UIView alloc] init];
    self.tableView.backgroundView.backgroundColor = kHLCBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

@end
