//
//  CPUserInfoModel.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPUserInfoModel.h"

@implementation CPUserInfoModel

+ (instancetype)shareInstance {
    static CPUserInfoModel *obj;
    static dispatch_once_t once;
    
    if (nil == obj) {
        dispatch_once(&once, ^{
            obj = [[CPUserInfoModel alloc] init];
            obj.isShop = YES;
        });
    }
    
    return obj;
}

@end
