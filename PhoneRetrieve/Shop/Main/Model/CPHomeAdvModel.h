//
//  CPHomeAdvModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/8.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@interface CPHomeAdvModel : CPBaseModel

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *clickurl;

@property (nonatomic, assign) NSInteger typecfg;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *imageurl;

@end

