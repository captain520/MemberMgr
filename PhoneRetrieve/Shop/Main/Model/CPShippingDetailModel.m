//
//  CPShippingDetailModel.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/23.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShippingDetailModel.h"

@implementation CPShippingDetailModel

+ (NSDictionary *)objectClassInArray{
    return @{@"cpdata" : [ShippingDetailData class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id",@"Description": @"description",@"cpdata" : @"data"};
}

@end

@implementation ShippingDetailData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Typename" : @"typename"};
}

@end


