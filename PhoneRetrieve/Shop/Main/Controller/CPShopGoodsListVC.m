//
//  CPShopGoodsListVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/26.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopGoodsListVC.h"
#import "CPTypeGoodTypeView.h"
#import "CPImageLeftCell.h"
#import "CPGoodBrandCollectionViewCell.h"
#import "CPTabBarView.h"
#import "CPGoodTypeModel.h"
#import "CPBrandModel.h"
#import "CPGoodModel.h"
#import "CPSortCell.h"
#import "CPNavView.h"
#import "CPFlowVC.h"
#import "CPFlowModel.h"
#import "CPGoodSearchResultVC.h"

#import "CPMemberQuotePriceFlowVC.h"
#import "CPMemberQuoteFlowVC.h"


#import "CPQuoteManager.h"

#define OFFSET_F    (100.0f)
#define HEIGHT_F    (80.0f)
#define IDENTIFIER_T    @"IDENTIFIER"

@interface CPShopGoodsListVC ()<UICollectionViewDelegate, UICollectionViewDataSource,UISearchBarDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) CPTypeGoodTypeView *goodTypeView;
@property (nonatomic, strong) UICollectionView *brandCV;

@property (nonatomic, strong) CPTabBarView *tabbarView;
@property (nonatomic, strong) NSArray <CPGoodTypeModel *> *goodTypes;
@property (nonatomic, strong) NSArray <CPBrandModel *> *brandTypes;
@property (nonatomic, strong) NSMutableArray *goods;
@property (nonatomic, assign) NSInteger selectBrandIndex;
@property (nonatomic, strong) CPNavView *navView;
@property (nonatomic, strong) NSArray <CPFlowModel *> *result;

@property (nonatomic, strong) UIButton *topBt;

@end

@implementation CPShopGoodsListVC {
    CALayer *bottomLineLayer;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = @[
                       @[@"",@"",@"",@"",@"",@"",@"",@""]
                       ];
    
//    self.navigationItem.titleView = self.searchBar;
    self.goods = @[].mutableCopy;

    [self initialzedBaseProperties];
    
    [self loadData];
    
//    [self loadGoodList];
    
    [self setupUI];
}

- (void)initialzedBaseProperties {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push2QuoteFlow:) name:@"RefreshQuoteFlow" object:nil];
    
    self.currentPage = 1;
//    self.selecteTypeIndex = 0;
    self.selectBrandIndex = 0;
}

- (void)setupUIToBackUI {
    
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

- (void)setupUI {
    
    self.navView = [CPNavView new];
    self.navView.backgroundColor =MainColor;
    [self.navView.backButton addTarget:self action:@selector(backAction:) forControlEvents:64];
    [self.view addSubview:self.navView];
    
    [self.navView addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CPStatusBarHeight);
        make.left.mas_equalTo(self.navView.backButton.mas_right).offset(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.bottom.mas_equalTo(0);
    }];
    
    
    
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(NAV_HEIGHT);
    }];

    __weak CPShopGoodsListVC *weakSelf = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.dataTableView.frame = CGRectOffset(self.dataTableView.frame, OFFSET_F, NAV_HEIGHT + CELL_HEIGHT_F);
    self.dataTableView.frame = CGRectMake(OFFSET_F, NAV_HEIGHT + CELL_HEIGHT_F, SCREENWIDTH - OFFSET_F, SCREENHEIGHT - NAV_HEIGHT - CELL_HEIGHT_F);
    self.dataTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        DDLogInfo(@"------------------------------");
        self.currentPage = 1;
        [self loadGoodList];
    }];
    
    self.dataTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        DDLogInfo(@"------------------------------");
        self.currentPage++;
//        [self.dataTableView.mj_footer endRefreshing];
        
        [self loadGoodList];
    }];

//    [self.view addSubview:self.goodTypeView];
    
    self.tabbarView.selectedColor = C33;
    self.tabbarView.bottomLineColor = C33;

    [self.brandCV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tabbarView.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(OFFSET_F);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    if (nil == bottomLineLayer) {
        bottomLineLayer = [CALayer layer];
        bottomLineLayer.frame = CGRectMake(0, 0, 2.0f, HEIGHT_F - 10.0f);
        bottomLineLayer.backgroundColor = MainColor.CGColor;
        
        [self.brandCV.layer insertSublayer:bottomLineLayer atIndex:0];
    }
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//
//    self.navigationController.navigationBar.barTintColor = MainColor;
//
//    UIImage *image = [UIImage imageWithColor:MainColor];
//
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsCompact];
//    [self.navigationController.navigationBar setShadowImage:UIImage.new];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (CPTabBarView *)tabbarView {
    
    if (_tabbarView == nil) {
        
        __weak CPShopGoodsListVC *weakSelf = self;
        _tabbarView = [[CPTabBarView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT , SCREENWIDTH, CELL_HEIGHT_F)];
        _tabbarView.backgroundColor = MainColor;
        _tabbarView.clipsToBounds = YES;
//        _tabbarView.currentIndex = self.selecteTypeIndex;
        _tabbarView.selectBlock = ^(NSInteger index) {
            weakSelf.selecteTypeIndex = index;
            weakSelf.currentPage = 0;
            [weakSelf.goods removeAllObjects];
            
//            [weakSelf loadGoodList];
            [weakSelf loadBrand];
        };

        [self.view addSubview:_tabbarView];
    }
    
    return _tabbarView;
}

