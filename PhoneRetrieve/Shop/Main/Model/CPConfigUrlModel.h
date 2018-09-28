//
//  CPConfigUrlModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/23.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@interface CPConfigUrlModel : CPBaseModel

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *Description;

@end

