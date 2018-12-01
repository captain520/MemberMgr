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
#import "CPMemberOrderDetailCell.h"
#import "CPMemberOrderDetailFooter.h"
#import "CPMemberOrderDetailModel.h"
#import "CPMemberCheckReportVC.h"
#import "CPOrderDetailVC.h"
#import "ZCRejectVC.h"

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
            DDLogInfo(@"page:%@",@(index));
            weakSelf.currentTabIndex = index;
            [weakSelf loadData:index];
        };
        
        [self.view addSubview:_tabbarView];
    }
    
    return _tabbarView;
}

#pragma mark - view
- (void)setupUI {
    
    [self setTitle:@"我的交易订单"];
    
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.currentTabIndex == 2 ? 100 : 200;
};
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.currentTabIndex == 2 ? 8 : 30 * 2;
};
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.currentTabIndex == 2 ? 80 + 80 : 8;
};
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.currentTabIndex == 2) {
        static NSString *cellIdentifier = @"CPMemberOrderDetailCell.h";
        CPMemberOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            cell = [[CPMemberOrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        CPMemberOrderDetailModel *model = self.dataArray[indexPath.section];
        cell.model = model;
        
        return cell;
    } else {
        
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
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (self.currentTabIndex == 2) {
        return nil;
    }
    
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (self.currentTabIndex != 2) {
        return nil;
    }
    
    NSString *footerIdentifier = @"footerIdentifier";
    
    CPMemberOrderDetailFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerIdentifier];
    if (nil == footer) {
        footer = [[CPMemberOrderDetailFooter alloc] initWithReuseIdentifier:footerIdentifier];
        footer.contentView.backgroundColor = UIColor.whiteColor;
    }
    
    __weak typeof(self) weakSelf = self;
    
    footer.checkReportAction = ^{
        DDLogInfo(@"------------------------------");
        [weakSelf push2CheckReportVC:section];
    };
    
    footer.agreeActionBlock = ^{
        [weakSelf handleAgreeBlock:section];
    };
    
    footer.rejectActionBlock = ^{
        [weakSelf handleRejectBlock:section];
    };
    
    footer.offLineActionBlock = ^{
        [weakSelf handleOffLineBlock:section];
    };
    
    footer.model = self.dataArray[section];
    
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CPMemberOrderDetailModel *model = self.dataArray[indexPath.section];
    
    CPOrderDetailVC *vc = [[CPOrderDetailVC alloc] init];
    vc.orderID = model.ID;
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - private method
- (void)loadData:(NSUInteger )index {
    
    if (index == 2) {
        [self loadUnusualOrderData];
    } else {
        
        __weak typeof(self) weakSelf = self;
        
        NSDictionary *params = @{
                                 @"currentuserid" : USER_ID,
                                 @"currentusertypeid" : @([CPUserInfoModel shareInstance].loginModel.Typeid),
                                 @"finishcfg" : @(index),
                                 @"currentpage" : @1,
                                 @"pagesize" : @"100",
                                 };
        //    [CPOrderListPageModel modelRequestPageWith:DOMAIN_ADDRESS@"/api/Order/findUserOrderList"
        [CPOrderListPageModel modelRequestPageWith:DOMAIN_ADDRESS@"/api/Order/findUserOrderListWithAgent"
                                        parameters:params
         //                                    parameters:@{
         //                                                 @"typeid" : @([CPUserInfoModel shareInstance].loginModel.Typeid),
         //                                                 @"userid" : @([CPUserInfoModel shareInstance].loginModel.ID),
         //                                                 @"finishcfg" : @(self.currentTabIndex)
         //                                                 }
                                             block:^(CPOrderListPageModel *result) {
                                                 [weakSelf handleLoadDataBlock:result];
                                             } fail:^(CPError *error) {
                                                 
                                             }];
    }
    
}

- (void)handleLoadDataBlock:(CPOrderListPageModel*)result {
    
    if (!result || ![result isKindOfClass:[CPOrderListPageModel class]]||result.cp_data.count == 0) {
        self.dataArray = nil;
    } else {
        self.dataArray = result.cp_data.mutableCopy;
    }
    
    [self.dataTableView reloadData];
}

- (void)loadUnusualOrderData {
    
    __weak typeof(self) weakSelf = self;
    
    NSDictionary *params = @{
                             @"currentuserid" : USER_ID,
                             @"currentusertypeid" : @([CPUserInfoModel shareInstance].loginModel.Typeid),
                             @"debugcfg" : @(1),
                             @"currentpage" : @1,
                             @"pagesize" : @"100",
                             };
   
    [CPMemberOrderDetailModel modelRequestWith:DOMAIN_ADDRESS@"/api/reportresult/findReportResultWithAgent"
                                    parameters:params
                                         block:^(id result) {
                                             [weakSelf loadUnusualOrderDataBlock:result];
                                         } fail:^(CPError *error) {
                                             
                                         }];
}
- (void)loadUnusualOrderDataBlock:(NSArray <CPMemberOrderDetailModel *> *)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        self.dataArray = @[].mutableCopy;
    } else {
        self.dataArray = [NSMutableArray arrayWithArray:result];
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

/**
 * 跳转到检测报告页面
 */
- (void)push2CheckReportVC:(NSInteger)section {
    
    CPMemberOrderDetailModel *model = self.dataArray[section];
    
    CPMemberCheckReportVC *vc = [[CPMemberCheckReportVC alloc] init];
    vc.resultid = model.ID;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleAgreeBlock:(NSInteger)section {
    
    
    __weak typeof(self) weakSelf = self;
    
    CPMemberOrderDetailModel *model = self.dataArray[section];
    
    NSDictionary *params = @{
                             @"id" : model.ID,
                             @"userid" : USER_ID
                             };
    
    [CPBaseModel modelRequestWith:DOMAIN_ADDRESS@"/api/reportresult/updateResultAgree"
                       parameters:params
                            block:^(id result) {
                                [weakSelf.view makeToast:@"订单同意成交操作成功" duration:3 position:CSToastPositionCenter];
                                [weakSelf loadUnusualOrderData];
                            } fail:^(CPError *error) {
                                [weakSelf.view makeToast:@"订单同意成交操作失败" duration:3 position:CSToastPositionCenter];
                            }];
}

- (void)handleRejectBlock:(NSInteger)section {
    
    CPMemberOrderDetailModel *model = self.dataArray[section];
    
    ZCRejectVC *vc = [[ZCRejectVC alloc] init];
    vc.model = model;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleOffLineBlock:(NSInteger)section {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"拨打电话"
                                                                             message:@"0755-82726085" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:cancelAction];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"立即拨打" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://075582726085"]];
    }];
    
    [alertController addAction:confirmAction];
    

    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
