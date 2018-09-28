//
//  CPHelpListModel.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/21.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPHelpListModel.h"

@implementation CPHelpListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id",@"Description" : @"description"};
}

@end


