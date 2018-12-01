//
//  ZCRejectReasonCV.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/11/16.
//  Copyright © 2018 Captain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSRejectReasonModel.h"

@interface ZCRejectReasonCV : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray <MSRejectReasonModel *> *dataArray;

@end
