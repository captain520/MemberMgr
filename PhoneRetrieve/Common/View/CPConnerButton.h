//
//  CPConnerButton.h
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/8.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPConnerButton : UIButton

+ (instancetype)instance;

- (void)setupUI:(UIRectCorner )corner ;

@end
