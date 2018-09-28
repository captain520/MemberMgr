//
//  CPRetrieveFlowModel.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/14.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRetrieveFlowModel.h"

@implementation CPRetrieveFlowModel

+ (NSDictionary *)objectClassInArray{
    return @{@"featureProperties" : [Featureproperties class], @"appearanceProperties" : [Appearanceproperties class], @"skuProperties" : [Skuproperties class]};
}

- (NSInteger)stepCount {
    return self.skuProperties.count + self.appearanceProperties.count;
}

@end


@implementation Featureproperties

+ (NSDictionary *)objectClassInArray{
    return @{@"pricePropertyValues" : [Pricepropertyvalues class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

@end



@implementation Appearanceproperties

+ (NSDictionary *)objectClassInArray{
    return @{@"pricePropertyValues" : [Pricepropertyvalues class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

@end



@implementation Skuproperties

+ (NSDictionary *)objectClassInArray{
    return @{@"pricePropertyValues" : [Pricepropertyvalues class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

@end


@implementation Pricepropertyvalues

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

@end


