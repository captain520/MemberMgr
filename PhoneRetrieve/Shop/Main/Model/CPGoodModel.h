//
//  CPGoodModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/8.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@interface CPGoodModel : CPBaseModel

@property (nonatomic, assign) NSInteger Typeid;

@property (nonatomic, copy) NSString *Typename;

@property (nonatomic, copy) NSString *iconurl;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, assign) NSInteger brandid;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *brandname;

@property (nonatomic, copy) NSString *goodsname;

@end