- (UISearchBar *)searchBar {
    
    if (nil == _searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, CELL_HEIGHT_F)];
        _searchBar.barTintColor = MainColor;//[UIColor clearColor];
//        _searchBar.backgroundColor = [UIColor redColor];
        _searchBar.layer.borderColor = MainColor.CGColor;
        _searchBar.backgroundImage = [UIImage new];
        _searchBar.delegate = self;
    }
    
    return _searchBar;
}

- (CPTypeGoodTypeView *)goodTypeView {
    
    if (nil == _goodTypeView) {
        _goodTypeView = [[CPTypeGoodTypeView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREENWIDTH, CELL_HEIGHT_F)];
        _goodTypeView.backgroundColor = MainColor;
    }
    
    return _goodTypeView;
}

- (UICollectionView *)brandCV {
    
    if (nil == _brandCV) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake(100, HEIGHT_F);
        
        _brandCV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _brandCV.delegate = self;
        _brandCV.dataSource = self;
        _brandCV.backgroundColor = [UIColor whiteColor];

        [_brandCV registerClass:[CPGoodBrandCollectionViewCell class] forCellWithReuseIdentifier:IDENTIFIER_T];
        [_brandCV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        
        [self.view addSubview:_brandCV];
        
    }
    
    return _brandCV;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goods.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return HEIGHT_F;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0000000001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000000001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.brandTypes.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"CPSortCell";
    
    CPSortCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[CPSortCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.contentView.backgroundColor = BgColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CPGoodModel *good = self.goods[indexPath.row];
    cell.no = [NSString stringWithFormat:@"%02ld",(long)indexPath.row + 1];
    cell.content = good.name;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self push2VCWith:@"CPDevieInfoListVC" title:@"手机是否存在以下问题？"];
    CPGoodModel *good = self.goods[indexPath.row];
//
//    CPFlowVC *vc = [[CPFlowVC alloc] init];
//    vc.goodid = good.ID;
//    vc.title = @"评估价格";
//    vc.deviceName = good.name;
//
//    [self.navigationController pushViewController:vc animated:YES];
//    [self push2VCWith:@"CPFlowVC" title:@"手机是否存在以下问题？"];
    
    [self nextMainQuoteFlow:good];
    
}

- (void)nextMainQuoteFlow:(CPGoodModel *)good {
    
    NSString *urlStr = DOMAIN_ADDRESS@"/api/Report/findUserReportData";
    __weak typeof(self) weakSelf = self;
    
    [CPMemberQuoteManager shareInstance].goodsid = good.ID;
    [CPMemberQuoteManager shareInstance].deviceName = good.name;
    
    [CPFlowModel modelRequestWith:urlStr
                       parameters:@{@"goodsid" : good.ID,
                                    @"report_item_id" : @"0"
                                    }
                            block:^(id result) {
                                [weakSelf handleNextmainQuoteBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
}
- (void)handleNextmainQuoteBlock:(NSArray <CPFlowModel *> *)result {
    
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        
        return;
    }
    
    [result enumerateObjectsUsingBlock:^(CPFlowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.itemData enumerateObjectsUsingBlock:^(CPItemData * _Nonnull subObj, NSUInteger idx, BOOL * _Nonnull stop) {
            subObj.parentName = obj.name;
        }];
    }];
    
//    [CPMemberQuoteManager shareInstance].mainQuoteFlowDataArray = result;
//
//    CPMemberQuotePriceFlowVC *vc = [[CPMemberQuotePriceFlowVC alloc] init];
//    vc.currentMainModel = result.firstObject;
//
//    [self.navigationController pushViewController:vc animated:YES];
    
    //  新的流程算法
//    [[CPMemberQuoteManager shareInstance].flows removeAllObjects];
//    [CPMemberQuoteManager shareInstance].flowIndex = 0;
//    [[CPMemberQuoteManager shareInstance].flows addObjectsFromArray:result];
    
    self.result = result;
    
    [self push2QuoteFlow:YES];
}

- (void)push2QuoteFlow:(BOOL)animated {
    
    [CPQuoteManager shareInstance].flows = self.result.mutableCopy;
    [CPQuoteManager shareInstance].firstFlows = self.result.copy;;
    [CPQuoteManager shareInstance].flowIndex = 0;
   
    CPMemberQuoteFlowVC *vc = [[CPMemberQuoteFlowVC alloc] init];
//    vc.currentMainModel = result.firstObject;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.row) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
        UILabel *allLB = [CPLabel new];
        allLB.font = CPFont_XL;
        allLB.text = @"全部";
        allLB.textAlignment = NSTextAlignmentCenter;
        allLB.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:allLB];
        [allLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0.5);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-0.5);
        }];

        return cell;
        
    } else {
        
        CPGoodBrandCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER_T forIndexPath:indexPath];
        cell.model = self.brandTypes[indexPath.row - 1];
        
        return cell;
        
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        return CGSizeMake(100, HEIGHT_F - 10.0f);
    } else {
        return CGSizeMake(100, HEIGHT_F);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"------");

    if (indexPath.row == 0) {
        self.selectBrandIndex = 0;
        bottomLineLayer.frame = CGRectMake(0, HEIGHT_F * indexPath.row, 2.0f, HEIGHT_F - 10.0f);
    } else {
        bottomLineLayer.frame = CGRectMake(0, HEIGHT_F * indexPath.row - 10.0f, 2.0f, HEIGHT_F);
        CPBrandModel *brandModel = self.brandTypes[indexPath.row - 1];
        
        self.selectBrandIndex = brandModel.ID;
    }
    
    [self.goods removeAllObjects];
    self.currentPage = 1;

    [self loadGoodList];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
