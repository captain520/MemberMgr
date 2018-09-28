//
//  CPPostTestModel.h
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/8.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "CPBaseModel.h"

@interface CPPostTestModel : CPBaseModel

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *specId;

@property (nonatomic, assign) NSInteger productId;

@property (nonatomic, assign) NSInteger warehouseArea;

@property (nonatomic, assign) NSInteger stockWare;

@property (nonatomic, assign) NSInteger shopPrice;

@property (nonatomic, assign) long long lastTime;

@property (nonatomic, assign) NSInteger warehouseId;

@property (nonatomic, copy) NSString *memo;

@property (nonatomic, assign) NSInteger stock;

@property (nonatomic, copy) NSString *specName;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *makertPrice;

@property (nonatomic, copy) NSString *warehouseName;

@property (nonatomic, copy) NSString *stockMemo;

@property (nonatomic, assign) NSInteger sales;

@property (nonatomic, copy) NSString *warehouseAreaName;

@property (nonatomic, assign) NSInteger status;

@end

