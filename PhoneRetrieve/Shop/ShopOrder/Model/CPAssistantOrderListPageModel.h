//
//  CPAssistantOrderListPageModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/31.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"
#import "CPAssistanteOrderDetailModel.h"

@interface CPAssistantOrderListPageModel : CPBaseModel

@property (nonatomic, strong) NSArray<CPAssistanteOrderDetailModel *> *cp_data;

@property (nonatomic, assign) NSInteger totalprice;

@end
