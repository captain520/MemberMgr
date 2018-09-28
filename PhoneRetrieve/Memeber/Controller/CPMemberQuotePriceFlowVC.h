//
//  CPMemberQuotePriceFlowVC.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/10.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseTableVC.h"
#import "CPFlowModel.h"

@interface CPMemberQuotePriceFlowVC : CPBaseTableVC


/**
 * 当前的主流程执行的步骤
 */
@property (nonatomic,assign) NSUInteger currentMainStep;


/**
 * 当前步骤相关Model
 */
@property (nonatomic, strong) CPFlowModel *currentMainModel;

@end
