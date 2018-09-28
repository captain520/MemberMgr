//
//  CPCollectionView.m
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/10.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "CPCollectionView.h"
#import "CPImageCell.h"

NSString *identifier = @"CPImageCell";

@implementation CPCollectionView

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self initializedBaseProperties];
    }
    
    return self;
}

- (void)initializedBaseProperties {
    
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = UIColor.whiteColor;
    
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
}

#pragma mark - Deleaget && Datasource method

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
//    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(80, 80);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s",__FUNCTION__);
    
    [collectionView reloadData];
}

#pragma mark - Setter && Getter method
- (void)setDataArray:(NSArray *)dataArray {
    
    _dataArray = dataArray.mutableCopy;
    
    [self reloadData];
}

#pragma mark - Private method

@end
