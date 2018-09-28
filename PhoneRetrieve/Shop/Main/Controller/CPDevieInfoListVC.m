//
//  CPDevieInfoListVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/26.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPDevieInfoListVC.h"
#import "CPDeviceProblemCell.h"
#import "CPRetrieveFlowModel.h"
#import "CPGuaranteeListVC.h"
#import "CPFlowModel.h"

@interface CPDevieInfoListVC ()

@property (nonatomic, strong) NSMutableArray <NSIndexPath *> *selectedIndexPath;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) CPRetrieveFlowModel *flowModel;
@property (nonatomic, strong) NSArray <CPFlowModel *> *models;

@end

@implementation CPDevieInfoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.dataArray = @[
//                       @[@"充电无反应",@"机身弯曲",@"触摸失灵/延迟",@"Wi-Fi无法打开/无法连接",@"通话功能不正常",@"指纹无法完全录入和解锁",@"机身进水或受潮"]
//                       ];
    self.selectedIndexPath = @[].mutableCopy;
    
    self.dataTableView.allowsMultipleSelection = YES;
    
    [self.nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
//    NSString *urlStr = @"http://gw.aihuishou.com/app-portal/product/getpricepropertyinfo?appId=10002&timestamp=1520990357&token=4620225574E675CF8D-7CF7-48CC-9049-BBA9398EA24C&sign=d18165ec513f2244e7b296796c95e4e1&productId=17461";
//
//    __weak typeof(self) weakSelf = self;
//
//    [CPRetrieveFlowModel modelRequestWith:urlStr
//                               parameters:nil
//                                    block:^(id result) {
//                                        [weakSelf handleRetrieveFlowBlock:result];
//                                    } fail:^(CPError *error) {
//
//                                    }];
    
    NSString *urlStr = DOMAIN_ADDRESS@"/api/Report/findReportData?goodsid=1";
    __weak typeof(self) weakSelf = self;
    
    [CPFlowModel modelRequestWith:urlStr
                       parameters:nil
                            block:^(id result) {
                                [weakSelf handleFLowModelBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];

}

- (void)handleFLowModelBlock:(NSArray <CPFlowModel *> *)result {
    DDLogInfo(@"------------------------------");
    self.models = result;
    
    [self.dataTableView reloadData];
}

- (void)handleRetrieveFlowBlock:(CPRetrieveFlowModel *)result {
    self.flowModel = result;
    
    self.dataArray = @[
                       self.flowModel.featureProperties
                       ];
    [self.dataTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)nextButton {
    
    if (nil == _nextButton) {
        _nextButton = [UIButton new];
        _nextButton.titleLabel.font = CPFont_L;
        [_nextButton setTitle:@"下一步" forState:0];
        [_nextButton setBackgroundColor:MainColor];
        [_nextButton setTitleColor:C33 forState:0];

        [self.view addSubview:_nextButton];
        
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(0);
            make.height.mas_equalTo(CELL_HEIGHT_F * 3 / 2);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
    }
    
    return _nextButton;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT_F + cellSpaceOffset;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"CellIdentify";
    
    CPDeviceProblemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[CPDeviceProblemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.shouldShowBottomLine = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = tableView.backgroundColor;
    }
    
    NSArray *tempArray = self.dataArray[indexPath.section];
    
    Featureproperties *pModel = self.dataArray[indexPath.section][indexPath.row];
    
    cell.model = pModel.pricePropertyValues.lastObject;
//    cell.imageName = @"question_mark";
//    cell.title = tempArray[indexPath.row];
    cell.shouldHighted = [self.selectedIndexPath containsObject:indexPath];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.selectedIndexPath containsObject:indexPath] ?
    [self.selectedIndexPath removeObject:indexPath] : [self.selectedIndexPath addObject:indexPath];
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - private method

- (void)nextAction:(UIButton *)sender {
    CPGuaranteeListVC *vc = [[CPGuaranteeListVC alloc] init];
    vc.currentStep = 0;
    vc.model = self.flowModel;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
