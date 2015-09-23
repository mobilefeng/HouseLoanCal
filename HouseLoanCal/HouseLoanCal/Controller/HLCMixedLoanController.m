//
//  HLCMixedLoanController.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCMixedLoanController.h"

// Macro
#import "HLCMacros.h"

// View
#import "HLCLoanInputTableViewCell.h"
#import "HLCLoanOutputTableViewCell.h"

// Model
#import "HLCLoanModel.h"

@interface HLCMixedLoanController() <HLCLoanInputTableViewCellDelegate>

//// 数据模型
//@property (nonatomic, retain) HLCLoanModel *loanModel;
//
//// 公积金贷款金额
//@property (nonatomic, strong) NSNumber *loanProfundValue;
//
//// 公积金贷款利率
//@property (nonatomic, strong) NSNumber *loanProfundRate;
//
//// 商业贷款金额
//@property (nonatomic, strong) NSNumber *loanCommerValue;
//
// 商业贷款利率
@property (nonatomic, strong) NSNumber *loanCommerRate;

// 商业贷款折扣
@property (nonatomic, strong) NSNumber *loanCommerDiscount;
//
//// 商业贷款折扣利率
//@property (nonatomic, strong) NSNumber *loanCommerDiscountRate;

// 公积金贷款数据模型
@property (nonatomic, retain) HLCLoanModel *profundLoanModel;

// 商业贷款数据模型
@property (nonatomic, retain) HLCLoanModel *commerLoanModel;

// 控制是否显示输出结果
@property (nonatomic, assign) BOOL isShowOutput;

@end

@implementation HLCMixedLoanController

- (instancetype)initViewController {
    if (self = [super initViewController]) {
        UIImage *tabImage = [UIImage imageNamed:@"icon_mixed_normal"];
        UIImage *tabSelectImage = [UIImage imageNamed:@"icon_mixed_height"];
        tabSelectImage = [tabSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"组合" image:tabImage selectedImage:tabSelectImage];
        
        // 初始化数据模型
        self.profundLoanModel = [[HLCLoanModel alloc] init];
        self.commerLoanModel = [[HLCLoanModel alloc] init];
        
        // 初始化时不显示输出结果
        self.isShowOutput = NO;
        
        // 初始化贷款期限
        self.profundLoanModel.loanPeriod = [NSNumber numberWithDouble:30];
        self.commerLoanModel.loanPeriod = 
        
        // 初始化公积金贷款利率
        self.profundLoanModel.loanRate = [NSNumber numberWithDouble:3.25];
        
        // 初始化商业贷款利率
        self.loanCommerRate = [NSNumber numberWithDouble:5.15];
        
        // 初始化商业贷款折扣
        self.loanCommerDiscount = [NSNumber numberWithDouble:1.0];
        
        // 初始化商业贷款折扣利率
        self.commerLoanModel.loanRate = [NSNumber numberWithDouble:self.loanCommerRate.doubleValue * self.loanCommerDiscount.doubleValue];
        
        // 初始化还款方式
        self.profundLoanModel.loanType = HLCLoanTypeEqualPrincipalPlusInterest;
        self.commerLoanModel.loanType = HLCLoanTypeEqualPrincipalPlusInterest;
        
        // 初始化还款时间
        self.profundLoanModel.loanDate = [NSDate date];
        self.commerLoanModel.loanDate = [NSDate date];
    }
    return self;
}

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"组合贷款"];
}

