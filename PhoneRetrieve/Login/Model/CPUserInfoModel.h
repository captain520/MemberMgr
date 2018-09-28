//
//  CPUserInfoModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPLoginModel.h"
#import "CPCustomerHelpModel.h"
#import "CPUserDetailInfoModel.h"

@interface CPUserInfoModel : NSObject

@property (nonatomic, assign) BOOL isLogined;

@property (nonatomic, strong) CPLoginModel *loginModel;
@property (nonatomic, strong) CPUserDetailInfoModel *userDetaiInfoModel;

@property (nonatomic, strong) CPCustomerHelpModel *customerHelpModel;
@property (nonatomic, copy) NSString *helpHtml;

+ (instancetype)shareInstance;

@property (nonatomic, assign) BOOL isShop;

@property (nonatomic, copy) NSString *operationDes;

@property (nonatomic, copy) NSString *repaircfg;

@property (nonatomic, copy) NSString *push_token;

@end
