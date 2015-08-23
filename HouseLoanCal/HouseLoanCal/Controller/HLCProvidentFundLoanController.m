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

@interface HLCProvidentFundLoanController() <HLCLoanInputTableViewCellDelegate>

@property (nonatomic, strong) NSMutableDictionary *inputValuesDict;
@property (nonatomic, strong) NSMutableArray *outputSummary;
@property (nonatomic, strong) NSMutableArray *outputDetail;

@property (nonatomic, assign) BOOL isShowOutput;

@end

@implementation HLCProvidentFundLoanController

- (instancetype)initViewController {
    if (self = [super initViewController]) {
        UIImage *tabImage = [UIImage imageNamed:@"icon_profund_normal"];
        UIImage *tabSelectImage = [UIImage imageNamed:@"icon_profund_height"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"公积金贷款" image:tabImage selectedImage:tabSelectImage];
        
        _isShowOutput = NO;
        _outputSummary = [NSMutableArray array];
        _outputDetail = [NSMutableArray array];
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
    return kHLCLoanSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numOfRows = 0;
    
    switch (section) {
        case kHLCLoanSectionInput: {
            numOfRows = 5;
        }
            break;
        case kHLCLoanSectionOutputSummary: {
            if (self.isShowOutput) {
                numOfRows = 2;
            }
        }
            break;
        case kHLCLoanSectionOutputDetail: {
            if (self.isShowOutput) {
                
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
    
    switch (section) {
        case kHLCLoanSectionInput: {
            switch (row) {
                case kHLCProfundInputValue: {
                    static NSString *cellIdentifier = @"InputValueCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStyleTextField reuseIdentifier:cellIdentifier withTag:1000];
                        [cell setTitle:@"贷款金额"];
                        cell.delegate = self;
                    }
                    return cell;
                }
                    break;
                case kHLCProfundInputPeriod: {
                    static NSString *cellIdentifier = @"InputPeriodCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStyleTextField reuseIdentifier:cellIdentifier withTag:1001];
                        [cell setTitle:@"贷款期限"];
                        cell.delegate = self;
                    }
                    return cell;
                }
                    break;
                case kHLCProfundInputDate: {
                    static NSString *cellIdentifier = @"InputDateCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStyleDatePicker reuseIdentifier:cellIdentifier withTag:1002];
                        [cell setTitle:@"还款年月"];
                        cell.delegate = self;
                    }
                    return cell;
                }
                    break;
                case kHLCProfundInputRate: {
                    static NSString *cellIdentifier = @"InputRateCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStyleTextField reuseIdentifier:cellIdentifier withTag:1003];
                        [cell setTitle:@"贷款利率"];
                        cell.delegate = self;
                    }
                    return cell;
                }
                    break;
                case kHLCProfundInputType: {
                    static NSString *cellIdentifier = @"InputTypeCellIdentifier";
                    HLCLoanInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[HLCLoanInputTableViewCell alloc] initWithHLCStyle:HLCLoanInputTableViewCellStyleSegmentedControl reuseIdentifier:cellIdentifier withTag:1004];
                        [cell setTitle:@"还款方式"];
                        cell.delegate = self;
                    }
                    return cell;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case kHLCLoanSectionOutputSummary: {
            
        }
            break;
        case kHLCLoanSectionOutputDetail: {
            
        }
            break;
        default:
            break;
    }
    
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 16.0;
}

#pragma mark - InputCell Delegate

- (void)resetButtonDidClick:(UIButton *)button {
    
}

- (void)calculateButtonDidClick:(UIButton *)button {
    
}

- (void)inputFieldDidEndEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 1000: {
            self.inputValuesDict[@"value"] = [NSNumber numberWithFloat:[textField.text floatValue]];
        }
            break;
        case 1001: {
            self.inputValuesDict[@"period"] = [NSNumber numberWithInt:[textField.text intValue]];
        }
            break;
        case 1002: {
            self.inputValuesDict[@"date"] = [self convertDateFromString:textField.text];
        }
            break;
        case 1003: {
            self.inputValuesDict[@"rate"] = [NSNumber numberWithFloat:[textField.text floatValue]];
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

@end
