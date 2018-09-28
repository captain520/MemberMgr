//
//  CPRetrieveFlowProgressView.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/14.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRetrieveFlowProgressView.h"

@implementation CPRetrieveFlowProgressView {
    CALayer *stepLayer;
    CPLabel *percentLB;
}

- (void)setupUI {
    self.backgroundColor = UIColor.lightGrayColor;;
    
    stepLayer = [CALayer layer];
    stepLayer.frame = CGRectMake(0, 0, 0, self.frame.size.height);
    stepLayer.backgroundColor = MainColor.CGColor;//[UIColor yellowColor].CGColor;
    [self.layer insertSublayer:stepLayer atIndex:0];
    
    percentLB = [CPLabel new];
    percentLB.frame = CGRectMake(0, 0, 0, self.frame.size.height);
    [self addSubview:percentLB];
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;

    stepLayer.frame = CGRectMake(0, 0, SCREENWIDTH * _progress, self.frame.size.height);

    percentLB.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    [UIView animateWithDuration:0.15f animations:^{
        percentLB.frame = CGRectMake(SCREENWIDTH * progress - 30.0f, 0, SCREENWIDTH, self.frame.size.height);
    }];
}

@end
