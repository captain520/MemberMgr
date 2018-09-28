//
//  CPShippingListCell.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseCell.h"
#import "CPShopOrderDetailModel.h"

@interface CPShippingListCell : CPBaseCell

@property (nonatomic, strong) CPShopOrderDetailModel *model;
@property (nonatomic, strong) CPShopOrderDetailModel *logistModel;


@end
