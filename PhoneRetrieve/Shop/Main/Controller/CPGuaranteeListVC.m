//
//  CPGuaranteeListVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/26.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPGuaranteeListVC.h"
#import "CPDeviceProblemCell.h"
#import "CPSKUFooter.h"
#import "CPRetrieveFlowProgressView.h"
#import "CPRetrieveAppearanceCell.h"
#import "CPEvaluatedPriceVC.h"

@interface CPGuaranteeListVC ()

@property (nonatomic, strong) NSMutableArray <NSIndexPath *> *selectedIndexPath;
@property (nonatomic, strong) CPRetrieveFlowProgressView *stepView;

@end

@implementation CPGuaranteeListVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.selectedIndexPath = @[].mutableCopy;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上一步" style:UIBarButtonItemStylePlain target:self action:@selector(preValueAction:)];
    
    [self.dataTableView addSubview:self.stepView];
}

- (CPRetrieveFlowProgressView *)stepView {
    
    if (!_stepView) {
        _stepView = [[CPRetrieveFlowProgressView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, cellSpaceOffset)];
        _stepView.progress = 0.1;
    }
    
    return _stepView;
}

- (void)setModel:(CPRetrieveFlowModel *)model {
    _model = model;
    
    if (self.currentStep < self.model.skuProperties.count) {
        
        Skuproperties *skuModel = self.model.skuProperties[self.currentStep];
        [self setTitle:skuModel.name];
        
        self.dataArray = @[
                           skuModel.pricePropertyValues
                           ];
    } else {
        Appearanceproperties *appearanceModel = self.model.appearanceProperties[self.currentStep - self.model.skuProperties.count + 1];
        [self setTitle:appearanceModel.name];
        
        self.dataArray = @[
                           appearanceModel.pricePropertyValues
                           ];
    }
    
    
//    self.dataArray = @[
//                       self.model.skuProperties[self.currentStep].pricePropertyValues
//                       ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.currentStep < self.model.skuProperties.count) {

        return CELL_HEIGHT_F + cellSpaceOffset;
    }
    
    return CELL_HEIGHT_F * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell = nil;
    if (self.currentStep < self.model.skuProperties.count) {
        return [self configSKUCell:indexPath];
    } else {
        return [self configAppearanceCell:indexPath];
    }
//    static NSString *cellIdentify = @"CellIdentify";
//
//    CPDeviceProblemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
//    if (nil == cell) {
//        cell = [[CPDeviceProblemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
//        cell.clipsToBounds = YES;
//        cell.shouldShowBottomLine = NO;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.contentView.backgroundColor = tableView.backgroundColor;
//    }
//
//    cell.model = self.dataArray[indexPath.section][indexPath.row];
//    cell.shouldHighted = [self.selectedIndexPath containsObject:indexPath];
//
    return cell;
}

- (CPDeviceProblemCell *)configSKUCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPDeviceProblemCell";
    
    CPDeviceProblemCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[CPDeviceProblemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.shouldShowBottomLine = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = self.dataTableView.backgroundColor;
    }
    
    cell.model = self.dataArray[indexPath.section][indexPath.row];
    cell.shouldHighted = [self.selectedIndexPath containsObject:indexPath];
    
    return cell;
}

- (CPRetrieveAppearanceCell *)configAppearanceCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPRetrieveAppearanceCell";
    
    CPRetrieveAppearanceCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[CPRetrieveAppearanceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.shouldShowBottomLine = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = self.dataTableView.backgroundColor;
    }
    
    cell.model = self.dataArray[indexPath.section][indexPath.row];
//    cell.shouldHighted = [self.selectedIndexPath containsObject:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 280.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    NSString *footerIdneitify = @"CPSKUFooter";
    
    CPSKUFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerIdneitify];
    if (!footer) {
        footer = [[CPSKUFooter alloc] initWithReuseIdentifier:footerIdneitify];
    }
    
    if (self.currentStep < self.model.skuProperties.count) {
        footer.model = self.model.skuProperties[self.currentStep];
    } else {
        footer.model = (Skuproperties *)self.model.appearanceProperties[self.currentStep - self.model.skuProperties.count + 1];
    }
    
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedIndexPath = @[indexPath].mutableCopy;
    
    [tableView reloadData];
    
//    [self push2VCWith:@"CPEvaluatedPriceVC" title:@"评估价格"];
    [self nextAction:nil];
}

- (void)nextAction:(UIButton *)sender {
    
    if (self.currentStep < self.model.skuProperties.count - 1) {
        self.currentStep++;
        self.model = _model;
        [self.dataTableView reloadData];
        self.stepView.progress = 1.0 * (self.currentStep+1) / (self.model.skuProperties.count + self.model.appearanceProperties.count - 1);
    } else if (self.currentStep < self.model.stepCount - 2) {
        self.currentStep++;
        self.model = _model;
        [self.dataTableView reloadData];
        
        self.stepView.progress = 1.0 * (self.currentStep+1) / (self.model.skuProperties.count + self.model.appearanceProperties.count - 1);
    } else if (self.currentStep == self.model.stepCount - 2) {
        
        CPEvaluatedPriceVC *vc = [[CPEvaluatedPriceVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)preValueAction:(id)sender {
    if (self.currentStep == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        self.currentStep--;
        self.model = _model;
        [self.dataTableView reloadData];
        self.stepView.progress = 1.0 * (self.currentStep+1) / (self.model.skuProperties.count + self.model.appearanceProperties.count);
    }
}

@end


