//
//  CPRecycleQuotePriceVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRecycleQuotePriceVC.h"
#import "CPTabBarView.h"
#import "CPRecycleQuotePriceModel.h"
#import "CPImageTitleUpDownCell.h"
#import "CPWebVC.h"
#import "CPCollectionViewLayout.h"

static NSString *cellIdentify = @"CPImageTitleUpDownCell";

@interface CPRecycleQuotePriceVC ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) CPTabBarView *tabbarView;
@property (nonatomic, assign) NSUInteger currentTabIndex;

@property(nonatomic, strong) NSArray <CPRecycleQuotePriceModel *> *typeModels;
@property (nonatomic, strong) NSArray <CPRecycleQuotePriceDetailModel *> *contentModels;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CPRecycleQuotePriceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    [self.collectionView registerClass:[CPImageTitleUpDownCell class] forCellWithReuseIdentifier:cellIdentify];
}

#pragma mark - setter && getter
- (CPTabBarView *)tabbarView {
    
    if (_tabbarView == nil) {
        
        __weak typeof(self) weakSelf = self;
        
        _tabbarView = [[CPTabBarView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREENWIDTH, self.type ? 0 : CELL_HEIGHT_F)];
        _tabbarView.backgroundColor = [UIColor whiteColor];
        _tabbarView.clipsToBounds = YES;
        _tabbarView.selectBlock = ^(NSInteger index) {
            //TODO: 切换选择刷新
            weakSelf.currentTabIndex = index;
            [weakSelf loadContentAt:index];
        };
        
        [self.view addSubview:_tabbarView];
    }
    
    return _tabbarView;
}

#pragma mark - getter && setter method implement
- (UICollectionView *)collectionView {
    if (nil == _collectionView) {
        
        CPCollectionViewLayout *flowlayout = [[CPCollectionViewLayout alloc] init];
        CGFloat width = SCREENWIDTH / 4;
        CGFloat height = width;
        
        flowlayout.itemSize                = CGSizeMake(width,height);
        flowlayout.minimumLineSpacing      = 0;
        flowlayout.minimumInteritemSpacing = 0;
        
        CGRect frame = CGRectMake(0, 100, SCREENWIDTH, 3 * height + 2);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowlayout];
        _collectionView.delegate      = self;
        _collectionView.dataSource    = self;
        _collectionView.backgroundColor = UIColor.whiteColor;
        
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.tabbarView.mas_bottom).offset(8);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
    }
    
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {return 1;}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {return self.contentModels.count;}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {return CGSizeMake(0, 0);}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {return CGSizeMake(0, 0);};
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CPImageTitleUpDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentify forIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColor.whiteColor;

    CPRecycleQuotePriceDetailModel *model = self.contentModels[indexPath.row];
    
    [cell updateImage:model.imageurl title:model.name];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CPRecycleQuotePriceDetailModel *model = self.contentModels[indexPath.row];
    
    [self loadContentDetail:model.ID];

}

#pragma mark - private method implement
- (void)loadData {
    
    __weak typeof(self) weakSelf = self;

    if (1 == self.type) {

        [CPRecycleQuotePriceDetailModel modelRequestWith:DOMAIN_ADDRESS@"/api/Checkinfo/findCheckList"
                                              parameters:@{@"typeid" : @"4"}
                                                   block:^(id result) {
                                                       [weakSelf handleLoadContentBlock:result];
                                                   } fail:^(CPError *error) {
                                                       
                                                   }];
    } else {
        [CPRecycleQuotePriceModel modelRequestWith:DOMAIN_ADDRESS@"/api/Checkinfo/findCheckType"
                                        parameters:@{@"typecfg" : @"0"}
                                             block:^(id result) {
                                                 [weakSelf handleLoadDataBlock:result];
                                             } fail:^(CPError *error) {
                                                 
                                             }];
    }
}
- (void)handleLoadDataBlock:(NSArray <CPRecycleQuotePriceModel *>*)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        return;
    }
    
    self.typeModels = result;
    
    self.tabbarView.dataArray = [self.typeModels valueForKeyPath:@"name"];
    
    [self loadContentAt:0];
}


- (void)loadContentAt:(NSUInteger)index {
    
    __weak typeof(self) weakSelf = self;
    
    CPRecycleQuotePriceModel *quotePriceModel = self.typeModels[index];
    
    [CPRecycleQuotePriceDetailModel modelRequestWith:DOMAIN_ADDRESS@"/api/Checkinfo/findCheckList"
                                          parameters:@{@"typeid" : quotePriceModel.ID}
                                               block:^(id result) {
                                                   [weakSelf handleLoadContentBlock:result];
                                               } fail:^(CPError *error) {
                                                   
                                               }];
    
}

- (void)handleLoadContentBlock:(NSArray <CPRecycleQuotePriceDetailModel *> *)resuslt {
    if (!resuslt || ![resuslt isKindOfClass:[NSArray class]]) {
        return;
    }
    
    NSMutableArray *tempArray = @[].mutableCopy;
    for (NSInteger i = 0; i < 20; ++i) {
        [tempArray addObjectsFromArray:resuslt.copy];
    }

    self.contentModels = tempArray;
    
    self.contentModels = resuslt;
    
    [self.collectionView reloadData];

}


/**
 获取相关信息详情

 @param detailID 详情ID
 */
- (void)loadContentDetail:(NSString *)detailID {
    
    __weak typeof(self) weakSelf = self;
    
    [CPRecycleQuotePriceDetailModel modelRequestWith:DOMAIN_ADDRESS@"/api/Checkinfo/getCheckInfo"
                                          parameters:@{@"id":detailID}
                                               block:^(id result) {
                                                   [weakSelf handleLoadContentDetailBlock:result];
                                               } fail:^(CPError *error) {
                                                   
                                               }];
}

- (void)handleLoadContentDetailBlock:(CPRecycleQuotePriceDetailModel *)result {
    if (!result || ![result isKindOfClass:[CPRecycleQuotePriceDetailModel class]]) {
        return;
    }
    
    CPWebVC *webVC = [[CPWebVC alloc] init];
    webVC.title                    = result.name;
    webVC.urlStr                   = result.Description;
    webVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
