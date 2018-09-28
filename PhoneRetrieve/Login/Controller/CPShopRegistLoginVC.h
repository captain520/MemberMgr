//
//  CPShopRegistVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseVC.h"

typedef NS_ENUM(NSUInteger, CPRegistType) {
   CPRegistTypeShop,
   CPRegistTypeAssistant,
   CPRegistTypeMember,
   CPRegistTypeOther
};

@interface CPShopRegistLoginVC : CPBaseVC

@property (nonatomic, assign) CPRegistType registType;

@end
