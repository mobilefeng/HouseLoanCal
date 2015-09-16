//
//  HLCCommercialLoanController.h
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
    kHLCCommercialInputValue = 0,
    
    // 贷款期限
    kHLCCommercialInputPeriod,
    
    // 还款日期
    kHLCCommercialInputDate,
    
    // 贷款利率
    kHLCCommercialInputRate,
    
    // 贷款利率折扣
    kHLCCommercialInputDiscount,
    
    // 还款方式
    kHLCCommercialInputType,
    
    // Row 数
    kHLCCommercialInputCount,
};

/*
 *  Row of Output Summary Section
 */
enum {
    // 折扣贷款利率
    kHLCCommercialDiscountRate = 0,
    
    // 累计支付利息
    kHLCCommercialSummaryAccuInterest,
    
    // 累计还款总额
    kHLCCommercialSummaryAccuMoney,
    
    // Row 数
    kHLCCommercialSummaryCount,
};

/*
 *  Row of Output Detail Section
 */
enum {
    // 每期相同
    kHLCCommercialDetailEveryMonthEqual = 0,
    
    // 期数
    kHLCCommercialDetailTitle,
    
    //
    kHLCCommercialDetailCount,
};

@interface HLCCommercialLoanController : HLCLoanController

@end
