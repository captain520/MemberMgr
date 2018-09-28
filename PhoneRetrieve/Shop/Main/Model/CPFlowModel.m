//
//  CPFlowModel.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/16.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPFlowModel.h"

@implementation CPFlowModel

+ (NSDictionary *)objectClassInArray{
    return @{@"itemData" : [CPItemData class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Description" : @"description",@"itemData" : @"data"};
}

- (NSArray <NSString *> *)images {
    
    if (!self.descriptionimageurls || self.descriptionimageurls.length == 0) {
        return nil;
    }
    return  [self.descriptionimageurls componentsSeparatedByString:@","];
}

@end


@implementation CPItemData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Description" : @"description"};
}

- (NSArray <NSString *> *)images {
    if (!self.descriptionimageurls || self.descriptionimageurls.length == 0) {
        return nil;
    }
    return  [self.descriptionimageurls componentsSeparatedByString:@","];
}

@end


