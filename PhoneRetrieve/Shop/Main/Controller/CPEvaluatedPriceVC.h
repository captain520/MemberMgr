//
//  CPEvaluatedPriceVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseTableVC.h"
#import "CPRetrievePriceModel.h"

@interface CPEvaluatedPriceVC : CPBaseTableVC

@property (nonatomic, strong) CPRetrievePriceModel *model;

@property (nonatomic, strong) NSArray <NSDictionary *> *itemDicts;

@property (nonatomic, copy) void (^revalueActionBlock)(void);

@end
