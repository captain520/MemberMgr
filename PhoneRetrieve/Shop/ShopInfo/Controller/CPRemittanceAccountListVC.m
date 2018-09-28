//
//  CPRemittanceAccountListVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRemittanceAccountListVC.h"
#import "CPRemittanceAccountCell.h"
#import "CPModifyShopInfoVC.h"

@interface CPRemittanceAccountListVC () {
    NSInteger savePayCfg;
    CPButton *saveAction;
}

@property (nonatomic,strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, assign) NSInteger paycfg;

@end

@implementation CPRemittanceAccountListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.dataArray = @[
    //                       @[@"中国农业银行(8731)"],
    //                       @[@"胡小小(1581****1234)"],
    //                       @[@"captain_2012(158****2123)"]
    //                       ];
    self.dataArray = @[
                       @[[NSString stringWithFormat:@"%@(%@)",[CPUserInfoModel shareInstance].userDetaiInfoModel.bankname,[CPUserInfoModel shareInstance].userDetaiInfoModel.banknum]],
                       @[[NSString stringWithFormat:@"%@(%@)",[CPUserInfoModel shareInstance].userDetaiInfoModel.aliname,[CPUserInfoModel shareInstance].userDetaiInfoModel.alinum]],
                       @[[NSString stringWithFormat:@"%@(%@)",[CPUserInfoModel shareInstance].userDetaiInfoModel.wxname,[CPUserInfoModel shareInstance].userDetaiInfoModel.wxnum]]
                       ];
    
    self.paycfg = [CPUserInfoModel shareInstance].userDetaiInfoModel.paycfg;
    
    savePayCfg = self.paycfg;
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            if ([CPUserInfoModel shareInstance].userDetaiInfoModel.bankname.length == 0) {
                return 0;
            }
        }
            break;
        case 1:
        {
            if ([CPUserInfoModel shareInstance].userDetaiInfoModel.aliname.length == 0) {
                return 0;
            }
        }
            break;
        case 2:
        {
            if ([CPUserInfoModel shareInstance].userDetaiInfoModel.wxname.length == 0) {
                return 0;
            }
        }
            break;
            
        default:
            break;
    }
    
    return 30.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            if ([CPUserInfoModel shareInstance].userDetaiInfoModel.bankname.length == 0) {
                return @"";
            }
            return @"银行卡";
            break;
        case 1:
            if ([CPUserInfoModel shareInstance].userDetaiInfoModel.aliname.length == 0) {
                return @"";
            }
            return @"支付宝";
            break;
        case 2:
            if ([CPUserInfoModel shareInstance].userDetaiInfoModel.wxname.length == 0) {
                return @"";
            }
            return @"微信";
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    switch (section) {
        case 2:
            return 200;
            break;
            
        default:
            break;
    }
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (2 == section) {
        NSString *cellIdentify = @"CPTitleDetailCell";
        
        UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentify];
        if (!footer) {
            footer = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:cellIdentify];
            
            saveAction = [CPButton new];
            saveAction.enabled = NO;
            [saveAction addTarget:self action:@selector(saveAction:) forControlEvents:64];
            [saveAction setTitle:@"保存修改" forState:0];
            
            [footer.contentView addSubview:saveAction];
            
            [saveAction mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(CELL_HEIGHT_F);
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_offset(-cellSpaceOffset);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
        }
        
        return footer;
        
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            if ([CPUserInfoModel shareInstance].userDetaiInfoModel.bankname.length == 0) {
                return 0;
            }
            break;
        case 1:
            if ([CPUserInfoModel shareInstance].userDetaiInfoModel.aliname.length == 0) {
                return 0;
            }
            break;
        case 2:
            if ([CPUserInfoModel shareInstance].userDetaiInfoModel.wxname.length == 0) {
                return 0;
            }
            break;
            
        default:
            break;
    }
    
    return CELL_HEIGHT_F;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPTitleDetailCell";
    
    CPRemittanceAccountCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CPRemittanceAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shouldShowBottomLine = NO;
    }
    
    cell.content = self.dataArray[indexPath.section][indexPath.row];
    
    switch (indexPath.section) {
        case 0:
        {
            cell.shouldSelected = self.paycfg == 1;
        }
            break;
        case 1:
        {
            cell.shouldSelected = self.paycfg == 3;
        }
            break;
        case 2:
        {
            cell.shouldSelected = self.paycfg == 2;
        }
            break;
            
        default:
            break;
    }
    
    //    cell.shouldSelected = [self.selectedIndexPath isEqual:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s",__FUNCTION__);
    
    switch (indexPath.section) {
        case 0:
        {
            saveAction.enabled = savePayCfg != 1;
            
            self.paycfg = 1;
        }
            break;
        case 1:
        {
            saveAction.enabled = savePayCfg != 3;
            
            self.paycfg = 3;
        }
            break;
        case 2:
        {
            
            saveAction.enabled = savePayCfg != 2;
            
            self.paycfg = 2;
        }
            break;
        default:
            break;
    }
    
    //    self.selectedIndexPath = indexPath;
    
    [self.dataTableView reloadData];
    //    NSString *title = @"修改银行账号";
    //    CPModifyShopInfoType type = CPModifyShopInfoTypeModifyBankAccount;
    //
    //    switch (indexPath.section) {
    //        case 1:
    //        {
    //            type = CPModifyShopInfoTypeModifyAlipayAccount;
    //            title = @"修改支付宝账号";
    //        }
    //            break;
    //        case 2:
    //        {
    //            type = CPModifyShopInfoTypeModifyWechatAccount;
    //            title = @"修改微信账号";
    //        }
    //            break;
    //
    //        default:
    //            break;
    //    }
    //
    //    [self push2AccountModifyPage:title type:type];
}

- (void)push2AccountModifyPage:(NSString *)title type:(CPModifyShopInfoType)type {
    
    CPModifyShopInfoVC *accountVC = [[CPModifyShopInfoVC alloc] init];
    accountVC.title = title;
    accountVC.type = type;
    
    [self.navigationController pushViewController:accountVC animated:YES];
}

#pragma mark - Private method
- (void)saveAction:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    
    NSDictionary *params = @{
                             @"userid" : @([CPUserInfoModel shareInstance].loginModel.ID),
                             @"paycfg" : @(self.paycfg)
                             };
    
    [CPBaseModel modelRequestWith:DOMAIN_ADDRESS@"/api/user/updatePay"
                       parameters:params
                            block:^(id result) {
                                [weakSelf handleSaveActionSuccessBlock:weakSelf];
                            } fail:^(CPError *error) {
                                
                            }];
}

- (void)handleSaveActionSuccessBlock:(id)result {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
