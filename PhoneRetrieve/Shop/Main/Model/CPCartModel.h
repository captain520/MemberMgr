//
//  CPCartModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/22.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@interface CPCartModel : CPBaseModel

@property (nonatomic, copy) NSString *Typename;

@property (nonatomic, copy) NSString *daleytime;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *goodsname;

@property (nonatomic, copy) NSString *goodsurl;

@property (nonatomic, copy) NSString *resultno;

@property (nonatomic, assign) NSInteger goodsid;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, copy) NSString *currentprice;


@end

