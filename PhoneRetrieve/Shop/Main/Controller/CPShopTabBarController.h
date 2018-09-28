//
//  CPShopTabBarController.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/6.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPTabBarController.h"

typedef NS_ENUM(NSUInteger,CPTabVCType) {
   CPTabVCTypeShop = 3,
   CPTabVCTypeAssistant = 4,
   CPTabVCTypeMemeber = 6,
   CPTabVCTypeSubMember = 7,
   CPTabVCTypeOther
};

@interface CPShopTabBarController : CPTabBarController

- (void)initializedBaseViewControllersFor:(CPTabVCType)type;

@end
