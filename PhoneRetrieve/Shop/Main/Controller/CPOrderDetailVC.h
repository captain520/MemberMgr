//
//  CPOrderDetailVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseTableVC.h"
#import "CPRetrievePriceModel.h"

@interface CPOrderDetailVC : CPBaseTableVC

@property (nonatomic, strong) CPRetrievePriceModel *model;

@property (nonatomic, copy) NSString *orderID;

@end
