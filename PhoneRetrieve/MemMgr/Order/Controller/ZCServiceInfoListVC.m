//
//  ZCOrderListVC.m
//  MemberManager
//
//  Created by 王璋传 on 2018/9/13.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCServiceInfoListVC.h"
#import "ZCSearchVC.h"
#import "ZCServiceListHeaderView.h"
#import "ZCServiceDetailCell.h"

@interface ZCServiceInfoListVC ()

@end

@implementation ZCServiceInfoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = @[
                       @[@"1111111",
                       @"1111111",
                       @"1111111",
                       @"1111111",
                       @"1111111",
                       @"1111111"]
                       ].mutableCopy;
    
    [self loadData];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setupUI
- (void)setupUI {
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
}

#pragma mark - delete method implement

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ZCServiceDetailCell";
    
    ZCServiceDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZCServiceDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 2 * CELL_HEIGHT_F;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *headerIdentifier = @"headerIdentifier";
    
    ZCServiceListHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (nil == header) {
        header = [[ZCServiceListHeaderView alloc] initWithReuseIdentifier:headerIdentifier];
        header.contentView.backgroundColor = UIColor.whiteColor;
    }
    
    return header;
}

#pragma mark - private method implement
- (void)loadData {
    if (self.currentIndex == 0) {
        self.dataArray = @[@[@"1111111",
                             @"1111111",
                             @"1111111",
                             @"1111111",
                             @"1111111",
                             @"1111111",
                             @"1111111",
                             @"1111111",
                             @"1111111"]].mutableCopy;
    } else {
        [self.dataArray addObject:@[@"1111111",
                                    @"1111111",
                                    @"1111111",
                                    @"1111111",
                                    @"1111111",
                                    @"1111111"]];
    }
    
    [self.dataTableView.mj_header endRefreshing];
    [self.dataTableView.mj_footer endRefreshing];
    
    [self.dataTableView reloadData];
}

- (void)searchAction:(id)sender {
    
    ZCSearchVC *searchVC = [ZCSearchVC new];
    
    [self.navigationController pushViewController:searchVC animated:YES];
}

@end
