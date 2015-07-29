//
//  HLCBaseTableViewController.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCBaseTableViewController.h"

//
#import "HLCMacros.h"

@implementation HLCBaseTableViewController

- (id)initViewController {
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundView = [[UIView alloc] init];
//    self.tableView.backgroundView.backgroundColor = kHLCBackgroundColor;
    self.tableView.backgroundView.backgroundColor = [UIColor redColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

@end
