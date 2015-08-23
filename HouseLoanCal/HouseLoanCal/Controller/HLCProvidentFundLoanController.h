//
//  HLCProvidentFundLoanController.h
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCLoanController.h"

/*
 *  Row of Input Section
 */
enum {
    // 贷款金额
    kHLCProfundInputValue = 0,
    
    // 贷款期限
    kHLCProfundInputPeriod,
    
    // 还款日月
    kHLCProfundInputDate,
    
    // 贷款利率
    kHLCProfundInputRate,
    
    // 还款方式
    kHLCProfundInputType,
    
    // Row 数
    kHLCProfundInputCount,
};


/*
 *  Row of Output Summary Section
 */
enum {
    // 累计支付利息
    kHLCProfundSummaryAccuInterest = 0,
    
    // 累计还款总额
    kHLCProfundSummaryAccuMoney,
    
    // Row 数
    kHLCProfundSummaryCount,
};


@interface HLCProvidentFundLoanController : HLCLoanController

@end
