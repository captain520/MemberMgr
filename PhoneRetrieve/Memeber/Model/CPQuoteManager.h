//
//  CPQuoteManager.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/21.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPFlowModel.h"

@interface CPQuoteManager : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, strong) NSMutableArray <CPFlowModel *> *flows;
@property (nonatomic, strong) NSArray <CPFlowModel *> *firstFlows;
@property (nonatomic, assign) NSUInteger flowIndex;
@property (nonatomic, strong) CPFlowModel *currentFlowModel ;

- (void)log;

- (BOOL)canPush;
@end