#pragma mark - UITableView DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isShowOutput) {
        return kHLCLoanSectionCount;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numOfRows = 0;
    
    switch (section) {
        case kHLCLoanSectionInput: {
            numOfRows = kHLCMixedInputCount + 1;
        }
            break;
        case kHLCLoanSectionOutputSummary: {
            if (self.isShowOutput) {
                numOfRows = kHLCMixedSummaryCount + 1;
            }
        }
            break;
        case kHLCLoanSectionOutputDetail: {
            if (self.isShowOutput) {
                numOfRows = [self.profundLoanModel.eachInterest count] + kHLCMixedDetailCount;
            }
        }
            break;
        default:
            break;
    }
    
    return numOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( (kHLCLoanSectionInput == indexPath.section && kHLCMixedInputCount == indexPath.row) || (kHLCLoanSectionOutputSummary == indexPath.section && kHLCMixedSummaryCount == indexPath.row)) {
        return kHLCHeightForCellSeparator;
    }
    return kHLCHeightForCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    // 金额格式
    NSNumberFormatter *moneyFormatter = [[NSNumberFormatter alloc] init];
    [moneyFormatter setPositiveFormat:@"###,##0.00"];
    
    // 时间格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    
    switch (section) {
            // 输入模块
        case kHLCLoanSectionInput: {
            switch (row) {
                case kHLCMixedInputProfundValue: {
                    static NSString *cellIdentifier = @"InputProfundValueCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStyleTextField reuseIdentifier:cellIdentifier withTag:3000];
                    }
                    [cell setTitle:@"公积金贷款金额(万)"];
                    if (self.profundLoanModel.loanPrincipal == nil) {
                        [cell setTextFieldBlank];
                    }
                    [cell addTopSeparatorLineLayer];
                    cell.delegate = self;
                    return cell;
                }
                    break;
                case kHLCMixedInputCommerValue: {
                    static NSString *cellIdentifier = @"InputCommerValueCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStyleTextField reuseIdentifier:cellIdentifier withTag:3001];
                    }
                    [cell setTitle:@"商业贷款金额(万)"];
                    if (self.commerLoanModel.loanPrincipal == nil) {
                        [cell setTextFieldBlank];
                    }
                    cell.delegate = self;
                    return cell;
                }
                    break;
                case kHLCMixedInputPeriod: {
                    static NSString *cellIdentifier = @"InputPeriodCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStylePickerView reuseIdentifier:cellIdentifier withTag:3002];
                    }
                    [cell setTitle:@"贷款期限(年)"];
                    cell.delegate = self;
                    return cell;
                }
                    break;
                case kHLCMixedInputDate: {
                    static NSString *cellIdentifier = @"InputDateCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStyleDatePicker reuseIdentifier:cellIdentifier withTag:3003];
                    }
                    [cell setTitle:@"还款时间(年月)"];
                    cell.delegate = self;
                    return cell;
                }
                    break;
                case kHLCMixedInputProfundRate: {
                    static NSString *cellIdentifier = @"InputProfundRateCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStyleTextField reuseIdentifier:cellIdentifier withTag:3004];
                    }
                    [cell setTitle:@"公积金贷款利率(%)"];
                    [cell setTextFieldValue:[NSString stringWithFormat:@"%.2f", [self.profundLoanModel.loanRate doubleValue]]];
                    cell.delegate = self;
                    return cell;
                }
                    break;
                case kHLCMixedInputCommerRate: {
                    static NSString *cellIdentifier = @"InputCommerRateCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStyleTextField reuseIdentifier:cellIdentifier withTag:3005];
                    }
                    [cell setTitle:@"商业贷款利率(%)"];
                    [cell setTextFieldValue:[NSString stringWithFormat:@"%.2f", [self.loanCommerRate doubleValue]]];
                    cell.delegate = self;
                    return cell;
                }
                    break;
                case kHLCMixedInputCommerDiscount: {
                    static NSString *cellIdentifier = @"InputCommerDiscountCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStyleTextField reuseIdentifier:cellIdentifier withTag:3006];
                    }
                    [cell setTitle:@"商业贷款折扣(倍)"];
                    [cell setTextFieldValue:[NSString stringWithFormat:@"%.2f", [self.loanCommerDiscount doubleValue]]];
                    cell.delegate = self;
                    return cell;
                }
                    break;
                case kHLCMixedInputType: {
                    static NSString *cellIdentifier = @"InputTypeCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStyleSegmentedControl reuseIdentifier:cellIdentifier withTag:3007];
                    }
                    [cell setTitle:@"还款方式"];
                    cell.delegate = self;
                    return cell;
                }
                    break;
                case kHLCMixedInputCount: {
                    static NSString *cellIdentifier = @"InputSeparatorCellIdentifier";
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] init];
                    }
                    cell.backgroundColor = kHLCBackgroundColor;
                    return cell;
                }
                    break;
                default:
                    break;
            }
        }
            break;
            // 输出结果概览
        case kHLCLoanSectionOutputSummary: {
            if (self.isShowOutput) {
                switch (row) {
                    case kHLCMixedSummaryAccuInterest: {
                        static NSString *cellIdentifier = @"OutputAccuInterestCellIdentifier";
                        HLCLoanOutputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                        if (!cell) {
                            cell = [[HLCLoanOutputTableViewCell alloc] initWithHLCStyle:HLCLoanOutputTableViewCellStyleLarge reuseIdentifier:cellIdentifier];
                        }
                        [cell setTitle:@"累计支付利息(元)"];
                        [cell setDetail:[moneyFormatter stringFromNumber:
                                         [NSNumber numberWithDouble:(self.profundLoanModel.cumulativeInterest.doubleValue + self.commerLoanModel.cumulativeInterest.doubleValue)]]];
                        [cell addTopSeparatorLineLayer];
                        return cell;
                    }
                        break;
                    case kHLCMixedSummaryAccuMoney: {
                        static NSString *cellIdentifier = @"OutputAccuMoneyCellIdentifier";
                        HLCLoanOutputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                        if (!cell) {
                            cell = [[HLCLoanOutputTableViewCell alloc] initWithHLCStyle:HLCLoanOutputTableViewCellStyleLarge reuseIdentifier:cellIdentifier];
                        }
                        [cell setTitle:@"累计还款总额(元)"];
                        [cell setDetail:[moneyFormatter stringFromNumber:
                                         [NSNumber numberWithDouble:(self.profundLoanModel.cumulativePrincipalPlusInterest.doubleValue + self.commerLoanModel.cumulativePrincipalPlusInterest.doubleValue)]]];
                        return cell;
                    }
                        break;
                    case kHLCMixedSummaryCount: {
                        static NSString *cellIdentifier = @"InputSeparatorCellIdentifier";
                        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                        if (!cell) {
                            cell = [[UITableViewCell alloc] init];
                        }
                        cell.backgroundColor = kHLCBackgroundColor;
                        return cell;
                    }
                        break;
                    default:
                        break;
                }
            }
        }
            break;
            // 输出结果详细
        case kHLCLoanSectionOutputDetail: {
            if (self.isShowOutput) {
                if (kHLCMixedDetailEveryMonthEqual == row) {
                    static NSString *cellIdentifier = @"OutputEveryMonthEqualCellIdentifier";
                    HLCLoanOutputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanOutputTableViewCell alloc] initWithHLCStyle:HLCLoanOutputTableViewCellStyleLarge reuseIdentifier:cellIdentifier];
                    }
                    switch (self.profundLoanModel.loanType) {
                        case HLCLoanTypeEqualPrincipalPlusInterest: {
                            [cell setTitle:@"每期还款(元)"];
                        }
                            break;
                        case HLCLoanTypeEqualPrincipal: {
                            [cell setTitle:@"每期本金(元)"];
                        }
                            break;
                        default:
                            break;
                    }
                    [cell setDetail:[moneyFormatter stringFromNumber:
                                     [NSNumber numberWithDouble:(self.profundLoanModel.eachEqual.doubleValue + self.commerLoanModel.eachEqual.doubleValue)]]];
                    [cell addTopSeparatorLineLayer];
                    return cell;
                } else if (kHLCMixedDetailTitle == row) {
                    static NSString *cellIdentifier = @"OutputDetailTitleCellIdentifier";
                    HLCLoanOutputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanOutputTableViewCell alloc] initWithHLCStyle:HLCLoanOutputTableViewCellStyleLarge reuseIdentifier:cellIdentifier];
                    }
                    [cell setTitle:@"期数"];
                    switch (self.profundLoanModel.loanType) {
                        case HLCLoanTypeEqualPrincipalPlusInterest: {
                            [cell setDetail:@"本金/利息(元)"];
                        }
                            break;
                        case HLCLoanTypeEqualPrincipal: {
                            [cell setDetail:@"还款/利息(元)"];
                        }
                            break;
                        default:
                            break;
                    }
                    return cell;
                } else {
                    static NSString *cellIdentifier = @"OutputDetailCellIdentifier";
                    HLCLoanOutputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanOutputTableViewCell alloc] initWithHLCStyle:HLCLoanOutputTableViewCellStyleSmall reuseIdentifier:cellIdentifier];
                    }
                    [cell setTitle:[NSString stringWithFormat:@"第%ld期[%@]", row-1, [dateFormatter stringFromDate:self.profundLoanModel.eachMonth[row-2]]]];
                    NSNumber *profundEveryMonth = self.profundLoanModel.eachDiff[row-2];
                    NSNumber *commerEveryMonth = self.commerLoanModel.eachDiff[row-2];
                    NSString *everyMonthDiffString = [moneyFormatter stringFromNumber:
                                                      [NSNumber numberWithDouble:(profundEveryMonth.doubleValue + commerEveryMonth.doubleValue)]];
                    NSNumber *profundEveryMonthInterest = self.profundLoanModel.eachInterest[row-2];
                    NSNumber *commerEveryMonthInterest = self.commerLoanModel.eachInterest[row-2];
                    NSString *everyMonthInterestString = [moneyFormatter stringFromNumber:
                                                          [NSNumber numberWithDouble:(profundEveryMonthInterest.doubleValue + commerEveryMonthInterest.doubleValue)]];
                    [cell setDetail:[NSString stringWithFormat:@"%@/%@", everyMonthDiffString, everyMonthInterestString]];
                    return cell;
                }
            }
        }
            break;
        default:
            break;
    }
    
    return [[UITableViewCell alloc] init];
}

