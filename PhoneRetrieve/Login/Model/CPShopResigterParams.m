//
//  CPShopResigterParams.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/25.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopResigterParams.h"

@implementation CPShopResigterParams

+ (instancetype)shareInstance {
    static CPShopResigterParams *obj;
    static dispatch_once_t once;
    
    if (nil == obj) {
        dispatch_once(&once, ^{
            obj = [[CPShopResigterParams alloc] init];
        });
    }
    
    return obj;
}

@end
