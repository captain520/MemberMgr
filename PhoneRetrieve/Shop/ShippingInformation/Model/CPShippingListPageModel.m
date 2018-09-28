//
//  CPShippingListPageModel.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/31.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShippingListPageModel.h"

@implementation CPShippingListPageModel

+ (NSDictionary *)objectClassInArray{
    return @{@"cp_data" : [CPShopOrderDetailModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"cp_data" : @"data"};
}
@end
