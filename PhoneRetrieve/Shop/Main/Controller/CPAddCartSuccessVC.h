//
//  CPAddCartSuccessVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseVC.h"
#import "CPRetrievePriceModel.h"
#import "CPShopShippingResultModel.h"

typedef NS_ENUM(NSUInteger, CPSucessType) {
   CPSucessTypeAddCart,
   CPSucessTypeSendGood
};

@interface CPAddCartSuccessVC : CPBaseVC

@property (nonatomic, assign) CPSucessType type;

@property (nonatomic, strong) CPRetrievePriceModel *model;
@property (nonatomic, strong) CPShopShippingResultModel *shipModel;

@end
