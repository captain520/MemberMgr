//
//  CPLoginModel.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPLoginModel.h"

@implementation CPLoginModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id", @"Typeid" : @"typeid",@"cp_code":@"code"};
}

@end


