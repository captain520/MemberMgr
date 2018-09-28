//
//  CPOrderListPageModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/31.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"
#import "CPShopOrderDetailModel.h"

@interface CPOrderListPageModel : CPBaseModel

@property (nonatomic, strong) NSArray<CPShopOrderDetailModel*> *cp_data;

@property (nonatomic, assign) NSInteger totalprice;

@end

