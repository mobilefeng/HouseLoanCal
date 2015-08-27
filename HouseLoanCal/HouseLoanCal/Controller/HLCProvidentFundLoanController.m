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

#import "HLCLoanInputTableViewCell.h"
#import "HLCLoanOutputTableViewCell.h"
#import "HLCLoanModel.h"

@interface HLCProvidentFundLoanController() <HLCLoanInputTableViewCellDelegate>

// 输入参数
@property (nonatomic, strong) NSNumber *loanPrincipal;
@property (nonatomic, assign) NSInteger loanPeriod;
@property (nonatomic, strong) NSDate *loanDate;
@property (nonatomic, strong) NSNumber *loanRate;
@property (nonatomic, assign) HLCLoanType loanType;

// 输出结果
@property (nonatomic, strong) NSNumber *cumulativeInterest;
@property (nonatomic, strong) NSNumber *cumulativePrincipalPlusInterest;
@property (nonatomic, strong) NSMutableArray *everyMonth;
@property (nonatomic, strong) NSNumber *everyMonthEqual;
@property (nonatomic, strong) NSMutableArray *everyMonthDiff;
@property (nonatomic, strong) NSMutableArray *everyMonthInterest;

//
@property (nonatomic, assign) BOOL isShowOutput;

@end

@implementation HLCProvidentFundLoanController

- (instancetype)initViewController {
    if (self = [super initViewController]) {
        UIImage *tabImage = [UIImage imageNamed:@"icon_profund_normal"];
        UIImage *tabSelectImage = [UIImage imageNamed:@"icon_profund_height"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"公积金贷款" image:tabImage selectedImage:tabSelectImage];
        
        // 初始化时不显示输出结果Section
        self.isShowOutput = NO;
        
        // 初始化贷款利率
        self.loanRate = [NSNumber numberWithDouble:5.0];
        
        // 初始化还款方式
        self.loanType = HLCLoanTypeEqualPrincipalPlusInterest;
        
        // 初始化还款时间
        self.loanDate = [NSDate date];
    }
    return self;
}

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"公积金贷款"];
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
            numOfRows = kHLCProfundInputCount;
        }
            break;
        case kHLCLoanSectionOutputSummary: {
            if (self.isShowOutput) {
                numOfRows = kHLCProfundSummaryCount;
            }
        }
            break;
        case kHLCLoanSectionOutputDetail: {
            if (self.isShowOutput) {
                numOfRows = [self.everyMonthInterest count] + kHLCProfundDetailCount;
            }
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
                case kHLCProfundInputValue: {
                    static NSString *cellIdentifier = @"InputValueCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStyleTextField reuseIdentifier:cellIdentifier withTag:1000];
                    }
                    [cell setTitle:@"贷款金额(万)"];
                    cell.delegate = self;
                    return cell;
                }
                    break;
                case kHLCProfundInputPeriod: {
                    static NSString *cellIdentifier = @"InputPeriodCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStyleTextField reuseIdentifier:cellIdentifier withTag:1001];
                    }
                    [cell setTitle:@"贷款期限(年)"];
                    cell.delegate = self;
                    return cell;
                }
                    break;
                case kHLCProfundInputDate: {
                    static NSString *cellIdentifier = @"InputDateCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStyleDatePicker reuseIdentifier:cellIdentifier withTag:1002];
                    }
                    [cell setTitle:@"还款时间(年月)"];
                    cell.delegate = self;
                    return cell;
                }
                    break;
                case kHLCProfundInputRate: {
                    static NSString *cellIdentifier = @"InputRateCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStyleTextField reuseIdentifier:cellIdentifier withTag:1003];
                    }
                    [cell setTitle:@"贷款利率(％)"];
                    [cell setTextFieldValue:[NSString stringWithFormat:@"%.3f", [self.loanRate doubleValue]]];
                    cell.delegate = self;
                    return cell;
                }
                    break;
                case kHLCProfundInputType: {
                    static NSString *cellIdentifier = @"InputTypeCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStyleSegmentedControl reuseIdentifier:cellIdentifier withTag:1004];
                    }
                    [cell setTitle:@"还款方式"];
                    cell.delegate = self;
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
                    case kHLCProfundSummaryAccuInterest: {
                        static NSString *cellIdentifier = @"OutputAccuInterestCellIdentifier";
                        HLCLoanOutputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                        if (!cell) {
                            cell = [[HLCLoanOutputTableViewCell alloc] initWithHLCStyle:HLCLoanOutputTableViewCellStyleLarge reuseIdentifier:cellIdentifier];
                        }
                        [cell setTitle:@"累计支付利息(元)"];
                        [cell setDetail:[moneyFormatter stringFromNumber:self.cumulativeInterest]];
                        return cell;
                    }
                        break;
                    case kHLCProfundSummaryAccuMoney: {
                        static NSString *cellIdentifier = @"OutputAccuMoneyCellIdentifier";
                        HLCLoanOutputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                        if (!cell) {
                            cell = [[HLCLoanOutputTableViewCell alloc] initWithHLCStyle:HLCLoanOutputTableViewCellStyleLarge reuseIdentifier:cellIdentifier];
                        }
                        [cell setTitle:@"累计还款总额(元)"];
                        [cell setDetail:[moneyFormatter stringFromNumber:self.cumulativePrincipalPlusInterest]];
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
                if (kHLCProfundDetailEveryMonthEqual == row) {
                    static NSString *cellIdentifier = @"OutputEveryMonthEqualCellIdentifier";
                    HLCLoanOutputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanOutputTableViewCell alloc] initWithHLCStyle:HLCLoanOutputTableViewCellStyleLarge reuseIdentifier:cellIdentifier];
                    }
                    switch (self.loanType) {
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
                    [cell setDetail:[moneyFormatter stringFromNumber:self.everyMonthEqual]];
                    return cell;
                } else if (kHLCProfundDetailTitle == row) {
                    static NSString *cellIdentifier = @"OutputDetailTitleCellIdentifier";
                    HLCLoanOutputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanOutputTableViewCell alloc] initWithHLCStyle:HLCLoanOutputTableViewCellStyleLarge reuseIdentifier:cellIdentifier];
                    }
                    [cell setTitle:@"期数"];
                    switch (self.loanType) {
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
                    [cell setTitle:[NSString stringWithFormat:@"第%ld期[%@]", row-1, [dateFormatter stringFromDate:self.everyMonth[row-2]]]];
                    NSString *everyMonthDiffString = [moneyFormatter stringFromNumber:self.everyMonthDiff[row-2]];
                    NSString *evertMonthInterestString = [moneyFormatter stringFromNumber:self.everyMonthInterest[row-2]];
                    [cell setDetail:[NSString stringWithFormat:@"%@/%@", everyMonthDiffString, evertMonthInterestString]];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kHLCHeightForCellHeader;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, kHLCHeightForCellHeader)];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, kHLCHeightForCellHeader-0.5, self.tableView.frame.size.width, 0.5)];
    bottomLine.backgroundColor = kHLCCellBottomLineColor;
    [headerView addSubview:bottomLine];
    
    return headerView;
}

