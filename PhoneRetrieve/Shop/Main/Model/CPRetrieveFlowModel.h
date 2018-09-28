//
//  CPRetrieveFlowModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/14.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@class Featureproperties,Pricepropertyvalues,Appearanceproperties,Skuproperties;
@interface CPRetrieveFlowModel : CPBaseModel

@property (nonatomic, strong) NSArray<Skuproperties *> *skuProperties;

@property (nonatomic, strong) NSArray *possibleSkuCombinations;

@property (nonatomic, strong) NSArray<Appearanceproperties *> *appearanceProperties;

@property (nonatomic, strong) NSArray<Featureproperties *> *featureProperties;

@property (nonatomic, assign) NSInteger stepCount;

@end

@interface Featureproperties : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSArray *imgs;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *tags;

@property (nonatomic, strong) NSArray<Pricepropertyvalues *> *pricePropertyValues;

@end


@interface Appearanceproperties : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSArray<NSString *> *imgs;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *tags;

@property (nonatomic, strong) NSArray<Pricepropertyvalues *> *pricePropertyValues;

@end


@interface Skuproperties : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSArray<NSString *> *imgs;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *tags;

@property (nonatomic, strong) NSArray<Pricepropertyvalues *> *pricePropertyValues;

@end


@interface Pricepropertyvalues : NSObject

@property (nonatomic, assign) BOOL isPreferred;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *value;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSArray<NSString *> *imgs;

@end
