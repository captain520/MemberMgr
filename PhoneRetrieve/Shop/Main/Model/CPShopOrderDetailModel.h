//
//  CPShopOrderDetailModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/23.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@interface CPShopOrderDetailModel : CPBaseModel


@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *ordersn;

@property (nonatomic, assign) NSInteger agentid;

@property (nonatomic, copy) NSString *shopname;

@property (nonatomic, assign) CGFloat totalprice;

@property (nonatomic, copy) NSString *doorname;

@property (nonatomic, copy) NSString *agentname;

@property (nonatomic, assign) NSInteger finishcfg;

@property (nonatomic, assign) NSInteger shopid;

@property (nonatomic, copy) NSString *lossprice;

@property (nonatomic, assign) NSInteger doorid;

@property (nonatomic, assign) NSInteger goodscount;

@property (nonatomic, assign) BOOL paycfg;

@property (nonatomic, copy) NSString *logisticsno;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *paytime;

@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *ptprice;
@property (nonatomic, copy) NSString *yfprice;
@property (nonatomic, copy) NSString *sfprice;
@property (nonatomic, assign) BOOL yfpaycfg;


@end

