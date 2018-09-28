//
//  CPMemeberListModel.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/24.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemeberListModel.h"

@implementation CPMemeberListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id",@"Code":@"code"};
}

@end


