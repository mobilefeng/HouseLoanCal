//
//  HLCProvidentFundLoanController.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCProvidentFundLoanController.h"

// Macro
#import "HLCMacros.h"

// View
#import "HLCLoanInputTableViewCell.h"
#import "HLCLoanOutputTableViewCell.h"

// Model
#import "HLCLoanModel.h"


@interface HLCProvidentFundLoanController() <HLCLoanInputTableViewCellDelegate>

// 数据模型
@property (nonatomic, retain) HLCLoanModel *loanModel;

// 控制是否显示输出结果
@property (nonatomic, assign) BOOL isShowOutput;

@end


@implementation HLCProvidentFundLoanController

#pragma mark - Init

- (instancetype)initViewController {
    if (self = [super initViewController]) {
        UIImage *tabImage = [UIImage imageNamed:@"icon_profund_normal"];
        UIImage *tabSelectImage = [UIImage imageNamed:@"icon_profund_height"];
        tabSelectImage = [tabSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"公积金" image:tabImage selectedImage:tabSelectImage];
        
        // 初始化数据模型
        self.loanModel = [[HLCLoanModel alloc] init];
        
        // 初始化时不显示输出结果
        self.isShowOutput = NO;
        
        // 初始化贷款期限
        self.loanModel.loanPeriod = [NSNumber numberWithDouble:30];
        
        // 初始化贷款利率
        self.loanModel.loanRate = [NSNumber numberWithDouble:3.25];
        
        // 初始化还款方式
        self.loanModel.loanType = HLCLoanTypeEqualPrincipalPlusInterest;
        
        // 初始化还款时间
        self.loanModel.loanDate = [NSDate date];
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
            numOfRows = kHLCProfundInputCount + 1;
        }
            break;
        case kHLCLoanSectionOutputSummary: {
            if (self.isShowOutput) {
                numOfRows = kHLCProfundSummaryCount + 1;
            }
        }
            break;
        case kHLCLoanSectionOutputDetail: {
            if (self.isShowOutput) {
                numOfRows = [self.loanModel.eachInterest count] + kHLCProfundDetailCount;
            }
        }
            break;
        default:
            break;
    }
    
    return numOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( (kHLCLoanSectionInput == indexPath.section && kHLCProfundInputCount == indexPath.row) || (kHLCLoanSectionOutputSummary == indexPath.section && kHLCProfundSummaryCount == indexPath.row)) {
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
                case kHLCProfundInputValue: {
                    static NSString *cellIdentifier = @"InputValueCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStyleTextField reuseIdentifier:cellIdentifier withTag:1000];
                    }
                    [cell setTitle:@"贷款金额(万)"];
                    if (self.loanModel.loanPrincipal == nil) {
                        [cell setTextFieldBlank];
                    }
                    [cell addTopSeparatorLineLayer];
                    cell.delegate = self;
                    return cell;
                }
                    break;
                case kHLCProfundInputPeriod: {
                    static NSString *cellIdentifier = @"InputPeriodCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStylePickerView reuseIdentifier:cellIdentifier withTag:1001];
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
                    [cell setTextFieldValue:[NSString stringWithFormat:@"%.2f", [self.loanModel.loanRate doubleValue]]];
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
                case kHLCProfundInputCount: {
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
                    case kHLCProfundSummaryAccuInterest: {
                        static NSString *cellIdentifier = @"OutputAccuInterestCellIdentifier";
                        HLCLoanOutputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                        if (!cell) {
                            cell = [[HLCLoanOutputTableViewCell alloc] initWithHLCStyle:HLCLoanOutputTableViewCellStyleLarge reuseIdentifier:cellIdentifier];
                        }
                        [cell setTitle:@"累计支付利息(元)"];
                        [cell setDetail:[moneyFormatter stringFromNumber:self.loanModel.cumulativeInterest]];
                        [cell addTopSeparatorLineLayer];
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
                        [cell setDetail:[moneyFormatter stringFromNumber:self.loanModel.cumulativePrincipalPlusInterest]];
                        return cell;
                    }
                        break;
                    case kHLCProfundSummaryCount: {
                        static NSString *cellIdentifier = @"OutputSummarySeparatorCellIdentifier";
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
                if (kHLCProfundDetailEveryMonthEqual == row) {
                    static NSString *cellIdentifier = @"OutputEveryMonthEqualCellIdentifier";
                    HLCLoanOutputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanOutputTableViewCell alloc] initWithHLCStyle:HLCLoanOutputTableViewCellStyleLarge reuseIdentifier:cellIdentifier];
                    }
                    switch (self.loanModel.loanType) {
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
                    [cell setDetail:[moneyFormatter stringFromNumber:self.loanModel.eachEqual]];
                    [cell addTopSeparatorLineLayer];
                    return cell;
                } else if (kHLCProfundDetailTitle == row) {
                    static NSString *cellIdentifier = @"OutputDetailTitleCellIdentifier";
                    HLCLoanOutputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanOutputTableViewCell alloc] initWithHLCStyle:HLCLoanOutputTableViewCellStyleLarge reuseIdentifier:cellIdentifier];
                    }
                    [cell setTitle:@"期数"];
                    switch (self.loanModel.loanType) {
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
                    [cell setTitle:[NSString stringWithFormat:@"第%ld期[%@]", row-1, [dateFormatter stringFromDate:self.loanModel.eachMonth[row-2]]]];
                    NSString *everyMonthDiffString = [moneyFormatter stringFromNumber:self.loanModel.eachDiff[row-2]];
                    NSString *everyMonthInterestString = [moneyFormatter stringFromNumber:self.loanModel.eachInterest[row-2]];
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
        case 1000: {
            self.loanModel.loanPrincipal = [NSNumber numberWithDouble:[textField.text doubleValue]];
        }
            break;
        case 1001: {
            self.loanModel.loanPeriod = [NSNumber numberWithDouble:[textField.text doubleValue]];
        }
            break;
        case 1002: {
            self.loanModel.loanDate = [self convertDateFromString:textField.text];
        }
            break;
        case 1003: {
            self.loanModel.loanRate = [NSNumber numberWithDouble:[textField.text doubleValue]];
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
            self.loanModel.loanType = HLCLoanTypeEqualPrincipalPlusInterest;
        }
            break;
        case 1: {
            self.loanModel.loanType = HLCLoanTypeEqualPrincipal;
        }
        default:
            break;
    }
    if (self.loanModel.isInputValid && self.isShowOutput) {
        [self calculateAndReloadData];
    }
}

#pragma mark - Action

- (void)resetAndReloadData {
    self.isShowOutput = NO;
    self.loanModel.loanPrincipal = nil;
    self.loanModel.loanPeriod = [NSNumber numberWithDouble:30.0];
    
    [self.tableView reloadData];
}

- (void)calculateAndReloadData {
    if (self.loanModel.isInputValid) {
        [self.loanModel calculate];
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
