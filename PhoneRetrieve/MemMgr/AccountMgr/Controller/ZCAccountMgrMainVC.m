//
//  ZCAccountMgrMainVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/18.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCAccountMgrMainVC.h"
#import "CPLeftRightCell.h"
#import "CPAssistantModifyPhoneVC.h"
#import "CPModifyShopPasswdVC.h"
#import "CPMemberUpdateBankInfoVC.h"
#import "ZCSubAccountListVC.h"

@interface ZCAccountMgrMainVC ()

@end

@implementation ZCAccountMgrMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = @[
                       @[
                           @"代理名称：",
                           @"代理编号:",
                           @"手机号码:",
                           @"邮箱:",
                         ],
                       @[
                           @"登录密码",
                           ],
                       @[
                           @"子会员管理",
                           ],
                       @[
                           @"收款账号",
                           ],
                       ].mutableCopy;
    
    [self loadData];
}

#pragma mark - setter && getter method implement
#pragma mark - setupUI
#pragma mark - delete method implement
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"CPLeftRightCell";
    
    CPLeftRightCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[CPLeftRightCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.shouldShowBottomLine = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.subTitle = @"修改";
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    } else if (indexPath.section > 0) {
        if (indexPath.section == 1 || indexPath.section == 3) {
            cell.subTitle = @"修改";
        } else if (indexPath.section == 2) {
            cell.subTitle = @"管理";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.title = self.dataArray[indexPath.section][indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 2 ? 0 : 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return SPACE_OFFSET_F;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"代理信息";
            break;
        case 1:
            return @"安全设置";
            break;
        case 3:
            return @"收款信息";
            break;
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 2) {
        CPAssistantModifyPhoneVC *vc = [CPAssistantModifyPhoneVC new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        CPModifyShopPasswdVC *vc = [CPModifyShopPasswdVC new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        ZCSubAccountListVC *vc = [ZCSubAccountListVC new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 3 && indexPath.row == 0) {
        CPMemberUpdateBankInfoVC *vc = [CPMemberUpdateBankInfoVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - private method

@end
