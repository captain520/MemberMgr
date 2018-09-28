//
//  CPConsignResultVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPConsignResultVC.h"
#import "CPShopCartCell.h"
#import "CPTitleDetailCell.h"
#import "CPOrderCountHeader.h"
#import "CPOrderCell.h"
#import "CPShippingDetailModel.h"
#import "CPOrderCell.h"
#import "CPShippingCell.h"
#import "CPOrderDetailVC.h"

@interface CPConsignResultVC ()

@property (nonatomic, strong) NSArray *tempDataArray;
@property (nonatomic, strong) CPShippingDetailModel *model;

@end

@implementation CPConsignResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = @[
                       @[@"",@""],
                       @[@"物流公司：",@"物流单号："],
                       @[@"门店编码：",@"门店名称：",@"联系电话: ",@"交易时间: "]
                       ];
    
    self.tempDataArray = @[
                       @[@"",@""],
                       @[@"顺丰快递",@"452235566"],
                       @[@"********************",@"**********",@"15814099322",@"2018-02-01 13:12"]
                       ];
    
//    self.dataTableView.separatorColor = [UIColor clearColor];
    [self loadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.model.cpdata.count;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 4;
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            return 2 * CELL_HEIGHT_F;
            break;
            
        default:
            break;
    }
    
    return 30.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        
        static NSString *identifier = @"CPOrderCell";
        
        CPShippingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CPShippingCell alloc] initWithStyle:0 reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.model = self.model.cpdata[indexPath.row];
        
        return cell;
        
    } else {
        return [self configOrderNoCell:indexPath];
    }
    
    return [self configOrderNoCell:indexPath];
}

- (id)configOrderNoCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPTitleDetailCell";
    
    CPTitleDetailCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CPTitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shouldShowBottomLine = NO;
    }
    
    NSArray *tempArray = self.dataArray[indexPath.section];
    
    cell.title = [tempArray objectAtIndex:indexPath.row];;
    switch (indexPath.section) {
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                    cell.content = self.model.logisticscompanyname;
                    break;
                case 1:
                    cell.content = self.model.logisticsno;
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                    cell.content = self.model.shopname;
                    break;
                case 1:
                    cell.content = self.model.shopname;
                    break;
                case 2:
                    cell.content = self.model.shopname;
                    
                    break;
                case 3:
                    cell.content = self.model.createtime;
                    
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    cell.actionBT.hidden = YES;
//    cell.actionBT.hidden = !(indexPath.section == 1 && indexPath.row == 1);
//    [cell.actionBT addTarget:self action:@selector(push2ConsignStateVC) forControlEvents:64];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (1 == section) {
        return 1;
    }
    
    return CELL_HEIGHT_F;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (0 == section) {
        
        NSString *headerIdentify = @"headerIdentify";
        
        UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentify];
        CPLabel *orderNoLB = [header.contentView viewWithTag:CPBASETAG];
        if (!header) {
            header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentify];
            header.contentView.backgroundColor = [UIColor whiteColor];
            
            orderNoLB = [CPLabel new];
            orderNoLB.font = CPFont_L;
            orderNoLB.tag = CPBASETAG;
            orderNoLB.textColor = [UIColor redColor];
            orderNoLB.text = @"交易订单号：8712992372";
            [header.contentView addSubview:orderNoLB];
            
            [orderNoLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(0);
                make.left.mas_offset(cellSpaceOffset);
                make.right.mas_offset(-cellSpaceOffset);
                make.bottom.mas_equalTo(0);
            }];
        }
        
        orderNoLB.text = [NSString stringWithFormat:@"交易订单号:%@",self.model.ordersn];
        
        return header;
        
    } else if (2 == section) {
        
        NSString *headerIdentify = @"headerIdentify2";
        
        UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentify];
        if (!header) {
            header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentify];
            header.contentView.backgroundColor = [UIColor whiteColor];
            
            CPLabel *orderNoLB = [CPLabel new];
            orderNoLB.font = [UIFont boldSystemFontOfSize:13.0f];
            orderNoLB.text = @"操作门店";
            [header.contentView addSubview:orderNoLB];
            
            [orderNoLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(0);
                make.left.mas_offset(cellSpaceOffset);
                make.right.mas_offset(-cellSpaceOffset);
                make.bottom.mas_equalTo(0);
            }];
        }
        
        return header;
        
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        
        ShippingDetailData *tempModel = self.model.cpdata[indexPath.row];

        CPOrderDetailVC *vc = [[CPOrderDetailVC alloc] init];
        vc.orderID = [NSString stringWithFormat:@"%ld",tempModel.resultid];//tempModel.resultid;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (0 == section) {
        return CELL_HEIGHT_F;
    }
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (0 == section) {
        
        NSString *headerIdentify = @"FooterIdentify";
        
        CPOrderCountHeader *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentify];
        if (!footer) {
            footer = [[CPOrderCountHeader alloc] initWithReuseIdentifier:headerIdentify];
            footer.contentView.backgroundColor = [UIColor whiteColor];
        }
        
        footer.count = self.model.cpdata.count;
        footer.amount = [self getAmount];
        
        return footer;
    }
    
    return nil;
}

- (CGFloat)getAmount {
    
    __block CGFloat amount = 0.0f;

    [self.model.cpdata enumerateObjectsUsingBlock:^(ShippingDetailData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        amount += obj.price.floatValue;
    }];
    
    return amount;
}

- (void)push2ConsignStateVC {
    [self push2VCWith:@"CPConsignStateVC" title:@"物流详情"];
}

- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    
    [CPShippingDetailModel modelRequestWith:DOMAIN_ADDRESS@"/api/Order/getOrderDetail"
                                 parameters:@{@"id" : self.ID}
                                      block:^(id result) {
                                          [weakSelf handleLoadDataBlock:result];
                                      } fail:^(CPError *error) {
                                          
                                      }];
}

- (void)handleLoadDataBlock:(CPShippingDetailModel *)result {
    
    if (!result || ![result isKindOfClass:[CPShippingDetailModel class]]) {
        return;
    }
    
    self.model = result;
    
    [self.dataTableView reloadData];
}

@end
