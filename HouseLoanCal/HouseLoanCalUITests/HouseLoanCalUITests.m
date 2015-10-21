//
//  HouseLoanCalUITests.m
//  HouseLoanCalUITests
//
//  Created by 徐杨 on 15/10/8.
//  Copyright © 2015年 xuyang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface HouseLoanCalUITests : XCTestCase <UIPickerViewAccessibilityDelegate>

@property (nonatomic, strong) XCUIApplication *app;
@property (nonatomic, strong) XCUIElementQuery *tablesQuery;

@end

@implementation HouseLoanCalUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    
    self.continueAfterFailure = NO;
    
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    
    self.app = [[XCUIApplication alloc] init];
    [self.app launch];
    self.tablesQuery = self.app.tables;
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test1_ProfundLoanPage {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    
#pragma mark - Modify Input
    
    // 贷款金额
    XCUIElementQuery *inputValueCell = [self.tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"贷款金额(万)"];
    XCUIElement *valueTextField = [inputValueCell childrenMatchingType:XCUIElementTypeTextField].element;
    [valueTextField tap];
    [valueTextField typeText:@"100"];
    
    // 贷款期限
    XCUIElementQuery *inputPeriodCell = [self.tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"贷款期限(年)"];
    XCUIElement *periodTextField = [inputPeriodCell childrenMatchingType:XCUIElementTypeTextField].element;
    [periodTextField tap];
    [self.app.pickerWheels.element adjustToPickerWheelValue:@"1年（12期）"];
    
    // 贷款利率
    XCUIElementQuery *inputRateCell = [self.tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"贷款利率(％)"];
    XCUIElement *rateTextField = [inputRateCell childrenMatchingType:XCUIElementTypeTextField].element;
    [rateTextField tap];
    XCUIElement *deleteKey = self.app.keys[@"Delete"];
    for (int index=0; index<4; index++) {
        [deleteKey tap];
    }
    [rateTextField typeText:@"4.00"];
    
    // 输入元素验证
    XCTAssertTrue([valueTextField.value isEqualToString:@"100"], @"Strings are not equal %@ %@", @"100", valueTextField.value);
    XCTAssertTrue([periodTextField.value isEqualToString:@"1"], @"Strings are not equal %@ %@", @"1", periodTextField.value);
    XCTAssertTrue([rateTextField.value isEqualToString:@"4.00"], @"Strings are not equal %@ %@", @"4.00", rateTextField.value);
    
    
#pragma mark - Calculate Output

/*
 * 等额本金
 */
    // 点击计算
    XCUIElement *calButton = self.app.toolbars.buttons[@"计算"];
    [calButton tap];
    
    // 输出cell数
    XCUIElementQuery *cells = self.tablesQuery.cells;
    XCTAssertEqual(cells.count, 23);
    
    // 输出累计支付利息
    XCUIElementQuery *accuInterestCell = [self.tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"累计支付利息(元)"];
    XCUIElement *accuInterestValue = [[accuInterestCell childrenMatchingType:XCUIElementTypeStaticText] elementBoundByIndex:1];
    XCTAssertTrue([accuInterestValue.label isEqualToString:@"21,798.85"], @"Strings are not equal %@ %@", @"21,798.85", accuInterestValue.value);
    
    // 输出累计
    XCUIElementQuery *accuMoneyCell = [self.tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"累计还款总额(元)"];
    XCUIElement *accuMoneyValue = [[accuMoneyCell childrenMatchingType:XCUIElementTypeStaticText] elementBoundByIndex:1];
    XCTAssertTrue([accuMoneyValue.label isEqualToString:@"1,021,798.85"], @"Strings are not equal %@ %@", @"1,021,798.85", accuMoneyValue.label);
    
/*
 * 等额本息
 */
    // 还款方式
    XCUIElement *typeButton = self.tablesQuery.buttons[@"等额本金"];
    [typeButton tap];
    
    XCTAssertTrue([accuInterestValue.label isEqualToString:@"21,666.67"], @"Strings are not equal %@ %@", @"21,666.67", accuInterestValue.value);
    XCTAssertTrue([accuMoneyValue.label isEqualToString:@"1,021,666.67"], @"Strings are not equal %@ %@", @"1,021,666.67", accuMoneyValue.label);
    
    
#pragma mark - Reset Output
    
    // 点击重置
    [valueTextField tap];
    XCUIElement *resetButton = self.app.toolbars.buttons[@"重置"];
    [resetButton tap];
    
    // cell数
    XCTAssertEqual(cells.count, 6);
    
}

