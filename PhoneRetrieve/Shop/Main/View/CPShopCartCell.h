//
//  CPShopCartCell.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseCell.h"
#import "CPCartModel.h"

@interface CPShopCartCell : CPBaseCell

@property (nonatomic, assign) BOOL hasSelected;
@property (nonatomic, assign) BOOL canEdit;

@property (nonatomic, strong) CPCartModel *model;

@property (nonatomic, copy) void (^actionBlock)(void);

@end
