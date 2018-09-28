//
//  CPFlowCell.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/16.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseCell.h"
#import "CPFlowModel.h"

@interface CPFlowCell : CPBaseCell

- (void)cp_updateContent:(NSString *)titleValue detail:(NSString *)detailValue;
- (void)cp_updateContent:(NSString *)titleValue;

@property (nonatomic, strong) CPItemData *model;

@property (nonatomic, assign) BOOL shouldHighted;

@end
