//
//  ZCOrderDetailVC.m
//  MemberManager
//
//  Created by 王璋传 on 2018/9/14.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCOrderDetailVC.h"
#import "ZCMemberOrderDetailCell.h"
#import "ZCOrdetailFooter.h"
#import "ZCCheckReportVC.h"

@interface ZCOrderDetailVC ()

@end

@implementation ZCOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.dataArray = @[
                       @[@"1111111"],
                       @[@"1111111"],
                       @[@"1111111"],
                       @[@"1111111"],
                       @[@"1111111"],
                       @[@"1111111"],
                       @[@"1111111"],
                       ].mutableCopy;
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - setter && getter method implement
#pragma mark - setupUI
#pragma mark - delete method implement
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {return 100;}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {return 80;}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {return SPACE_OFFSET_F;}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CPMemberOrderDetailCell.h";
    ZCMemberOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[ZCMemberOrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NSString *footerIdentifier = @"footerIdentifier";
    
    ZCOrdetailFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerIdentifier];
    if (nil == footer) {
        footer = [[ZCOrdetailFooter alloc] initWithReuseIdentifier:footerIdentifier];
        footer.contentView.backgroundColor = UIColor.whiteColor;
    }
    
    __weak typeof(self) weakSelf = self;
    
    footer.checkReportAction = ^{
        [weakSelf push2CheckReportVC:section];
    };

    return footer;
}
#pragma mark - private method

- (void)loadData {
    [self.dataTableView.mj_header endRefreshing];
    [self.dataTableView.mj_footer endRefreshing];
    
    [self.dataTableView reloadData];
}

- (void)push2CheckReportVC:(NSInteger)section {
    
    ZCCheckReportVC *vc = [[ZCCheckReportVC alloc] init];

    [self.navigationController pushViewController:vc animated:YES];
}

@end
