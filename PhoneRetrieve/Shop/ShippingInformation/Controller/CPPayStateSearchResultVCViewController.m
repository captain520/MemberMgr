//
//  CPPayStateSearchResultVCViewController.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/31.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPPayStateSearchResultVCViewController.h"
#import "CPShippingListCell.h"
#import "CPTitleDetailCell.h"
#import "CPLeftRightCell.h"
#import "CPOrderSearchVC.h"

@interface CPPayStateSearchResultVCViewController ()

@end

@implementation CPPayStateSearchResultVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"right-arrow") style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"search") style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
    
}

- (void)searchAction:(id)sender {
    
    CPOrderSearchVC *vc = [[CPOrderSearchVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
//    vc.type = CPOrderSearchTypeShopUnpaidOrder;
//    vc.title = @"待支付订单查询";
    
//    if (self.currentTabIndex == 0) {
//        vc.type = CPOrderSearchTypeShopUnpaidOrder;
//        vc.title = @"待支付订单查询";
//    } else {
//        vc.type = CPOrderSearchTypeShopPaidOrder;
//        vc.title = @"已支付订单查询";
//    }
    //    if (self.tabbarType == CPTabBarTypeShippingState) {
    //        vc.type = CPOrderSearchTypeShipping;
    //    } else if (self.tabbarType == CPTabBarTypePayState) {
    //        vc.type = CPOrderSearchTypeOrder;
    //    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)back:(id)sender {
    //    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([NSStringFromClass(obj.class) isEqualToString:@"CPShopOrderVC"]) {
            [self.navigationController popToViewController:obj animated:YES];
            *stop = YES;
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.payStateOrderModel.cp_data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPShippingListCell";
    
    CPShippingListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[CPShippingListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        //        cell.clipsToBounds = YES;
        cell.shouldShowBottomLine = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.contentView.backgroundColor = tableView.backgroundColor;
    }
    
    cell.model = self.payStateOrderModel.cp_data[indexPath.section];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CELL_HEIGHT_F;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    NSString *headerIdentify = @"footerIdentify";
    
    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentify];
    CPTitleDetailCell *cell = [footer.contentView viewWithTag:CPBASETAG];
    if (!footer) {
        footer = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentify];
        footer.contentView.backgroundColor = [UIColor whiteColor];
        
        cell = [[CPTitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CPTitleDetailCell"];
        cell.shouldShowBottomLine = NO;
        cell.tag = CPBASETAG;
        cell.frame = CGRectMake(0, 0, SCREENWIDTH, CELL_HEIGHT_F);
        cell.actionBT.hidden = NO;
        cell.title = @"物流单号：";
        //        cell.content = @"92881828q12";
        cell.actionBT.hidden = YES;
//        [cell.actionBT addTarget:self action:@selector(push2ShippingStatesVC) forControlEvents:64];
        
        [footer.contentView addSubview:cell];
    }
    CPShopOrderDetailModel *sectionModel = self.payStateOrderModel.cp_data[section];
    cell.content = sectionModel.logisticsno;
    
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (0 == section) {
        return CELL_HEIGHT_F;
    } else {
        return cellSpaceOffset / 2;
    }
    
    //    if (0 == section && self.tabbarType == CPTabBarTypePayState) {
    ////        return CELL_HEIGHT_F;
    //        return 0.00000001;
    //    }
    //
    //    if (0 == section) {
    //        return 0.0f;
    //    }
    //
    //    return cellSpaceOffset / 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (0 != section) {
        return nil;
    }
    
    NSString *headerIdentify = @"headerIdentify";
    
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentify];
    CPLeftRightCell *cell = [header.contentView viewWithTag:CPBASETAG];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentify];
        header.contentView.backgroundColor = [UIColor whiteColor];
        
        cell       = [[CPLeftRightCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CPTitleDetailCell"];
        cell.tag   = CPBASETAG;
        cell.title = @"待支付数量：50";
        cell.frame = CGRectMake(0, 0, SCREENWIDTH, CELL_HEIGHT_F);
        cell.detailTextLabel.attributedText = cp_commonRedAttr(@"待支付金额: ", @"¥53631.00");
        
        [header.contentView addSubview:cell];
    }
    
    cell.title = [NSString stringWithFormat:@"总计:%ld项",self.payStateOrderModel.total];
    NSString *priceStr = [NSString stringWithFormat:@"¥%ld",self.payStateOrderModel.totalprice];
    cell.detailTextLabel.attributedText = cp_commonRedAttr(@"总金额: ",priceStr);
    
    return header;
}



@end
