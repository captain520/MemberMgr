//
//  CPAssistantOrderListPageModel.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/31.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPAssistantOrderListPageModel.h"

@implementation CPAssistantOrderListPageModel

+ (NSDictionary *)objectClassInArray{
    return @{@"cp_data" : [CPAssistanteOrderDetailModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"cp_data" : @"data"};
}

@end
