//
//  CPTestModel.h
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/8.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "CPBaseModel.h"

@interface CPTestModel : CPBaseModel

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *regionName;

@property (nonatomic, assign) NSInteger parentId;

@property (nonatomic, assign) NSInteger regionType;

@property (nonatomic, assign) long long lastTime;

@end

