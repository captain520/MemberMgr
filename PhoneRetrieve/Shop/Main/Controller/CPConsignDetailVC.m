//
//  CPConsignDetailVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPConsignDetailVC.h"
#import "CPShopCartCell.h"
#import "CPOrderCountHeader.h"
#import "CPTitleDetailCell.h"
#import "CPConsignFooter.h"
#import "CPAddCartSuccessVC.h"
#import "CPShopShippingResultModel.h"
#import "CPOrderDetailVC.h"

@interface CPConsignDetailVC ()

@property (nonatomic, strong) NSArray *tempDataArray;
//@property (nonatomic, strong) CPTextField *companyTF, *consignNoLB;

@end

@implementation CPConsignDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.dataArray = @[
                       @[@"",@""],
                       @[@"收件人：",@"联系电话：",@"收件地址："]
                       ];
    self.tempDataArray = @[
                       @[@"",@""],
                       @[
                           [CPUserInfoModel shareInstance].customerHelpModel.linkname,
                           [CPUserInfoModel shareInstance].customerHelpModel.linkphone,
                           [CPUserInfoModel shareInstance].customerHelpModel.linkaddress
                         ]
                       ];
    
    [self initializedBaseProperties];
    [self setupUI];
}

- (void)initializedBaseProperties {
    
}

- (void)setupUI {
    [self setTitle:@"发货"];
    self.dataTableView.separatorColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return self.selectedModels.count;
    } else {
        NSArray *tempArray = [self.dataArray objectAtIndex:section];
        return tempArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 1:
            return 30.0f;
            break;
            
        default:
            break;
    }
    
    return 2 * CELL_HEIGHT_F;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        
        static NSString *identifier = @"CPShopCartCell";
        
        CPShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CPShopCartCell alloc] initWithStyle:0 reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.canEdit = NO;
        }
        
        cell.model = self.selectedModels[indexPath.row];

        return cell;
        
    } else if (1 == indexPath.section) {
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
    }
    cell.shouldShowBottomLine = indexPath.row == 2;
    
    NSArray *tempArray = self.dataArray[indexPath.section];
    
    cell.title = [tempArray objectAtIndex:indexPath.row];;
    cell.content = self.tempDataArray[indexPath.section][indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (IS_MEMBER_ACCOUNT && 1 == section) {
        return CELL_HEIGHT_F;
    }
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (IS_MEMBER_ACCOUNT && 1 == section) {
        NSString *headerCellIdneitifier = @"";
        UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerCellIdneitifier];
        CPLabel *titleLB = [header.contentView viewWithTag:CPBASETAG];
        if (nil == header) {
            header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerCellIdneitifier];
            header.contentView.backgroundColor = UIColor.whiteColor;
            
            titleLB = [CPLabel new];
            titleLB.textColor = UIColor.redColor;
            titleLB.text = @"温馨提示：平台承担快递费用，寄件时请选择到付";
            
            [header.contentView addSubview:titleLB];
            [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
            }];
            
            UIView *sepLine = [UIView new];
            sepLine.backgroundColor = CPBoardColor;
            
            [header.contentView addSubview:sepLine];
            [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.height.mas_equalTo(.5);
            }];
        }
        
        return header;
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
        {
            
            return CELL_HEIGHT_F;
//            if ([CPUserInfoModel shareInstance].loginModel.Typeid > 5) {
//                return 10.0;
//            } else {
//                return CELL_HEIGHT_F;
//            }
        }
            break;
        case 1:
            return 330.0f;
            break;
            
        default:
            break;
    }
    
    return 30.0f;
}

- (CGFloat)totalPrice {
    
    __block CGFloat amount = 0.0f;
    
    [self.selectedModels enumerateObjectsUsingBlock:^(CPCartModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        amount += obj.price.floatValue;
    }];
    
    return amount;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (0 == section) {
        
        NSString *headerIdentify = @"headerIdentify";
        
        CPOrderCountHeader *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentify];
        if (!footer) {
            footer = [[CPOrderCountHeader alloc] initWithReuseIdentifier:headerIdentify];
            footer.contentView.backgroundColor = [UIColor whiteColor];
        }
        
        footer.count = self.selectedModels.count;
        footer.amount = [self totalPrice];
        
        return footer;
        
    } else if (1 == section) {
        
        
        __weak typeof(self) weakSelf = self;
        
        NSString *headerIdentify = @"headerIdentify";
        
        CPConsignFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentify];
        if (!footer) {
            footer = [[CPConsignFooter alloc] initWithReuseIdentifier:headerIdentify];
            footer.contentView.backgroundColor = [UIColor whiteColor];
            footer.actionBlock = ^(NSDictionary *dict) {
                [weakSelf push2SuccesVC:dict];
            };
        }

        return footer;
        
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    ShippingDetailData *tempModel = self.model.cpdata[indexPath.row];
    if (0 == indexPath.section) {
        CPCartModel *model = self.selectedModels[indexPath.row];
        
        CPOrderDetailVC *vc = [[CPOrderDetailVC alloc] init];
        vc.orderID = [NSString stringWithFormat:@"%ld",model.ID];//tempModel.resultid;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (NSString *)getOrderJson {
    
    NSMutableArray *orderDict = @[].mutableCopy;

    [self.selectedModels enumerateObjectsUsingBlock:^(CPCartModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [orderDict addObject:@{@"resultid" : @(obj.ID)}];
    }];
    
    return cp_jsonString(orderDict);
}

- (void)push2SuccesVC:(NSDictionary *)blockDict {
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:blockDict];
    [dict setObject:[self getOrderJson] forKey:@"orderjson"];
    
    NSString *url = DOMAIN_ADDRESS@"/api/Order/insertOrder";
    if ([CPUserInfoModel shareInstance].loginModel.Typeid == 6 || [CPUserInfoModel shareInstance].loginModel.Typeid == 7) {
        url = DOMAIN_ADDRESS@"/api/Order/insertUserOrder";
    }

    [CPShopShippingResultModel modelRequestWith:url
                           parameters:dict
                                block:^(CPShopShippingResultModel *result) {
                                    [weakSelf handleActionBlock:result];
                                } fail:^(NSError *error) {
                                    
                                }];
    
}

- (void)handleActionBlock:(CPShopShippingResultModel *)result {
    
    CPAddCartSuccessVC *vc = [[CPAddCartSuccessVC alloc] init];
    vc.type = CPSucessTypeSendGood;
    vc.title = @"发货成功";
    vc.shipModel = result;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
