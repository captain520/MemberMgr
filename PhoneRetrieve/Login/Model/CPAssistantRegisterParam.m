//
//  CPAssistantRegisterParam.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/6.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPAssistantRegisterParam.h"

@implementation CPAssistantRegisterParam

+ (instancetype)shareInstance {
    static CPAssistantRegisterParam *obj;
    static dispatch_once_t once;
    
    if (nil == obj) {
        dispatch_once(&once, ^{
            obj = [[CPAssistantRegisterParam alloc] init];
        });
    }
    
    return obj;
}

@end
