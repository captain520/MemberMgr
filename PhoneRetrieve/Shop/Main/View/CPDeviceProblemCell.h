//
//  CPDeviceProblemCell.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/26.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseCell.h"
#import "CPRetrieveFlowModel.h"

@interface CPDeviceProblemCell : CPBaseCell

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL shouldHighted;

@property (nonatomic, strong) Pricepropertyvalues *model;

@end
