//
//  CPQuoteManager.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/21.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPQuoteManager.h"

@implementation CPQuoteManager

+ (instancetype)shareInstance {
    static CPQuoteManager *obj;
    static dispatch_once_t once;
    
    if (nil == obj) {
        dispatch_once(&once, ^{
            obj = [[CPQuoteManager alloc] init];
            obj.flows = @[].mutableCopy;
        });
    }
    
    return obj;
}

- (void)log {
    
    [self.flows enumerateObjectsUsingBlock:^(CPFlowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        DDLogInfo(@"%@",obj.name);
        
        [obj.itemData enumerateObjectsUsingBlock:^(CPItemData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DDLogInfo(@"      %@ %@",obj.name,obj.isSelected ? @"✅": @"");
        }];
        
    }];
}

- (CPFlowModel *)currentFlowModel {
    return self.flows[self.flowIndex];
}

- (BOOL)canPush {
    return self.flowIndex < self.flows.count;
}

@end
