//
//  CPShopGoodsListVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/26.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseTableVC.h"

@interface CPShopGoodsListVC : CPBaseTableVC

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, assign) NSInteger selecteTypeIndex;

- (void)push2QuoteFlow:(BOOL)animated ;

@end
