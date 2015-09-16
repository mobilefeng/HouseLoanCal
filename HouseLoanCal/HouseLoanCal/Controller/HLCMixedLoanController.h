//
//  HLCMixedLoanController.h
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCLoanController.h"

@interface HLCMixedLoanController : HLCLoanController

/*
 *  Row of Input Section
 */
enum {
    // 公积金贷款金额
    kHLCMixedInputProfundValue = 0,
    
    // 公积金贷款利率
    kHLCMixedInputProfundRate,
    
    // 商业贷款金额
    kHLCMixedInputCommerValue,
    
    // 商业贷款利率
    kHLCMixedInputCommerRate,
    
    // 商业贷款利率折扣
    kHLCMixedInputCommerDiscount,
    
    // 贷款期限
    kHLCMixedInputPeriod,
    
    // 还款日期
    kHLCMixedInputDate,
    
    // 还款方式
    kHLCMixedInputType,
    
    // Row 数
    kHLCMixedInputCount,
};

/*
 *  Row of Output Summary Section
 */
enum {
    // 商业贷款折扣利率
    kHLCMixedEquivalentRate = 0,
    
    // 累计支付利息
    kHLCMixedSummaryAccuInterest,
    
    // 累计还款总额
    kHLCMixedSummaryAccuMoney,
    
    // Row 数
    kHLCMixedSummaryCount,
};

/*
 *  Row of Output Detail Section
 */
enum {
    // 每期相同
    kHLCMixedDetailEveryMonthEqual = 0,
    
    // 期数
    kHLCMixedDetailTitle,
    
    //
    kHLCMixedDetailCount,
};

@end