- (void)test2_CommerLoanPage {

    
#pragma mark - Modify Input
    
    // 切换到商业贷款Tab页
    [self.app.tabBars.buttons[@"商业"] tap];
    
    // 贷款金额
    XCUIElementQuery *inputValueCell = [self.tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"贷款金额(万)"];
    XCUIElement *valueTextField = [inputValueCell childrenMatchingType:XCUIElementTypeTextField].element;
    [valueTextField tap];
    [valueTextField typeText:@"50"];
    
    // 贷款期限
    XCUIElementQuery *inputPeriodCell = [self.tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"贷款期限(年)"];
    XCUIElement *periodTextField = [inputPeriodCell childrenMatchingType:XCUIElementTypeTextField].element;
    [periodTextField tap];
    [self.app.pickerWheels.element adjustToPickerWheelValue:@"20年（240期）"];
    
    // 贷款利率
    XCUIElementQuery *inputRateCell = [self.tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"贷款利率(％)"];
    XCUIElement *rateTextField = [inputRateCell childrenMatchingType:XCUIElementTypeTextField].element;
    [rateTextField tap];
    XCUIElement *deleteKey = self.app.keys[@"Delete"];
    for (int index=0; index<2; index++) {
        [deleteKey tap];
    }
    [rateTextField typeText:@"00"];
    
    // 贷款折扣
    XCUIElementQuery *inputDiscountCell = [self.tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"贷款折扣(倍)"];
    XCUIElement *discountTextField = [inputDiscountCell childrenMatchingType:XCUIElementTypeTextField].element;
    [discountTextField tap];
    for (int index=0; index<4; index++) {
        [deleteKey tap];
    }
    [discountTextField typeText:@"0.9"];
    
    // 还款方式
    XCUIElement *typeButton = self.tablesQuery.buttons[@"等额本金"];
    [typeButton tap];
    
    // 输入元素验证
    XCTAssertTrue([valueTextField.value isEqualToString:@"50"], @"Strings are not equal %@ %@", @"50", valueTextField.value);
    XCTAssertTrue([periodTextField.value isEqualToString:@"20"], @"Strings are not equal %@ %@", @"20", periodTextField.value);
    XCTAssertTrue([rateTextField.value isEqualToString:@"5.00"], @"Strings are not equal %@ %@", @"5.00", rateTextField.value);
    XCTAssertTrue([discountTextField.value isEqualToString:@"0.9"], @"String are not equal %@ %@", @"0.9", discountTextField.value);

    
    
#pragma mark - Calculate Output
    
    // 点击计算
    XCUIElement *calButton = self.app.toolbars.buttons[@"计算"];
    [calButton tap];
    
    // 输出cell数
    XCUIElementQuery *cells = self.tablesQuery.cells;
    XCTAssertEqual(cells.count, 253);
    
    // 输出累计支付利息
    XCUIElementQuery *accuInterestCell = [self.tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"累计支付利息(元)"];
    XCUIElement *accuInterestValue = [[accuInterestCell childrenMatchingType:XCUIElementTypeStaticText] elementBoundByIndex:1];
    XCTAssertTrue([accuInterestValue.label isEqualToString:@"225,937.50"], @"Strings are not equal %@ %@", @"225,937.50", accuInterestValue.value);
    
    // 输出累计还款总额
    XCUIElementQuery *accuMoneyCell = [self.tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"累计还款总额(元)"];
    XCUIElement *accuMoneyValue = [[accuMoneyCell childrenMatchingType:XCUIElementTypeStaticText] elementBoundByIndex:1];
    XCTAssertTrue([accuMoneyValue.label isEqualToString:@"725,937.50"], @"Strings are not equal %@ %@", @"725,937.50", accuMoneyValue.label);
    
    
    
#pragma mark - Reset Output
    
    // 点击重置
    [valueTextField tap];
    XCUIElement *resetButton = self.app.toolbars.buttons[@"重置"];
    [resetButton tap];
    
    // cell数
    XCTAssertEqual(cells.count, 7);
    
}


