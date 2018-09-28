//
//  CPCollectionView.h
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/10.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPCollectionView : UICollectionView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end
