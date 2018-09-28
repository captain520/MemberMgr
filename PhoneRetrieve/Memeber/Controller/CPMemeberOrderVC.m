//
//  CPMemeberOrderVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemeberOrderVC.h"
#import "CPTabBarView.h"
#import "CPOrderListPageModel.h"
#import "CPShippingListCell.h"
#import "CPMemeberOrderCell.h"
#import "CPMemberOrderDetailVC.h"
#import "CPWebVC.h"
#import "ZCOrderListHeaderView.h"
#import "ZCOrderSearchVC.h"
#import "ZCSearchListVC.h"

@interface CPMemeberOrderVC ()

@property (nonatomic, strong) CPTabBarView *tabbarView;
@property (nonatomic, assign) NSInteger currentTabIndex;

@end

@implementation CPMemeberOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self loadData:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter && getter
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

#pragma mark - view
- (void)setupUI {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
    
    self.tabbarView.dataArray = @[@"在途",@"已签收",@"待处理订单"];
    
    [self.dataTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tabbarView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark - UITableViewDelegate && datasouce method implement
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {return self.dataArray.count;};
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {return 1;};
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {return 200;};
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {return 30 * 2;};
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {return 8;};
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentify = @"CPMemeberOrderCell";
    
    CPMemeberOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[CPMemeberOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        //        cell.clipsToBounds = YES;
        cell.shouldShowBottomLine = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.contentView.backgroundColor = tableView.backgroundColor;
    }
    
    __weak typeof(self) weakSelf = self;
    
    cell.seeDetailAction = ^{
        CPShopOrderDetailModel *model = self.dataArray[indexPath.section];
        CPMemberOrderDetailVC *vc = [[CPMemberOrderDetailVC alloc] init];
        vc.orderid = model.ID;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    cell.checkConsignBlock = ^{
        CPShopOrderDetailModel *model = self.dataArray[indexPath.section];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = model.logisticsno;
        [[UIApplication sharedApplication].keyWindow makeToast:@"物流单号已复制到剪切板" duration:2. position:CSToastPositionCenter];
        
        [weakSelf push2ShippingStatesVC];
    };
    
    cell.model = self.dataArray[indexPath.section];

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *headerIdentifier = @"headerIdentifier";
    
    ZCOrderListHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (nil == header) {
        header = [[ZCOrderListHeaderView alloc] initWithReuseIdentifier:headerIdentifier];
        header.contentView.backgroundColor = UIColor.whiteColor;
    }
    
    CPShopOrderDetailModel *model = self.dataArray[section];
    header.model = model;
    
    return header;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    NSString *headerIdentifier = @"headerIdentifier";
//
//    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
//    CPLabel *titleLB = [header.contentView viewWithTag:CPBASETAG];
//    if (nil == header) {
//        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentifier];
//        header.contentView.backgroundColor = UIColor.whiteColor;
//
//        titleLB = [CPLabel new];
//        titleLB.tag = CPBASETAG;
//        [header.contentView addSubview:titleLB];
//        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(0);
//            make.left.mas_equalTo(cellSpaceOffset);
//            make.right.mas_equalTo(-cellSpaceOffset);
//            make.bottom.mas_equalTo(0);
//        }];
//
//        UIView *sepLine = [UIView new];
//        sepLine.backgroundColor = CPBoardColor;
//
//        [header.contentView addSubview:sepLine];
//        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(0);
//            make.right.mas_equalTo(0);
//            make.bottom.mas_equalTo(0);
//            make.height.mas_equalTo(.5);
//        }];
//
//    }
//
//    CPShopOrderDetailModel *model = self.dataArray[section];
//
//    titleLB.text = [NSString stringWithFormat:@"交易订单号：%@",model.ordersn];
//
//    return header;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    NSString *footerIdentifier = @"footerIdentifier";
//
//    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerIdentifier];
//    CPLabel *titleLB = [footer.contentView viewWithTag:CPBASETAG];
//    if (nil == footer) {
//        footer = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:footerIdentifier];
//        footer.contentView.backgroundColor = UIColor.whiteColor;
//
//        titleLB = [CPLabel new];
//        [footer.contentView addSubview:titleLB];
//        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(0);
//            make.left.mas_equalTo(cellSpaceOffset);
//            make.right.mas_equalTo(-cellSpaceOffset);
//            make.bottom.mas_equalTo(0);
//        }];
//
//        UIView *sepLine = [UIView new];
//        sepLine.backgroundColor = CPBoardColor;
//
//        [footer.contentView addSubview:sepLine];
//        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(0);
//            make.right.mas_equalTo(0);
//            make.bottom.mas_equalTo(0);
//            make.height.mas_equalTo(.5);
//        }];
//
//    }
//
//    titleLB.text = [NSString stringWithFormat:@"物流单号：%@",@"12345654342534"];
//
//    return footer;
//}

#pragma mark - private method
- (void)loadData:(NSUInteger )index {
    
    __weak typeof(self) weakSelf = self;
    
    [CPOrderListPageModel modelRequestPageWith:DOMAIN_ADDRESS@"/api/Order/findUserOrderList"
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
        self.dataArray = result.cp_data.mutableCopy;
    }
    
    [self.dataTableView reloadData];
}

- (void)push2ShippingStatesVC {
    
    NSString *url = @"http://www.sf-express.com/mobile/cn/sc/dynamic_function/waybill/waybill_query_by_billno.html";
    
    CPWebVC *webVC = [[CPWebVC alloc] init];
    webVC.hidesBottomBarWhenPushed = YES;
    webVC.urlStr = url;
    
    [self.navigationController pushViewController:webVC animated:YES];
    
}

- (void)searchAction:(id)sender {
    
    ZCOrderSearchVC *searchVC = [ZCOrderSearchVC new];
//    ZCSearchListVC *searchVC = [ZCSearchListVC new];
    
    [self.navigationController pushViewController:searchVC animated:YES];
}

@end
