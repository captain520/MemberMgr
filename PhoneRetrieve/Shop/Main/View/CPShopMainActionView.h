//
//  CPShopMainActionView.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/6.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPView.h"

typedef NS_ENUM(NSUInteger, CPMainActionType){
  CPMainActionTypePhoneRetrieve = 9527,
  CPMainActionTypePadRetrieve,
  CPMainActionTypeRetrieveCart,
  CPMainActionTypeAssistantManger,
  CPMainActionTypeRetrieveFlow,
  CPMainActionTypeRetrieveAbout,
  CPMainActionTypeOther,
};

@interface CPShopMainActionView : CPView

@property (nonatomic, assign) CPMainActionType actionType;
@property (nonatomic, copy) void (^actionBlock)(CPMainActionType actionType);

@end