#pragma mark - InputCell Delegate

// 重置按钮被点击后的操作
- (void)resetButtonDidClick:(UIButton *)button {
    [self resetAndReloadData];
}

// 计算按钮被点击后的操作
- (void)calculateButtonDidClick:(UIButton *)button {
    [self calculateAndReloadData];
}

// 获取 textField 输入值
- (void)inputFieldDidEndEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 3000: {
            self.profundLoanModel.loanPrincipal = [NSNumber numberWithDouble:[textField.text doubleValue]];
        }
            break;
        case 3001: {
            self.commerLoanModel.loanPrincipal = [NSNumber numberWithDouble:[textField.text doubleValue]];
        }
            break;
        case 3002: {
            self.profundLoanModel.loanPeriod = [NSNumber numberWithDouble:[textField.text doubleValue]];
            self.commerLoanModel.loanPeriod = [NSNumber numberWithDouble:[textField.text doubleValue]];
        }
            break;
        case 3003: {
            self.profundLoanModel.loanDate = [self convertDateFromString:textField.text];
            self.commerLoanModel.loanDate = [self convertDateFromString:textField.text];
        }
            break;
        case 3004: {
            self.profundLoanModel.loanRate = [NSNumber numberWithDouble:[textField.text doubleValue]];
        }
            break;
        case 3005: {
            self.loanCommerRate = [NSNumber numberWithDouble:[textField.text doubleValue]];
            self.commerLoanModel.loanRate = [NSNumber numberWithDouble:([self.loanCommerRate doubleValue]*[self.loanCommerDiscount doubleValue])];
        }
            break;
        case 3006: {
            self.loanCommerDiscount = [NSNumber numberWithDouble:[textField.text doubleValue]];
            self.commerLoanModel.loanRate = [NSNumber numberWithDouble:([self.loanCommerRate doubleValue]*[self.loanCommerDiscount doubleValue])];
        }
            break;
        
        default:
            break;
    }
}