//    [self push2VCWith:@"CPSearchVC" title:nil];
//    [self push2VCWith:@"CPGoodSearchResultVC" title:nil];
    CPGoodTypeModel *model = self.goodTypes[self.selecteTypeIndex];
    CPGoodSearchResultVC *vc = [[CPGoodSearchResultVC alloc] init];
    vc.deviceTypeid = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Private method
- (void)loadData {
    
    __weak CPShopGoodsListVC *weakSelf = self;
    
    [CPGoodTypeModel modelRequestWith:CPURL_SHOP_GOOD_TYPE
                           parameters:nil
                                block:^(NSArray <CPGoodTypeModel *> *result) {
                                    [weakSelf handleGoodTypeBlock:result];
                                } fail:^(CPError *error) {
                                    
                                }];
    
//    [CPBrandModel modelRequestWith:CPURL_SHOP_BRAND_TYPE
//                           parameters:nil
//                                block:^(id result) {
//                                    [weakSelf handleBrandTypeBlock:result];
//                                } fail:^(CPError *error) {
//
//                                }];
//    [self loadBrand];
}

- (void)loadBrand {
    
    __weak CPShopGoodsListVC *weakSelf = self;
    
    CPGoodTypeModel *tempModel = self.goodTypes[self.selecteTypeIndex];
    
    [CPBrandModel modelRequestWith:CPURL_SHOP_BRAND_TYPE
                        parameters:@{@"typeid" : @(tempModel.ID)}
                             block:^(id result) {
                                 [weakSelf handleBrandTypeBlock:result];
                             } fail:^(CPError *error) {
                                 
                             }];
}

- (void)handleGoodTypeBlock:(NSArray <CPGoodTypeModel *> *)result {
    self.goodTypes = result;
//    self.selecteTypeIndex = 0;
    
    self.tabbarView.dataArray = [self.goodTypes valueForKeyPath:@"name"];
    self.tabbarView.currentIndex = self.selecteTypeIndex;
    
    [self loadBrand];
//    [self loadGoodList];
}

- (void)handleBrandTypeBlock:(NSArray <CPBrandModel *> *)result {
    
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        CPBrandModel *model = [[CPBrandModel alloc] init];
        model.name = @"iOS";
        self.brandTypes = @[model];
    } else {
        self.brandTypes = result;
    }
    

    self.selectBrandIndex = 0;

    [self.brandCV reloadData];
    
    [self loadGoodList];
}

- (void)loadGoodList{
    
    __weak CPShopGoodsListVC *weakSelf = self;
    
    if (self.currentPage == 1) {
        [self.goods removeAllObjects];
    }
    
    CPGoodTypeModel *tempModel = self.goodTypes[self.selecteTypeIndex];
    
    NSMutableDictionary *params= @{
                            @"brandid" : @(self.selectBrandIndex),
                            @"typeid" : @(tempModel.ID),
                            @"currentpage" : @(self.currentPage),
                            @"repaircfg" : [CPUserInfoModel shareInstance].repaircfg,
                            @"pagesize" : @(10)
                            }.mutableCopy;
    if ([CPUserInfoModel shareInstance].loginModel.Typeid > 5) {    // 6 7 会员
        [params setObject:@"1" forKey:@"usetypecfg"];
    }

    [CPGoodModel modelRequestWith:CPURL_SHOP_GOOD_LIST
                       parameters:params
                            block:^(id result) {
                                [weakSelf handleLoadGoodListBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
}

- (void)handleLoadGoodListBlock:(NSArray <CPGoodModel *> *)result {
    

    if (!result || ![result isKindOfClass:[NSArray class]]) {
        
        [self.goods removeAllObjects];
        [self.dataTableView reloadData];
        
        return;
    }
    
//    [self.dataTableView.mj_footer endRefreshingWithNoMoreData];
    [self.dataTableView.mj_header endRefreshing];
    if (result.count < 10) {
        [self.dataTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.dataTableView.mj_footer endRefreshing];
    }

    [self.goods addObjectsFromArray:result];

    [self.dataTableView reloadData];
    
    [self setupUIToBackUI];
}

- (void)backAction:(CPButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)back2Top:(id)sender {
    
    DDLogInfo(@"------------------------------");
    [self.dataTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    
    //    [self.dataTableView setScrollsToTop:YES];
}

@end
