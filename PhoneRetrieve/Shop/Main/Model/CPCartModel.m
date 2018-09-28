//
//  CPCartModel.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/22.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPCartModel.h"

@implementation CPCartModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id",
             @"Typename" : @"typename"
             };
}

@end


