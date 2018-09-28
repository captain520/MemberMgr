//
//  CPMemeberMainVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemeberMainVC.h"
#import "CPMainItemCell.h"
#import "SDCycleScrollView.h"
#import "CPHomeAdvModel.h"
#import "CPShopGoodsListVC.h"
#import "CPWebVC.h"
#import "CPRecycleQuotePriceVC.h"

static NSString *cellIdentify = @"CPMainItemCell";


@interface CPMemeberMainVC ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
,SDCycleScrollViewDelegate
>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) SDCycleScrollView *adSV;
@property (nonatomic, strong) NSArray <CPHomeAdvModel *> *advModels;

@end

@implementation CPMemeberMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupUI];
    
    [self loadData];
}

- (void)setupUI {
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.title = [NSString stringWithFormat:@"会员号：%@",[CPUserInfoModel shareInstance].loginModel.cp_code];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"call") style:UIBarButtonItemStylePlain target:self action:@selector(showHelp)];
    
    CGRect adFrame = CGRectMake(0, NAV_HEIGHT, SCREENWIDTH, SCREENWIDTH / 3  * 1.5);
    self.adSV = [SDCycleScrollView cycleScrollViewWithFrame:adFrame
                                                   delegate:self
                                           placeholderImage:CPImage(@"logo")];
    [self.view addSubview:self.adSV];
    
    [self.collectionView registerClass:[CPMainItemCell class] forCellWithReuseIdentifier:cellIdentify];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter && setter method implement
- (UICollectionView *)collectionView {
    if (nil == _collectionView) {
        
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = SCREENWIDTH / 2. - .5;
        CGFloat height = width * 2 / 4;
        
        flowlayout.itemSize                = CGSizeMake(width,height);
        flowlayout.minimumLineSpacing      = .5;
        flowlayout.minimumInteritemSpacing = .5;

        CGRect frame = CGRectMake(0, 100, SCREENWIDTH, 3 * height + 2);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowlayout];
        _collectionView.delegate      = self;
        _collectionView.dataSource    = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = CPBoardColor;
        
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.adSV.mas_bottom).offset(8);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(frame.size.height);
        }];

    }
    
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {return 1;}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {return 6;}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {return CGSizeMake(SCREENWIDTH, .5);}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {return CGSizeMake(SCREENWIDTH, .5);};
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CPMainItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentify forIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColor.whiteColor;
    if (indexPath.row == 0) {
        [cell setTitle:@"手机回收" andImage:@"手机回收"];
    } else if (indexPath.row == 1) {
        [cell setTitle:@"回收车" andImage:@"回收车"];
    } else if (2 == indexPath.row) {
        [cell setTitle:@"平板回收" andImage:@"平板回收"];
    } else if (3 == indexPath.row) {
        [cell setTitle:@"我的订单" andImage:@"我的订单"];
    } else if (4 == indexPath.row) {
        [cell setTitle:@"今日报价" andImage:@"今日报价"];
    } else if (5 == indexPath.row) {
        [cell setTitle:@"保修查询" andImage:@"保修查询"];
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [CPUserInfoModel shareInstance].repaircfg = @"1";
    
    if (indexPath.row == 0) {
        [self push2ShopGoodsListVC:0];
    } else if (indexPath.row == 1) {
        [self push2VCWith:@"CPShopCartVC" title:@"回收车"];
    } else if (2 == indexPath.row) {
        [self push2ShopGoodsListVC:1];
    } else if (3 == indexPath.row) {
        [self push2VCWith:@"CPMemeberOrderVC" title:@"订单中心"];
    } else if (4 == indexPath.row) {
        [self push2VCWith:@"CPRecycleQuotePriceVC" title:@"今日报价"];
    } else if (5 == indexPath.row) {
        
        CPRecycleQuotePriceVC *vc = [[CPRecycleQuotePriceVC alloc] init];
        vc.type = 1;
        vc.title = @"保修查询";
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {

    CPHomeAdvModel *model = self.advModels[index];
    if (model.clickurl.length > 0) {
        CPWebVC *webVC = [[CPWebVC alloc] init];
        webVC.urlStr = model.clickurl;
        webVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:webVC animated:YES];
    }
    
}

#pragma mark - private method implement
- (void)loadData {
    
    __weak CPMemeberMainVC *weakSelf = self;
    
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

//  跳转到设备价格评估流程
- (void)push2ShopGoodsListVC:(NSInteger)typeIndex {
    CPShopGoodsListVC *vc = [[CPShopGoodsListVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.selecteTypeIndex = typeIndex;
    [self.navigationController pushViewController:vc animated:YES];
    //    [self push2VCWith:@"CPShopGoodsListVC" title:@"商品型号选择"];
}

- (void)showHelp {
    [self push2VCWith:@"CPShopHelpVC" title:@"我的客服"];
}

@end
