//
//  ZCOrderListVC.m
//  MemberManager
//
//  Created by 王璋传 on 2018/9/14.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCOrderListVC.h"
#import "ZCTabBarView.h"
#import "ZCOrderInfoCell.h"
#import "ZCOrderListHeaderView.h"
#import "ZCOrderDetailVC.h"

@interface ZCOrderListVC ()

@property (nonatomic, strong) ZCTabBarView *tabbarView;
@property (nonatomic, assign) NSInteger currentTabIndex;

@end

@implementation ZCOrderListVC

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

    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - setter && getter method implement
- (ZCTabBarView *)tabbarView {
    
    if (_tabbarView == nil) {
        
        __weak typeof(self) weakSelf = self;
        
        _tabbarView = [[ZCTabBarView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, CELL_HEIGHT_F)];
        _tabbarView.backgroundColor = [UIColor whiteColor];
        _tabbarView.selectBlock = ^(NSInteger index) {
            //TODO: 切换选择刷新
            weakSelf.currentTabIndex = index;
            [weakSelf loadData];
        };
        
        [self.view addSubview:_tabbarView];
    }
    
    return _tabbarView;
}
#pragma mark - setupUI

- (void)setupUI {
    
    self.tabbarView.dataArray = @[@"在途",@"已签收",@"待处理订单"];
    
    [self.dataTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tabbarView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark - delete method implement

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {return 160;};
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPMemeberOrderCell";
    
    ZCOrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[ZCOrderInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.shouldShowBottomLine = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    __weak typeof(self) weakSelf = self;
    
    cell.seeDetailAction = ^{
//        CPShopOrderDetailModel *model = self.dataArray[indexPath.section];
//        CPMemberOrderDetailVC *vc = [[CPMemberOrderDetailVC alloc] init];
//        vc.orderid = model.ID;
//        [weakSelf.navigationController pushViewController:vc animated:YES];
        ZCOrderDetailVC *vc = [[ZCOrderDetailVC alloc] init];
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    cell.checkConsignBlock = ^{
//        CPShopOrderDetailModel *model = self.dataArray[indexPath.section];
//        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//        pasteboard.string = model.logisticsno;
//        [[UIApplication sharedApplication].keyWindow makeToast:@"物流单号已复制到剪切板" duration:2. position:CSToastPositionCenter];
//
//        [weakSelf push2ShippingStatesVC];
    };
    
//    cell.model = self.dataArray[indexPath.section];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *headerIdentifier = @"headerIdentifier";
    
    ZCOrderListHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (nil == header) {
        header = [[ZCOrderListHeaderView alloc] initWithReuseIdentifier:headerIdentifier];
        header.contentView.backgroundColor = UIColor.whiteColor;
    }

    return header;
}
#pragma mark - private method

- (void)loadData {
    [self.dataTableView.mj_header endRefreshing];
    [self.dataTableView.mj_footer endRefreshing];
}

@end
