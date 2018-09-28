//
//  CPBrandModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/8.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@interface CPBrandModel : CPBaseModel


@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *iconurl;

@end

