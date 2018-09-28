//
//  CPShippingDetailModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/23.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@class ShippingDetailData;
@interface CPShippingDetailModel : CPBaseModel

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *ordersn;

@property (nonatomic, assign) NSInteger agentid;

@property (nonatomic, assign) NSInteger doorid;

@property (nonatomic, copy) NSString *paytime;

@property (nonatomic, copy) NSString *totalprice;

@property (nonatomic, copy) NSString *lossprice;

@property (nonatomic, copy) NSString *logisticsno;

@property (nonatomic, assign) NSInteger finishcfg;

@property (nonatomic, assign) NSInteger shopid;

@property (nonatomic, copy) NSString *shopname;

@property (nonatomic, copy) NSString *logisticsimageurls;

@property (nonatomic, assign) NSInteger paycfg;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *logisticscompanyname;

@property (nonatomic, copy) NSString *agentname;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, copy) NSString *finishtime;

@property (nonatomic, strong) NSArray<ShippingDetailData *> *cpdata;

@property (nonatomic, copy) NSString *doorname;

@end

@interface ShippingDetailData : NSObject

@property (nonatomic, copy) NSString *ordersn;

@property (nonatomic, copy) NSString *Typename;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *goodsname;

@property (nonatomic, assign) NSInteger orderid;

@property (nonatomic, copy) NSString *goodsurl;

@property (nonatomic, copy) NSString *resultno;

@property (nonatomic, assign) NSInteger resultid;

@property (nonatomic, assign) NSInteger goodsid;

@property (nonatomic, copy) NSString *brandname;

@end

