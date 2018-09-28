//
//  CPShippingInformationListVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShippingInformationListVC.h"
#import "CPTabBarView.h"
#import "CPShippingListCell.h"
#import "CPTitleDetailCell.h"
#import "CPLeftRightCell.h"
#import "CPOrderSearchVC.h"
#import "CPShopOrderDetailModel.h"
#import "CPConsignResultVC.h"
#import "CPOrderListPageModel.h"


@interface CPShippingInformationListVC ()

@property (nonatomic, strong) CPTabBarView *tabbarView;
@property (nonatomic, strong) NSArray <CPShopOrderDetailModel *> *models;
@property (nonatomic, strong) CPOrderListPageModel *result;
@property (nonatomic, strong) UIButton *topBt;
@property (nonatomic, assign) NSInteger currentTabIndex;

@end

@implementation CPShippingInformationListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupUI];
    
    [self loadData:0];
}

- (void)setupUI {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"search") style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
    
    if (self.tabbarType == CPTabBarTypeShippingState) {
        self.tabbarView.dataArray = @[@"全部",@"待收货",@"已收货"];
    } else if (self.tabbarType == CPTabBarTypePayState) {
        self.tabbarView.dataArray = @[@"待支付",@"已支付"];
    }


    self.dataTableView.frame = CGRectMake(0, CELL_HEIGHT_F + NAV_HEIGHT, SCREENWIDTH, SCREENHEIGHT - NAV_HEIGHT - CELL_HEIGHT_F);
//    self.dataTableView.frame = CGRectInset(self.dataTableView.frame, 0, CELL_HEIGHT_F);
    
    _topBt = [UIButton new];
//    [_topBt setTitle:@"回顶部" forState:0];
    _topBt.alpha = 0.5f;
    [_topBt setImage:CPImage(@"back2top") forState:0];
    [_topBt addTarget:self action:@selector(back2Top:) forControlEvents:64];
    [self.view addSubview:_topBt];
    
    [_topBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREENHEIGHT / 3 * 2);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];

}

- (void)back2Top:(id)sender {
    
    DDLogInfo(@"------------------------------");
    [self.dataTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

//    [self.dataTableView setScrollsToTop:YES];
}

- (CPTabBarView *)tabbarView {
    
    if (_tabbarView == nil) {
        
        __weak typeof(self) weakSelf = self;
        
        _tabbarView = [[CPTabBarView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREENWIDTH, CELL_HEIGHT_F)];
        _tabbarView.backgroundColor = [UIColor whiteColor];
        _tabbarView.selectBlock = ^(NSInteger index) {
            weakSelf.currentTabIndex = index;
            [weakSelf loadData:index];
        };

        [self.view addSubview:_tabbarView];
    }
    
    return _tabbarView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.models.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60 + 10;
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
    
    cell.model = self.models[indexPath.section];

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
        [cell.actionBT addTarget:self action:@selector(push2ShippingStatesVC) forControlEvents:64];

        [footer.contentView addSubview:cell];
    }
    CPShopOrderDetailModel *sectionModel = self.models[section];
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
    
    cell.title = [NSString stringWithFormat:@"总计:%ld项",self.result.total];
    NSString *priceStr = [NSString stringWithFormat:@"¥%ld",self.result.totalprice];
    cell.detailTextLabel.attributedText = cp_commonRedAttr(@"总金额: ",priceStr);

    return header;
}


- (void)push2ShippingStatesVC {
    [self push2VCWith:@"CPConsignStateVC" title:@"物流查询"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CPShopOrderDetailModel *sectionModel = self.models[indexPath.section];

    CPConsignResultVC *vc = [[CPConsignResultVC alloc] init];
    vc.ID = sectionModel.ID;
    vc.title = @"交易订单详情";

    [self.navigationController pushViewController:vc animated:YES];
//    [self push2VCWith:@"CPConsignResultVC" title:@"交易订单详情"];
}

- (void)searchAction:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    
    CPOrderSearchVC *vc = [[CPOrderSearchVC alloc] init];
    vc.payFilterBlock = ^(id result) {
        [weakSelf handleLoadDataBlock:result];
    };
    vc.hidesBottomBarWhenPushed = YES;
    if (self.currentTabIndex == 0) {
        vc.type = CPOrderSearchTypeShopUnpaidOrder;
        vc.title = @"待支付订单查询";
    } else {
        vc.type = CPOrderSearchTypeShopPaidOrder;
        vc.title = @"已支付订单查询";
    }
//    if (self.tabbarType == CPTabBarTypeShippingState) {
//        vc.type = CPOrderSearchTypeShipping;
//    } else if (self.tabbarType == CPTabBarTypePayState) {
//        vc.type = CPOrderSearchTypeOrder;
//    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadData:(NSInteger )index {
    
    __weak typeof(self) weakSelf = self;

    [CPOrderListPageModel modelRequestWith:DOMAIN_ADDRESS@"/api/Order/findOrderList"
                                  parameters:@{
                                               @"typeid" : @([CPUserInfoModel shareInstance].loginModel.Typeid),
                                               @"userid" : @([CPUserInfoModel shareInstance].loginModel.ID),
                                               @"paycfg" : @(index)
                                               }
//                                       block:^(NSArray <CPShopOrderDetailModel *> *result) {
                                     block:^(CPOrderListPageModel *result) {
                                           [weakSelf handleLoadDataBlock:result];
                                       } fail:^(CPError *error) {
                                           
                                       }];
}

//- (void)handleLoadDataBlock:(NSArray <CPShopOrderDetailModel *> *)result {
- (void)handleLoadDataBlock:(CPOrderListPageModel *)result {
    
    self.result = result;

    if (!result || result.total == 0 ) {
        self.models = nil;
    } else {
        self.models = result.cp_data;
    }

    [self.dataTableView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    self.topBt.alpha = 1;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    DDLogInfo(@"XXXXXXXXXXXXXXXXXXXX");
    self.topBt.alpha = 1;
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    [UIView animateWithDuration:1.0f animations:^{
//        self.topBt.alpha = 0.5f;
//    }];
//}
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//
//    DDLogInfo(@"---------");
//}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    DDLogInfo(@"---------");
    
    [UIView animateWithDuration:1.0f animations:^{
        self.topBt.alpha = 0.5f;
    }];
}

@end
