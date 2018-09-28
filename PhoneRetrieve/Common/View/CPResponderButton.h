//
//  CPResponderButton.h
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/10.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPResponderButton : UIButton<UIKeyInput>

@property (nonatomic, strong) UIView *inputView;

@property (nonatomic, strong) UIView *inputAccessoryView;

@end
