//
//  CPShippingStateVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShippingStateVC.h"
#import "CPShopOrderDetailModel.h"
#import "CPTitleDetailCell.h"
#import "CPShippingListCell.h"
#import "CPOrderListPageModel.h"
#import "CPOrderSearchVC.h"
#import "CPConsignResultVC.h"
#import "CPWebVC.h"
#import "CPTabBarView.h"

@interface CPShippingStateVC ()

@property (nonatomic, strong) CPTabBarView *tabbarView;
@property (nonatomic, assign) NSInteger currentTabIndex;

@end

@implementation CPShippingStateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabbarView.dataArray = @[@"在途",@"已签收"];
    
    self.dataTableView.frame = CGRectMake(0, NAV_HEIGHT + self.tabbarView.bounds.size.height, SCREENWIDTH, SCREENHEIGHT - NAV_HEIGHT - self.tabbarView.bounds.size.height);
    
    if (self.dataArray && self.dataArray.count > 0) {
        [self.dataTableView reloadData];
    } else {
        
        [self loadData:0];
        
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"search") style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"right-arrow") style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
}
- (void)back:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CPTabBarView *)tabbarView {
    
    if (_tabbarView == nil) {
        
        __weak typeof(self) weakSelf = self;
        
        _tabbarView = [[CPTabBarView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREENWIDTH, CELL_HEIGHT_F)];
        _tabbarView.backgroundColor = [UIColor whiteColor];
        _tabbarView.selectBlock = ^(NSInteger index) {
            //TODO: 切换选择刷新
            weakSelf.currentTabIndex = index;
            [weakSelf loadData:index];
        };
        
        [self.view addSubview:_tabbarView];
    }
    
    return _tabbarView;
}

#pragma mark - TableView datasource && delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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
    
    cell.logistModel = self.dataArray[indexPath.section];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CELL_HEIGHT_F;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    NSString *headerIdentify = @"headerIdentify";
    
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
//        cell.actionBT.hidden = YES;
        [cell.actionBT addTarget:self action:@selector(push2ShippingStatesVC) forControlEvents:64];
        
        [footer.contentView addSubview:cell];
    }
    CPShopOrderDetailModel *sectionModel = self.dataArray[section];
    cell.content = sectionModel.logisticsno;
    
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return cellSpaceOffset / 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDLogInfo(@"--------------------");
    
    CPShopOrderDetailModel *sectionModel = self.dataArray[indexPath.section];
    
    CPConsignResultVC *vc = [[CPConsignResultVC alloc] init];
    vc.ID = sectionModel.ID;
    vc.title = @"交易订单详情";
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - private method

- (void)loadData:(NSUInteger )index {

    __weak typeof(self) weakSelf = self;
    
    [CPOrderListPageModel modelRequestWith:DOMAIN_ADDRESS@"/api/Order/findOrderList"
                                  parameters:@{
                                               @"typeid" : @([CPUserInfoModel shareInstance].loginModel.Typeid),
                                               @"userid" : @([CPUserInfoModel shareInstance].loginModel.ID),
                                               @"finishcfg" : @(self.currentTabIndex)
                                               }
                                       block:^(CPOrderListPageModel *result) {
                                           [weakSelf handleLoadDataBlock:result];
                                       } fail:^(CPError *error) {
                                           
                                       }];
}

- (void)handleLoadDataBlock:(CPOrderListPageModel*)result {
    
    if (!result || ![result isKindOfClass:[CPOrderListPageModel class]]||result.cp_data.count == 0) {
        self.dataArray = nil;
    } else {
        self.dataArray = result.cp_data;
    }

    [self.dataTableView reloadData];
}

- (void)searchAction:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    
    CPOrderSearchVC *vc = [[CPOrderSearchVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"订单物流信息查询";
    vc.type = self.currentTabIndex ? CPOrderSearchTypeShippingFinished : CPOrderSearchTypeShippingOnWay;
    vc.payFilterBlock = ^(id result) {
        [weakSelf handleLoadDataBlock:result];
    };

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)push2ShippingStatesVC {
    
    NSString *url = @"http://www.sf-express.com/mobile/cn/sc/dynamic_function/waybill/waybill_query_by_billno.html";
    
    if (url == nil) {
        url = @"https://www.baidu.com";
    }
    
    CPWebVC *webVC = [[CPWebVC alloc] init];
    webVC.hidesBottomBarWhenPushed = YES;
        webVC.urlStr = url;
//    webVC.contentStr = @"";
//    webVC.title = title;
    
    [self.navigationController pushViewController:webVC animated:YES];
    
}

@end
