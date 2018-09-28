//
//  CPMemberQuoteManager.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/10.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPFlowModel.h"

@interface CPMemberQuoteManager : NSObject


/**
 * 实例化单例
 *
 * @return 单例对象
 */
+ (instancetype)shareInstance;


/**
 * 评估主流程数据
 */
@property (nonatomic,strong) NSArray <CPFlowModel *> *mainQuoteFlowDataArray;


/**
 * 评估子流程数据,通过主流程的reportitemid获取子流程
 */
@property (nonatomic,strong) NSMutableDictionary <NSString *, id> *singlebQuoteFlowDataDict;
@property (nonatomic,strong) NSMutableDictionary <NSString *, id> *mutipleQuoteFlowDataDict;

@property (nonatomic,copy) NSString *goodsid;
@property (nonatomic,copy) NSString *deviceName;

@property (nonatomic, strong) NSMutableArray <CPFlowModel *> *flows;
@property (nonatomic, assign) NSUInteger flowIndex;

- (void)log;
- (void)push;
- (void)pop;

- (CPFlowModel *)currentFlowModel;

- (BOOL)canPush;

@end
