//
//  CPCircularProgress.m
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/19.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "CPCircularProgress.h"
#import <DACircularProgressView.h>

@implementation CPCircularProgress {
    
    UIView *bgView;
    DACircularProgressView *pv;
    
    UILabel *percentLB;
    UILabel *titleLB;
}

+ (instancetype)shareInstance {
    
    CPCircularProgress *obj = [CPCircularProgress new];
    
    [obj setupUI];
    
    return obj;
}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    if (nil == bgView) {
        bgView = [UIView new];
        bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        bgView.layer.cornerRadius = 10.0f;

        [self addSubview:bgView];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self).offset(10);
            make.size.mas_equalTo(CGSizeMake(280, 180));
        }];
    }
    
    if (nil == pv) {
        pv = [DACircularProgressView new];
        pv.progressTintColor = MainColor;
        pv.trackTintColor = UIColor.greenColor;

        [self addSubview:pv];
        
        [pv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
    }
    
    if (nil == percentLB) {
        percentLB = [UILabel new];
        percentLB.text = @"0%";
        
        [self addSubview:percentLB];
        
        [percentLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(pv);
        }];
    }
    
    if (nil == titleLB) {
        titleLB = [UILabel new];
        titleLB.textAlignment = NSTextAlignmentCenter;
        titleLB.text = @"数据提交中...";
        
        [self addSubview:titleLB];
        
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(pv.mas_bottom).offset(8);
            make.centerX.mas_equalTo(pv.mas_centerX);
        }];
    }
}

- (void)setProgress:(CGFloat)progress {
    
    [pv setProgress:progress animated:YES];
    
    percentLB.text = [NSString stringWithFormat:@"%ld%%",(NSInteger)(progress * 100)];
    
    if (progress >= 0.99) {
        
        !self.fiinishBlock ? : self.fiinishBlock();
        
        [self removeFromSuperview];
    }
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    titleLB.text = _title;
}

@end
