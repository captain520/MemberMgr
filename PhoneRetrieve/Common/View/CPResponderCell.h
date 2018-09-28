//
//  CPResponderCell.h
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/10.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "CPBaseCell.h"

@interface CPResponderCell : CPBaseCell<UIKeyInput>

@property (nonatomic, strong) UIView *inputView;
@property (nonatomic, strong) UIView *inputAccessoryView;

@end
