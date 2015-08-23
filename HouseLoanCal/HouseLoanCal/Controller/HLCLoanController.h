//
//  HLCLoanController.h
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCBaseTableViewController.h"

/*
 *  Section
 */
enum {
    // 输入信息
    kHLCLoanSectionInput = 0,
    
    // 输出信息概要
    kHLCLoanSectionOutputSummary,
    
    // 输出信息明细
    kHLCLoanSectionOutputDetail,
    
    // Section 数
    kHLCLoanSectionCount,
};

@interface HLCLoanController : HLCBaseTableViewController

@end