#pragma mark - InputCell Delegate

- (void)resetButtonDidClick:(UIButton *)button {
    
}

- (void)calculateButtonDidClick:(UIButton *)button {
    [self calculateAndShowResult];
}

- (void)calculateAndShowResult {
    if (self.loanPrincipal && self.loanPeriod && self.loanDate && self.loanRate.doubleValue!=0.0 && self.loanType) {
        HLCLoanModel *loanModel = [[HLCLoanModel alloc] initWithPrincipal:self.loanPrincipal
                                                                   period:self.loanPeriod
                                                                     date:self.loanDate
                                                                     rate:self.loanRate
                                                                 withType:self.loanType];
        [loanModel calculate];
        
        switch (self.loanType) {
            case HLCLoanTypeEqualPrincipalPlusInterest: {
                self.everyMonthEqual = loanModel.eachPrincipalPlusInterest[0];
                self.everyMonthDiff = loanModel.eachPrincipal;
            }
                break;
            case HLCLoanTypeEqualPrincipal: {
                self.everyMonthEqual = loanModel.eachPrincipal[0];
                self.everyMonthDiff = loanModel.eachPrincipalPlusInterest;
            }
                break;
            default:
                break;
        }
        
        self.everyMonth = loanModel.eachMonth;
        self.everyMonthInterest = loanModel.eachInterest;
        self.cumulativeInterest = loanModel.cumulativeInterest;
        self.cumulativePrincipalPlusInterest = loanModel.cumulativePrincipalPlusInterest;
        
        self.isShowOutput = YES;
        [self.tableView reloadData];
    } else {
        self.isShowOutput = NO;
        [self.tableView reloadData];
    }
}

- (void)inputFieldDidEndEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 1000: {
            self.loanPrincipal = [NSNumber numberWithFloat:[textField.text floatValue]];
        }
            break;
        case 1001: {
            self.loanPeriod = [textField.text intValue];
        }
            break;
        case 1002: {
            self.loanDate = [self convertDateFromString:textField.text];
        }
            break;
        case 1003: {
            self.loanRate = [NSNumber numberWithFloat:[textField.text floatValue]];
        }
            break;
        default:
            break;
    }
}

- (NSDate *)convertDateFromString:(NSString *)string {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}

- (void)segmentedControlDidChange:(UISegmentedControl *)segmentedControl {
    NSInteger index = segmentedControl.selectedSegmentIndex;
    
    switch (index) {
        case 0: {
            self.loanType = HLCLoanTypeEqualPrincipalPlusInterest;
        }
            break;
        case 1: {
            self.loanType = HLCLoanTypeEqualPrincipal;
        }
        default:
            break;
    }
    [self calculateAndShowResult];
}

@end
