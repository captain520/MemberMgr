//
//  CPGoodOrderListVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/1.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseTableVC.h"
#import "CPAssistantOrderListPageModel.h"

typedef NS_ENUM(NSUInteger,CPGoodOrderListType) {
    CPGoodOrderListTypePlatformCommitOrder,   // 平台提交订单查询
    CPGoodOrderListTypeCartOverDueOrder,      //  回收车失效订单查询
    CPGoodOrderListTypeShopRetrieveOrder,     //  门店回收订单查询
    CPGoodOrderListTypeOther                  //  预留
};

@interface CPGoodOrderListVC : CPBaseTableVC

@property (nonatomic, assign) CPGoodOrderListType goodOrderListType;

@property (nonatomic, strong) CPAssistantOrderListPageModel *result;

@end
