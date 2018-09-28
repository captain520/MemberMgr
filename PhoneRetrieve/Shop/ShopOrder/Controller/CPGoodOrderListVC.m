//
//  CPGoodOrderListVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/1.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPGoodOrderListVC.h"
#import "CPOrderCell.h"
#import "CPLeftRightCell.h"
#import "CPOrderSearchVC.h"
#import "CPAssistanteOrderDetailModel.h"
#import "CPConsignResultVC.h"
#import "CPOrderDetailVC.h"
#import "CPOrderListPageModel.h"

@interface CPGoodOrderListVC ()

@property (nonatomic, strong) NSArray <CPAssistanteOrderDetailModel *> *models;
@property (nonatomic, strong) UIButton *topBt;

@end

@implementation CPGoodOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = @[
                       @[
                           @"",@"",@"",@"",@"",@"",@"",@"",@""]
                       ];
    
    if (self.result == nil) {
        
        
        [self loadData];
    } else {
        self.models = self.result.cp_data;
        
        [self.dataTableView reloadData];
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"search") style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"right-arrow") style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
}

- (void)setupUI {
    
    if (nil == _topBt) {
        
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
    

}

- (void)back:(id)sender {
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([NSStringFromClass(obj.class) isEqualToString:@"CPShopOrderVC"]) {
            [self.navigationController popToViewController:obj animated:YES];
            *stop = YES;
        }

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 3 * CELL_HEIGHT_F;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"CPShopCartCell";
    
    CPOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CPOrderCell alloc] initWithStyle:0 reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.assistantOrderModel = self.models[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
//    switch (self.goodOrderListType) {
//        case CPGoodOrderListTypeShopRetrieveOrder:
//        case CPGoodOrderListTypeCartOverDueOrder:
//            return 0.000000001;
//            break;
//
//        default:
//            break;
//    }
    
    return CELL_HEIGHT_F;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    

    NSString *headerIdentify = @"headerIdentify";
    
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentify];
    CPLeftRightCell *cell = [header.contentView viewWithTag:CPBASETAG];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentify];
        header.contentView.backgroundColor = [UIColor whiteColor];
        
        cell       = [[CPLeftRightCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CPTitleDetailCell"];
        cell.tag   = CPBASETAG;
//        cell.title = @"待支付数量：50";
        cell.frame = CGRectMake(0, 0, SCREENWIDTH, CELL_HEIGHT_F);
//        cell.detailTextLabel.attributedText = cp_commonRedAttr(@"待支付金额: ", @"¥53631.00");
        
        [header.contentView addSubview:cell];
    }
    
    cell.title = [NSString stringWithFormat:@"总计:%ld项",self.result.total];
    NSString *priceStr = [NSString stringWithFormat:@"¥%ld",self.result.totalprice];
    cell.detailTextLabel.attributedText = cp_commonRedAttr(@"总金额: ",priceStr);
    
    return header;
//    NSString *headerIdentify = @"headerIdentify";
//
//    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentify];
//    if (!header) {
//        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentify];
//        header.contentView.backgroundColor = [UIColor whiteColor];
//
//        CPLeftRightCell *cell = [[CPLeftRightCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CPTitleDetailCell"];
//        cell.frame = CGRectMake(0, 0, SCREENWIDTH, CELL_HEIGHT_F);
//        cell.title = @"合计数量：50";
//        cell.subTitle = @"合计金额:¥53631.00";
//        cell.detailTextLabel.textColor = [UIColor redColor];
//
//        [header.contentView addSubview:cell];
//    }
//
//    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self push2VCWith:@"CPOrderDetailVC" title:@"评估详情"];
//    [self push2ShippingDetail];
    
    CPAssistanteOrderDetailModel *tempModel = self.models[indexPath.section];
//
//    CPConsignResultVC *vc = [[CPConsignResultVC alloc] init];
//    vc.ID = tempModel.ID;
//    vc.title = @"d详情";
//
//    [self.navigationController pushViewController:vc animated:YES];
    
    CPOrderDetailVC *vc = [[CPOrderDetailVC alloc] init];
    vc.orderID = tempModel.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)push2ShippingDetail {
    
}

- (void)searchAction:(id)sender {
    
    CPOrderSearchVC *vc = [[CPOrderSearchVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    if (self.goodOrderListType == CPGoodOrderListTypeCartOverDueOrder) {
        vc.type = CPOrderSearchTypeOverDueOrder;
        vc.title = @"回收车失效订单查询";
    } else if (self.goodOrderListType == CPGoodOrderListTypeShopRetrieveOrder) {
        vc.title = @"门店回收订单查询";
        vc.type = CPOrderSearchTypeOverFinishedOrder;
    }

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadData {

    DDLogInfo(@">>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
    __weak typeof(self) weakSelf = self;
    
    NSString *statuscfg = @"0";
    if (self.goodOrderListType == CPGoodOrderListTypeCartOverDueOrder) {

        statuscfg = @"1";
    }

    NSMutableDictionary *params = @{
                                    @"typeid": @([CPUserInfoModel shareInstance].loginModel.Typeid),
                                    @"userid": @([CPUserInfoModel shareInstance].loginModel.ID),
                                    @"statuscfg" : statuscfg
                                    }.mutableCopy;

    [CPAssistantOrderListPageModel modelRequestWith:CPURL_ASSISTANT_GET_RETRIEVE_ORDER
                                        parameters:params
                                             block:^(CPAssistantOrderListPageModel *result) {
                                                 [weakSelf handleLoadDataSuccessBlock:result];
                                             } fail:^(CPError *error) {
                                                 
                                             }];
}

- (void)handleLoadDataSuccessBlock:(CPAssistantOrderListPageModel *)result {
    
    if (!result || ![result isKindOfClass:[CPAssistantOrderListPageModel class]]) {
        return;
    }
    
    self.result = result;
    
    if (!result || result.total == 0 ) {
        self.models = nil;
    } else {
        self.models = result.cp_data;
    }

    [self.dataTableView reloadData];
    
    [self setupUI];
}

- (void)back2Top:(id)sender {
    
    DDLogInfo(@"------------------------------");
    [self.dataTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    
    //    [self.dataTableView setScrollsToTop:YES];
}

@end
