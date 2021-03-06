//
//  ViewController.m
//  MemberManager
//
//  Created by 王璋传 on 2018/9/12.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ViewController.h"
#import <SDCycleScrollView.h>
#import "ZCMainActionButton.h"
#import "ZCServiceInfoListVC.h"
#import "ZCOrderListVC.h"
#import "CPMemeberOrderVC.h"
#import "CPLoginVC.h"
#import "ZCMemberMgrMainVC.h"
#import "ZCAccountMgrMainVC.h"
#import "CPHomeAdvModel.h"
#import "CPWebVC.h"

@interface ViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *adSV;
@property (nonatomic, strong) UILabel *amountLB;
@property (nonatomic, strong) NSArray <CPHomeAdvModel *> *advModels;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.adSV.imageURLStringsGroup = @[
//                                      @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2415197339,1350863646&fm=26&gp=0.jpg",
//                                      @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2415197339,1350863646&fm=26&gp=0.jpg",
//                                      @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2415197339,1350863646&fm=26&gp=0.jpg",
//                                   ];
    
    [self setupUI];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *value = [NSString stringWithFormat:@"¥%.2f",[CPUserInfoModel shareInstance].userDetaiInfoModel.totalcommission];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"服务费余额:" attributes:nil];
    NSAttributedString *attr0 = [[NSAttributedString alloc] initWithString:value attributes:@{NSForegroundColorAttributeName : UIColor.redColor}];
    [attr appendAttributedString:attr0];
    
    self.amountLB.attributedText = attr;
    
    self.title = [NSString stringWithFormat:@"代理编码：%@",([CPUserInfoModel shareInstance].userDetaiInfoModel.cpcode)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    if (![CPUserInfoModel shareInstance].isLogined) {
        
        CPLoginVC *loginVC = [[CPLoginVC alloc] init];
        
        [self.navigationController pushViewController:loginVC animated:YES];
    }

}


#pragma mark - setter && getter method implement

- (SDCycleScrollView *)adSV {
    if (!_adSV) {
        _adSV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero
                                                  delegate:self
                                          placeholderImage:nil];
        [self.view addSubview:self.adSV];
        
        [self.adSV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(self.adSV.mas_width).multipliedBy(2./5);;
        }];
    }
    
    return _adSV;
}

