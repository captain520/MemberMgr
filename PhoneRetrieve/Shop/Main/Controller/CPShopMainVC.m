//
//  CPShopMainVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/6.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopMainVC.h"
#import <SDCycleScrollView.h>
#import "CPCollectionView.h"
#import "CPShopMainActionView.h"
#import "CPWebVC.h"
#import "CPHomeLeftBarItem.h"
#import "CPLoginVC.h"
#import "CPHomeAdvModel.h"
#import "CPConfigUrlModel.h"
#import "CPShopGoodsListVC.h"
#import "CPConfigUrlModel.h"

@interface CPShopMainVC ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *adSV;
@property (nonatomic, strong) CPShopMainActionView *actionView;
@property (nonatomic, strong) CPHomeLeftBarItem *leftItem;
@property (nonatomic, strong) NSArray <CPHomeAdvModel *> *advModels;

@end

@implementation CPShopMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = @[
                       @[@""]
                       ];
    
    [self setupUI];
    
    [self loadData];
    
    self.navigationItem.title = [CPUserInfoModel shareInstance].loginModel.cp_code;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    
//    [self setTitle: [CPUserInfoModel shareInstance].loginModel.companyname];
//    [self setTitle:@"某某的店"];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"call") style:UIBarButtonItemStylePlain target:self action:@selector(showHelp)];
    
//    _leftItem = [CPHomeLeftBarItem new];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftItem];;
//
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeCityAction:)];
//    [_leftItem addGestureRecognizer:tap];
}

- (void)handleActionBlock:(CPMainActionType )type {
    
    __weak typeof(self) weakSelf = self;
    
    switch (type) {
        case CPMainActionTypeRetrieveAbout:
        {
//            [self getConfigUrl:@"101" block:^(NSString *url, NSString *title) {
//                [weakSelf push2WebView:url title:title];
//            }];
            [self push2VCWith:@"CPShopOrderVC" title:@"订单中心"];
        }
            break;
        case CPMainActionTypeRetrieveFlow:
        {
            // 故障机评估
            [CPUserInfoModel shareInstance].repaircfg = @"2";
            [self push2ShopGoodsListVC:0];
//            [self getConfigUrl:@"102" block:^(NSString *url, NSString *title) {
//                [weakSelf push2WebView:url title:title];
//            }];
        }
            break;
        case CPMainActionTypeAssistantManger:
        {
            [self push2VCWith:@"CPShippingStateVC" title:@"物流信息"];
//            [self push2VCWith:@"CPShippingInformationListVC" title:@"物流信息"];
//            [self push2VCWith:@"CPTBTestVC" title:@"店员管理"];
        }
            break;
        case CPMainActionTypePhoneRetrieve:
        {
            [CPUserInfoModel shareInstance].repaircfg = @"1";
            [self push2ShopGoodsListVC:0];
        }
            break;
        case CPMainActionTypePadRetrieve:
        {
            [CPUserInfoModel shareInstance].repaircfg = @"1";
            [self push2ShopGoodsListVC:1];
        }
            break;
        case  CPMainActionTypeRetrieveCart:
            [self push2CartVC];
            break;
        case CPMainActionTypeOther:
        {
            [self push2VCWith:@"CPHelpCenterVC" title:@"帮助中心"];
//            [CPConfigUrlModel modelRequestWith:DOMAIN_ADDRESS@"/api/sysconfig/getHelpDetail"
//                                    parameters:@{@"id" : @"7"}
//                                         block:^(CPConfigUrlModel *result) {
//                                             [self push2WebView:result.Description title:result.title];
//                                         } fail:^(CPError *error) {
//
//                                         }];
        }
            break;
        default:
            break;
    }
}

//- (void)getConfigUrl:(NSString *)code block:(void (^)(NSString *url,NSString *title))block {
//
//    [CPConfigUrlModel modelRequestWith:DOMAIN_ADDRESS@"/api/sysconfig/getSysConfigByCode"
//                            parameters:@{@"code" : code}
//                                 block:^(CPConfigUrlModel *result) {
//                                     !block ? : block(result.Description, result.title);
//                                 } fail:^(CPError *error) {
//
//                                 }];
//}
#pragma mark - UITableview Deleagte && datesource method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (4 * CELL_HEIGHT_F + 2 *CELL_HEIGHT_F * [CPUserInfoModel shareInstance].isShop) * 1.25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self configActionViewCell:indexPath];
}

