//
//  ZCRejectReasonCV.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/11/16.
//  Copyright © 2018 Captain. All rights reserved.
//

#import "ZCRejectReasonCV.h"

@implementation ZCRejectReasonCV

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        [self initailizeBaseProperties];
        [self setupUI];

    }
    
    return self;
}

#pragma mark - Initialized properties
- (void)initailizeBaseProperties {
    self.delegate = self;
    self.dataSource = self;
    self.allowsMultipleSelection = YES;
    self.backgroundColor = UIColor.whiteColor;
}
#pragma mark - setter && getter method
#pragma mark - Setup UI
- (void)setupUI {
    
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}
#pragma mark - Delegate && dataSource method implement
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(60, 30);
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIView *selectedBGView = [UIView new];
    selectedBGView.backgroundColor = MainColor;
    cell.selectedBackgroundView = selectedBGView;

    cell.layer.cornerRadius = 5;
    cell.layer.borderColor = CPBoardColor.CGColor;
    cell.layer.borderWidth = .5;
    cell.clipsToBounds = YES;
    
    CPLabel *titleLB = [cell.contentView viewWithTag:1001];
    if (titleLB == nil) {
        titleLB = [[CPLabel alloc] initWithFrame:cell.bounds];
        titleLB.tag = 1001;
        titleLB.textColor = C33;
        titleLB.textAlignment = NSTextAlignmentCenter;
        titleLB.font = [UIFont systemFontOfSize:11];
        [cell.contentView addSubview:titleLB];
    }
    
    MSRejectReasonModel *model = self.dataArray[indexPath.row];
    titleLB.text = model.name;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DDLogInfo(@"%s",__FUNCTION__);
}

#pragma mark - load data
- (void)loadData {
    
}

#pragma mark - Private method implement


@end