- (void)test3_MixedLoanPage {
    
    
#pragma mark - Modify Input
    
    // 切换到组合贷款Tab页
    [self.app.tabBars.buttons[@"组合"] tap];
    
    // 公积金贷款金额
    XCUIElementQuery *inputProfundValueCell = [self.tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"公积金贷款金额(万)"];
    XCUIElement *profundValueTextField = [inputProfundValueCell childrenMatchingType:XCUIElementTypeTextField].element;
    [profundValueTextField tap];
    [profundValueTextField typeText:@"100"];
    
    // 商业贷款金额
    XCUIElementQuery *inputCommerValueCell = [self.tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"商业贷款金额(万)"];
    XCUIElement *commerValueTextField = [inputCommerValueCell childrenMatchingType:XCUIElementTypeTextField].element;
    [commerValueTextField tap];
    [commerValueTextField typeText:@"50"];
    
    // 输入元素验证
    XCTAssertTrue([profundValueTextField.value isEqualToString:@"100"], @"Strings are not equal %@ %@", @"100", profundValueTextField.value);
    XCTAssertTrue([commerValueTextField.value isEqualToString:@"50"], @"Strings are not equal %@ %@", @"50", commerValueTextField.value);
    
    
    
#pragma mark - Calculate Output
    
    // 点击计算
    XCUIElement *calButton = self.app.toolbars.buttons[@"计算"];
    [calButton tap];
    
    // 输出cell数
    XCUIElementQuery *cells = self.tablesQuery.cells;
    XCTAssertEqual(cells.count, 374);
    
    // 输出累计支付利息
    XCUIElementQuery *accuInterestCell = [self.tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"累计支付利息(元)"];
    XCUIElement *accuInterestValue = [[accuInterestCell childrenMatchingType:XCUIElementTypeStaticText] elementBoundByIndex:1];
    XCTAssertTrue([accuInterestValue.label isEqualToString:@"1,049,589.96"], @"Strings are not equal %@ %@", @"1,049,589.96", accuInterestValue.value);
    
    // 输出累计还款总额
    XCUIElementQuery *accuMoneyCell = [self.tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"累计还款总额(元)"];
    XCUIElement *accuMoneyValue = [[accuMoneyCell childrenMatchingType:XCUIElementTypeStaticText] elementBoundByIndex:1];
    XCTAssertTrue([accuMoneyValue.label isEqualToString:@"2,549,589.96"], @"Strings are not equal %@ %@", @"2,549,589.96", accuMoneyValue.label);
    
    
    
#pragma mark - Reset Output
    
    // 点击重置
    [profundValueTextField tap];
    XCUIElement *resetButton = self.app.toolbars.buttons[@"重置"];
    [resetButton tap];
    
    // cell数
    XCTAssertEqual(cells.count, 9);
    
}

- (void)test4_SettingPage {
    
    // 切换到设置贷款Tab页
    [self.app.tabBars.buttons[@"设置"] tap];
    
    // 点击推荐朋友
    XCUIElement *recommendCell = [self.app.cells containingType:XCUIElementTypeStaticText identifier:@"推荐朋友"].element;
    [recommendCell tap];
    
    // 分享微信好友
    [self.app.buttons[@"UMS wechat session icon"] tap];
    
    // 关闭未安装微信提示
    [self.app.alerts[@"No Wechat"].collectionViews.buttons[@"OK"] tap];
    
}

@end