- (id)configActionViewCell:(NSIndexPath *)indexPath {
    
    
    __weak CPShopMainVC *weakSelf = self;
    
    static NSString *identifier = @"UITableViewCell";
    
    UITableViewCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        CGFloat height = [self tableView:self.dataTableView heightForRowAtIndexPath:indexPath];
        
        self.actionView = [[CPShopMainActionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, height)];
        self.actionView.actionBlock = ^(CPMainActionType actionType) {
            [weakSelf handleActionBlock:actionType];
        };
        
        [cell.contentView addSubview:self.actionView];
        
        [self.actionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (0 == section) {
        return 4 * CELL_HEIGHT_F;
    }
    
    return cellSpaceOffset;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    NSString *headerIdentify = @"headerIdentify";
    
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentify];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentify];
        header.contentView.backgroundColor = [UIColor whiteColor];
        
        CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
        CGRect adFrame = CGRectMake(0, 0, SCREENWIDTH, height);
        
        self.adSV = [SDCycleScrollView cycleScrollViewWithFrame:adFrame
                                                       delegate:self
                                               placeholderImage:CPImage(@"Apple")];
//        self.adSV.imageURLStringsGroup = @[
//                                           @"http://f.hiphotos.baidu.com/image/pic/item/503d269759ee3d6db032f61b48166d224e4ade6e.jpg",
//                                           @"http://a.hiphotos.baidu.com/image/pic/item/500fd9f9d72a6059f550a1832334349b023bbae3.jpg",
//                                           @"http://d.hiphotos.baidu.com/image/pic/item/a044ad345982b2b713b5ad7d3aadcbef76099b65.jpg"
//                                           ];

        [header.contentView addSubview:self.adSV];

    }
    self.adSV.imageURLStringsGroup = [self.advModels valueForKeyPath:@"imageurl"];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 3 * CELL_HEIGHT_F;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return nil;
//    NSString *headerIdentify = @"FooterIdentify";
//
//    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentify];
//    if (!footer) {
//        footer = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentify];
//        footer.contentView.backgroundColor = [UIColor whiteColor];
//
//        UIButton *assessmentBT = [UIButton new];
//        [assessmentBT setBackgroundImage:CPImage(@"test.jpg") forState:UIControlStateNormal];
//        [assessmentBT addTarget:self action:@selector(pushRetrieveDesPage) forControlEvents:UIControlEventTouchUpInside];
//
//        [footer.contentView addSubview:assessmentBT];
//
//        [assessmentBT mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(0);
//            make.left.mas_equalTo(0);
//            make.right.mas_equalTo(0);
//            make.bottom.mas_equalTo(0);
//        }];
//
//    }
//
//    return footer;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%s%@",__FUNCTION__,@(index));
    
    CPHomeAdvModel *advModel = self.advModels[index];
    
    [self push2WebView:advModel.clickurl title:advModel.name];
}

//  跳转到网页
- (void)push2WebView:(NSString *)url title:(NSString *)title {
    
    if (url == nil) {
        url = @"https://www.baidu.com";
    }
    
    CPWebVC *webVC = [[CPWebVC alloc] init];
    webVC.hidesBottomBarWhenPushed = YES;
//    webVC.urlStr = url;
    webVC.contentStr = url;
    webVC.title = title;
    
    [self.navigationController pushViewController:webVC animated:YES];
    
}
- (void)pushRetrieveDesPage {
    
    [self getConfigUrl:@"102" block:^(NSString *url, NSString *title) {
        
        CPWebVC *webVC = [[CPWebVC alloc] init];
//        webVC.urlStr = @"https://www.baidu.com";
        webVC.contentStr = url;
        webVC.title = title;
        webVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:webVC animated:YES];
    }];
    
}

- (void)showHelp {
    [self push2VCWith:@"CPShopHelpVC" title:@"我的客服"];
}

- (void)push2ShopGoodsListVC:(NSInteger)typeIndex {
    CPShopGoodsListVC *vc = [[CPShopGoodsListVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.selecteTypeIndex = typeIndex;
    [self.navigationController pushViewController:vc animated:YES];
//    [self push2VCWith:@"CPShopGoodsListVC" title:@"商品型号选择"];
}

- (void)push2CartVC {
    [self push2VCWith:@"CPShopCartVC" title:@"回收车"];
}
//  导航栏选择省市区域
- (void)pickCityAction:(id)sender {
    NSLog(@"%s",__FUNCTION__);
}

//  切换城市
- (void)changeCityAction:(id)sender {
    self.leftItem.cityName = @"广西省壮族自治区";
}

- (void)push2LoginVC {
    
    CPLoginVC *vc = [[CPLoginVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:vc animated:NO];
}

- (void)loadData {
    
    __weak CPShopMainVC *weakSelf = self;
    
    [CPHomeAdvModel modelRequestWith:CPURL_CONFIG_HOME_AD
                          parameters:nil
                               block:^(NSArray <CPHomeAdvModel *> *result) {
                                   [weakSelf handleLoadDataBlock:result];
                               } fail:^(CPError *error) {
                                   
                               }];
}

- (void)handleLoadDataBlock:(NSArray <CPHomeAdvModel *> *)result {
    self.advModels = result;
    [self.dataTableView reloadData];
}

@end