// 获取 segmentedControl 的值
- (void)segmentedControlDidChange:(UISegmentedControl *)segmentedControl {
    NSInteger index = segmentedControl.selectedSegmentIndex;
    
    switch (index) {
        case 0: {
            self.profundLoanModel.loanType = HLCLoanTypeEqualPrincipalPlusInterest;
            self.commerLoanModel.loanType = HLCLoanTypeEqualPrincipalPlusInterest;
        }
            break;
        case 1: {
            self.profundLoanModel.loanType = HLCLoanTypeEqualPrincipal;
            self.commerLoanModel.loanType = HLCLoanTypeEqualPrincipal;
        }
        default:
            break;
    }
    if (self.profundLoanModel.isInputValid && self.commerLoanModel.isInputValid && self.isShowOutput) {
        [self calculateAndReloadData];
    }
}

#pragma mark - Action

- (void)resetAndReloadData {
    self.isShowOutput = NO;
    self.profundLoanModel.loanPrincipal = nil;
    self.profundLoanModel.loanPeriod = [NSNumber numberWithDouble:30.0];
    self.commerLoanModel.loanPrincipal = nil;
    self.commerLoanModel.loanPeriod = [NSNumber numberWithDouble:30.0];
    
    [self.tableView reloadData];
}

- (void)calculateAndReloadData {
    if (self.profundLoanModel.isInputValid && self.commerLoanModel.isInputValid) {
        [self.profundLoanModel calculate];
        [self.commerLoanModel calculate];
        self.isShowOutput = YES;
        [self.tableView reloadData];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"亲还有部分信息未填噢～"
                                                       delegate:self
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil];
        [alert show];
        self.isShowOutput = NO;
        [self.tableView reloadData];
    }
}

#pragma mark - Method

- (NSDate *)convertDateFromString:(NSString *)string {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}

@end
