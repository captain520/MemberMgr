//
//  CPConsignDetailVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseTableVC.h"
#import "CPCartModel.h"

@interface CPConsignDetailVC : CPBaseTableVC

@property (nonatomic, strong) NSArray <CPCartModel *> *selectedModels;

@end
