//
//  CPConnerButton.m
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/8.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "CPConnerButton.h"

@implementation CPConnerButton

+ (instancetype)instance {
    
    CPConnerButton *obj = CPConnerButton.new;

    return obj;
}

- (void)setupUI:(UIRectCorner )corner {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path        = path.CGPath;
    layer.lineWidth   = 1.0f;
    layer.strokeColor = UIColor.blueColor.CGColor;
    
    [self.layer addSublayer:layer];
}


@end
