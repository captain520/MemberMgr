//
//  ZCMemberMgrMainVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/15.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCMemberMgrMainVC.h"
#import "CPLeftRightCell.h"
#import "ZCMemberListVC.h"
#import "ZCMemberCheckListVC.h"
#import "CPMemberRegisterStep01VC.h"

@interface ZCMemberMgrMainVC ()

@end

@implementation ZCMemberMgrMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setuoUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter && getter method implement
#pragma mark - setupUI
- (void)setuoUI {
    
    [self setTitle:@"会员管理"];
    
//    self.dataArray = @[
//                       @[@"会员审核"],
//                       @[@"会员新增"],
//                       @[@"已注册会员信息"]
//                       ].mutableCopy;
    
    self.dataArray = @[
                       @[@"会员审核",
                       @"会员新增",
                       @"已注册会员信息"]
                       ].mutableCopy;
    self.dataTableView.mj_header = nil;
    self.dataTableView.mj_footer = nil;
}
#pragma mark - delete method implement
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPLeftRightCell";
    
    CPLeftRightCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[CPLeftRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIView *bgView = [UIView new];
        bgView.backgroundColor = MainColor;
        cell.selectedBackgroundView = bgView;
    }
    
    cell.title = self.dataArray[indexPath.section][indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = nil;
    switch (indexPath.row) {
        case 0:
            vc = [ZCMemberCheckListVC new];
            break;
        case 1:
            vc = [CPMemberRegisterStep01VC new];
            break;
        case 2:
            vc = [ZCMemberListVC new];
            break;
        default:
            break;
    }

    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - private method
- (void)loadData {
    
}

@end
