//
//  CPOrderActionView.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPView.h"

@interface CPOrderActionView : CPView

@property (nonatomic, copy) void (^actionBlock)(void);

@property (nonatomic, strong) NSString *amount;

@property (nonatomic, strong) UIButton *selecteAllBT;
@property (nonatomic, assign) NSInteger capacity;

@end
