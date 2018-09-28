//
//  CPFlowModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/16.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@class CPItemData;
@interface CPFlowModel : CPBaseModel

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, assign) NSInteger screencfg;

@property (nonatomic, copy) NSString *reportid;

@property (nonatomic, assign) NSInteger repaircfg;

@property (nonatomic, copy) NSString *descriptionclickurl;

@property (nonatomic, assign) NSInteger brandid;

@property (nonatomic, assign) NSInteger templateid;

@property (nonatomic, copy) NSString *descriptionimageurls;

@property (nonatomic, copy) NSString *tips;

@property (nonatomic, strong) NSArray<CPItemData *> *itemData;

@property (nonatomic, assign) NSInteger goodsid;

@property (nonatomic, assign) NSInteger inputtype;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger typeid;

@property (nonatomic, strong, readonly) NSArray <NSString *> *images;

@property (nonatomic, copy) NSString *reportitemid;

@end

@interface CPItemData : NSObject

@property (nonatomic, copy) NSString *iconurl;

@property (nonatomic, copy) NSString *descriptionimageurls;

@property (nonatomic, copy) NSString *reportitemid;

@property (nonatomic, copy) NSString *reportid;

@property (nonatomic, copy) NSString *parentName;

@property (nonatomic, assign) NSInteger typecfg;

@property (nonatomic, copy) NSString *tips;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong, readonly) NSArray <NSString *> *images;

@property (nonatomic, assign) BOOL isSelected;

@end

