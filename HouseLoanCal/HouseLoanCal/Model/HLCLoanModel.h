//
//  HLCLoanModel.h
//  HouseLoanCal
//
//  Created by 徐杨 on 15/8/14.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *  还款方式
 */
typedef NS_ENUM(NSInteger, HLCLoanType) {
    // 等额本息
    HLCLoanTypeEqualPrincipalPlusInterest = 1,
    // 等额本金
    HLCLoanTypeEqualPrincipal,
};

@interface HLCLoanModel : NSObject

//+ (instancetype)sharedInstance;

- (id)initWithPrincipal:(NSNumber *)pricipal
                 period:(NSInteger)period
                   date:(NSDate *)date
                   rate:(NSNumber *)rate
               withType:(HLCLoanType)type;

- (id)init;

- (BOOL)isInputValid;

- (void)calculate;

/*
 *  输入参数
 */
// 贷款金额
@property (nonatomic, strong) NSNumber *loanPrincipal;
// 贷款期限
@property (nonatomic, assign) NSInteger loanPeriod;
// 贷款日期
@property (nonatomic, strong) NSDate *loanDate;
// 贷款利率
@property (nonatomic, strong) NSNumber *loanRate;
// 还款方式
@property (nonatomic, assign) HLCLoanType loanType;

/*
 *  输出参数
 */
// 累计支付利息
@property (nonatomic, strong, readonly) NSNumber *cumulativeInterest;
// 累计还款总额
@property (nonatomic, strong, readonly) NSNumber *cumulativePrincipalPlusInterest;
// 还款期数
@property (nonatomic, assign, readonly) NSInteger monthOfLoan;
// 还款月份
@property (nonatomic, strong, readonly) NSMutableArray *eachMonth;
// 每期本金
@property (nonatomic, strong, readonly) NSMutableArray *eachPrincipal;
// 每期利息
@property (nonatomic, strong, readonly) NSMutableArray *eachInterest;
// 每期本息
@property (nonatomic, strong, readonly) NSMutableArray *eachPrincipalPlusInterest;
// 每期相同
@property (nonatomic, strong, readonly) NSNumber *eachEqual;
// 每期不同
@property (nonatomic, strong, readonly) NSMutableArray *eachDiff;


@end
