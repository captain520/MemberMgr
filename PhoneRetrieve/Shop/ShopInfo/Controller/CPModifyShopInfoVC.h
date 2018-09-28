//
//  CPModifyShopInfoVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseVC.h"

typedef NS_ENUM(NSUInteger, CPModifyShopInfoType) {
   CPModifyShopInfoTypeModifyShopInfo,
   CPModifyShopInfoTypeModifyBankAccount,
   CPModifyShopInfoTypeModifyAlipayAccount,
   CPModifyShopInfoTypeModifyWechatAccount
};

@interface CPModifyShopInfoVC : CPBaseVC

@property (nonatomic, assign) CPModifyShopInfoType type;

@end
