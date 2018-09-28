//
//  CPOrderSearchVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseVC.h"
#import "CPOrderListPageModel.h"

typedef NS_ENUM(NSUInteger,CPOrderSearchType) {
    CPOrderSearchTypeShippingOnWay,
    CPOrderSearchTypeShippingFinished,
    CPOrderSearchTypeOrder,
    CPOrderSearchTypeOther,
    CPOrderSearchTypeShopPaidOrder,
    CPOrderSearchTypeShopUnpaidOrder,
    CPOrderSearchTypeOverDueOrder,
    CPOrderSearchTypeOverFinishedOrder
};

@interface CPOrderSearchVC : CPBaseVC

@property (nonatomic, assign) CPOrderSearchType type;

@property (nonatomic, copy) void (^payFilterBlock)(id result);

@end
