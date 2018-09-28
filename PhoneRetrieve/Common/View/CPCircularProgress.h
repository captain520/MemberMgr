//
//  CPCircularProgress.h
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/19.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPCircularProgress : UIView

@property (nonatomic,assign) CGFloat progress;
@property (nonatomic,copy) NSString *title;

@property (nonatomic, copy) void (^fiinishBlock)(void);

@end
