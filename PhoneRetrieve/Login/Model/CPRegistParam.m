//
//  CPRegistParam.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRegistParam.h"

@implementation CPRegistParam

+ (instancetype)shareInstance {
    static CPRegistParam *obj;
    static dispatch_once_t once;
    
    if (nil == obj) {
        dispatch_once(&once, ^{
            obj = [[CPRegistParam alloc] init];
        });
    }
    
    return obj;
}

@end