#pragma mark - setupUI
- (void)setupUI {
    
    //  查询金额
    UIView *amountView = [UIView new];
    amountView.backgroundColor = UIColor.whiteColor;
    amountView.layer.borderWidth = 1;
    amountView.layer.borderColor = BorderColor.CGColor;
    
    [self.view addSubview:amountView];
    [amountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.adSV.mas_bottom).offset(SPACE_OFFSET_F);
        make.height.mas_equalTo(amountView.mas_width).multipliedBy(1./4);
    }];
    
    self.amountLB = [ZCLabel new];
    self.amountLB.text = @"sldflasjdfl";

    [amountView addSubview:self.amountLB];
    [self.amountLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.centerY.mas_equalTo(amountView.mas_centerY);
    }];
    
    
    ZCButton *checkBT = [ZCButton new];
    [checkBT setTitle:@"查询" forState:0];
    
    [amountView addSubview:checkBT];
    [checkBT addTarget:self action:@selector(pushAmountListPage) forControlEvents:64];
    [checkBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-SPACE_OFFSET_F);
        make.centerY.mas_equalTo(amountView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    
    //  功能列表
    
    UIView *functionListView = [UIView new];
    functionListView.backgroundColor = BorderColor;
    functionListView.layer.borderWidth = 1;
    functionListView.layer.borderColor = BorderColor.CGColor;
    
    [self.view addSubview:functionListView];
    [functionListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(amountView.mas_bottom).offset(SPACE_OFFSET_F);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(amountView.mas_width).multipliedBy(1./4 * 2);
    }];
    
    
    ZCMainActionButton *orderBt = [ZCMainActionButton new];
    
    [functionListView addSubview:orderBt];
    [orderBt setTitle:@"订单中心" andImage:@"我的订单"];
    [orderBt addTarget:self action:@selector(pushOrderMgrPage) forControlEvents:64];
    [orderBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
    }];
    
    ZCMainActionButton *memeberMgrBt = [ZCMainActionButton new];

    [functionListView addSubview:memeberMgrBt];
    [memeberMgrBt setTitle:@"会员管理" andImage:@"手机回收"];
    [memeberMgrBt addTarget:self action:@selector(pushMemberMgrPage) forControlEvents:64];
    [memeberMgrBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(orderBt.mas_right).offset(1);
        make.width.mas_equalTo(orderBt.mas_width);
        make.height.mas_equalTo(orderBt.mas_height);
    }];
    
    ZCMainActionButton *appreciationBt = [ZCMainActionButton new];
    
    [functionListView addSubview:appreciationBt];
    [appreciationBt addTarget:self action:@selector(pushAppreciationPage) forControlEvents:64];
    [appreciationBt setTitle:@"增值服务" andImage:@"helpCenter"];
    [appreciationBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(orderBt.mas_bottom).offset(1);
        make.left.mas_equalTo(orderBt.mas_left);
        make.width.mas_equalTo(orderBt.mas_width);
        make.height.mas_equalTo(orderBt.mas_height);
    }];

    
    ZCMainActionButton *accountMgrBt = [ZCMainActionButton new];
    
    [functionListView addSubview:accountMgrBt];
    [accountMgrBt setTitle:@"账号管理" andImage:@"今日报价"];
    [accountMgrBt addTarget:self action:@selector(pushAccountPage) forControlEvents:64];
    [accountMgrBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(appreciationBt.mas_top);
        make.left.mas_equalTo(appreciationBt.mas_right).offset(1);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(orderBt.mas_height);
        make.width.mas_equalTo(orderBt.mas_width);
        make.bottom.mas_equalTo(0);
    }];

}

#pragma mark - delete method implement
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    DDLogInfo(@"%s",__FUNCTION__);
    CPHomeAdvModel *model = self.advModels[index];
    if (model.clickurl.length > 0) {
        CPWebVC *webVC = [[CPWebVC alloc] init];
        webVC.urlStr = model.clickurl;
        webVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

#pragma mark - private method

- (void)pushAmountListPage {
    DDLogInfo(@"%s",__FUNCTION__);
    
    ZCServiceInfoListVC *orderVC = [ZCServiceInfoListVC new];
    [self.navigationController pushViewController:orderVC animated:YES];
}

- (void)pushOrderMgrPage {
    DDLogInfo(@"%s",__FUNCTION__);
    
//    ZCOrderListVC *orderVC = [ZCOrderListVC new];
    CPMemeberOrderVC *orderVC = [CPMemeberOrderVC new];
    [self.navigationController pushViewController:orderVC animated:YES];
}

- (void)pushMemberMgrPage {
    DDLogInfo(@"%s",__FUNCTION__);
    ZCMemberMgrMainVC *vc = [ZCMemberMgrMainVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushAppreciationPage {
    DDLogInfo(@"%s",__FUNCTION__);
}

- (void)pushAccountPage {
    DDLogInfo(@"%s",__FUNCTION__);
    ZCAccountMgrMainVC *vc = [ZCAccountMgrMainVC new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - private method implement
- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    
    [CPHomeAdvModel modelRequestWith:CPURL_CONFIG_HOME_AD
                          parameters:nil
                               block:^(NSArray <CPHomeAdvModel *> *result) {
                                   [weakSelf handleLoadDataBlock:result];
                               } fail:^(CPError *error) {
                                   
                               }];
}

- (void)handleLoadDataBlock:(NSArray <CPHomeAdvModel *> *)result {
    self.advModels = result;
    self.adSV.imageURLStringsGroup = [result valueForKeyPath:@"imageurl"];
}
@end
