//
//  CPGuaranteeListVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/26.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseTableVC.h"
#import "CPRetrieveFlowModel.h"

@interface CPGuaranteeListVC : CPBaseTableVC

@property (nonatomic, strong) CPRetrieveFlowModel *model;
@property (nonatomic, assign) NSInteger currentStep;

@end
