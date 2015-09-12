//
//  HLCLoanModel.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/8/14.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCLoanModel.h"

#define kHLCTenThousand     (10000.0)

@interface HLCLoanModel()

// 累计支付利息
@property (nonatomic, strong, readwrite) NSNumber *cumulativeInterest;
// 累计还款总额
@property (nonatomic, strong, readwrite) NSNumber *cumulativePrincipalPlusInterest;
// 还款期数
@property (nonatomic, assign, readwrite) NSInteger monthOfLoan;
// 还款月份
@property (nonatomic, strong, readwrite) NSMutableArray *eachMonth;
// 每期本金
@property (nonatomic, strong, readwrite) NSMutableArray *eachPrincipal;
// 每期利息
@property (nonatomic, strong, readwrite) NSMutableArray *eachInterest;
// 每期本息
@property (nonatomic, strong, readwrite) NSMutableArray *eachPrincipalPlusInterest;

@end

@implementation HLCLoanModel

@synthesize cumulativeInterest;

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[HLCLoanModel alloc] init];
    });
    
    return _sharedInstance;
}

- (id)initWithPrincipal:(NSNumber *)pricipal
                 period:(NSInteger)period
                   date:(NSDate *)date
                   rate:(NSNumber *)rate
               withType:(HLCLoanType)type {
    self = [super init];
    
    if (self) {
        _loanPrincipal = pricipal;
        _loanPeriod = period;
        _loanDate = date;
        _loanRate = rate;
        _loanType = type;
        
        self.cumulativeInterest = [[NSNumber alloc] init];
        _cumulativePrincipalPlusInterest = [[NSNumber alloc] init];
        _eachMonth = [[NSMutableArray alloc] init];
        _eachPrincipal = [[NSMutableArray alloc] init];
        _eachInterest = [[NSMutableArray alloc] init];
        _eachPrincipalPlusInterest = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id)init {
    return [self initWithPrincipal:[NSNumber numberWithDouble:0.0] period:0 date:[NSDate date] rate:[NSNumber numberWithDouble:5.0] withType:HLCLoanTypeEqualPrincipal];
}

- (NSNumber *)cumulativeInterest {
    return cumulativeInterest;
}

- (void)setCumulativeInterest:(NSNumber *)newCumulativeInterest {
    cumulativeInterest = newCumulativeInterest;
}


- (void)calculate {
    self.monthOfLoan = self.loanPeriod * 12;
    double monthRate = self.loanRate.doubleValue / (12*100);
    double principalInTenThousand = self.loanPrincipal.doubleValue * kHLCTenThousand;
    
    NSNumber *prinIntePerMonth = [NSNumber alloc];
    NSNumber *interestPerMonth = [NSNumber alloc];
    NSNumber *principalPerMonth = [NSNumber alloc];
    
    for (int i=0; i<self.monthOfLoan; i++) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        [dateComponents setMonth:i];
        NSDate *monthDate = [calendar dateByAddingComponents:dateComponents toDate:self.loanDate options:0];
        [self.eachMonth insertObject:monthDate atIndex:i];
    }
    
    switch (self.loanType) {
        // 等额本息
        case HLCLoanTypeEqualPrincipalPlusInterest: {
            for (int i=0; i<self.monthOfLoan; i++) {
                // 每月本息
                double powVar = pow(1+monthRate, (double)self.monthOfLoan);
                prinIntePerMonth = [NSNumber numberWithDouble:(principalInTenThousand
                                                               * (monthRate * powVar)
                                                               / (powVar-1))];
                [self.eachPrincipalPlusInterest insertObject:prinIntePerMonth atIndex:i];
                
                // 每月利息
                double principalPaid = 0.0;
                for (int j=0; j<i; j++) {
                    NSNumber *principal = self.eachPrincipal[j];
                    principalPaid += principal.doubleValue;
                }
                interestPerMonth = [NSNumber numberWithDouble:(principalInTenThousand - principalPaid) * monthRate];
                [self.eachInterest insertObject:interestPerMonth atIndex:i];
                
                // 每月本金
                principalPerMonth = [NSNumber numberWithDouble:(prinIntePerMonth.doubleValue - interestPerMonth.doubleValue)];
                [self.eachPrincipal insertObject:principalPerMonth atIndex:i];
            }
        }
            break;
        // 等额本金
        case HLCLoanTypeEqualPrincipal: {
            for (int i=0; i<self.monthOfLoan; i++) {
                // 每月本金
                principalPerMonth = [NSNumber numberWithDouble:(principalInTenThousand / self.monthOfLoan)];
                [self.eachPrincipal insertObject:principalPerMonth atIndex:i];
                
                // 每月利息
                double principalPaid = 0.0;
                for (int j=0; j<i; j++) {
                    NSNumber *principal = self.eachPrincipal[j];
                    principalPaid += principal.doubleValue;
                }
                interestPerMonth = [NSNumber numberWithDouble:(principalInTenThousand - principalPaid) * monthRate];
                [self.eachInterest insertObject:interestPerMonth atIndex:i];
                
                // 每月本息
                prinIntePerMonth = [NSNumber numberWithDouble:(principalPerMonth.doubleValue + interestPerMonth.doubleValue)];
                [self.eachPrincipalPlusInterest insertObject:prinIntePerMonth atIndex:i];
            }
        }
            break;
        default:
            break;
    }
    
    // 累计支付利息
    double interestTotal = 0.0;
    for (int i=0; i<self.monthOfLoan; i++) {
        NSNumber *interest = self.eachInterest[i];
        interestTotal += interest.doubleValue;
    }
    self.cumulativeInterest = [NSNumber numberWithDouble:interestTotal];
    
    // 累计支付总额
    self.cumulativePrincipalPlusInterest = [NSNumber numberWithDouble:(principalInTenThousand+self.cumulativeInterest.doubleValue)];
}

@end
