//
//  CPUserDetailInfoModel.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/25.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPUserDetailInfoModel.h"

@implementation CPUserDetailInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id",@"Typeid" : @"typeid",@"cpcode" : @"code"};
}

@end


