//
//  CPMemberQuoteManager.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/10.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemberQuoteManager.h"

@implementation CPMemberQuoteManager

+ (instancetype)shareInstance {
    static CPMemberQuoteManager *obj;
    static dispatch_once_t once;

    if (nil == obj) {
        dispatch_once(&once, ^{
            obj = [[CPMemberQuoteManager alloc] init];
            obj.singlebQuoteFlowDataDict = @{}.mutableCopy;
            obj.mutipleQuoteFlowDataDict = @{}.mutableCopy;
            obj.flows = @[].mutableCopy;
        });
    }
    
    return obj;
}

- (void)log {
    
    [self.flows enumerateObjectsUsingBlock:^(CPFlowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        DDLogInfo(@"%@",obj.name);
        
        [obj.itemData enumerateObjectsUsingBlock:^(CPItemData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DDLogInfo(@"      %@",obj.name);
        }];

    }];
}

- (void)push{
    self.flowIndex++;
}

- (void)pop {
    self.flowIndex--;
}

- (CPFlowModel *)currentFlowModel {
    return self.flows[self.flowIndex];
}

- (BOOL)canPush {
    return self.flowIndex < self.flows.count;
}

@end
