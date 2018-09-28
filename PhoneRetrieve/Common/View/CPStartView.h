//
//  ZZStartView.h
//  ZhiZaiDemo
//
//  Created by wangzhangchuan on 2017/11/21.
//  Copyright © 2017年 wangzhangchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPStartView : UIView

@property (nonatomic, copy) void (^actionBlock)(CGFloat rate);

@end
