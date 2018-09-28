//
//  CPTypeGoodTypeView.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/26.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPTypeGoodTypeView.h"

@implementation CPTypeGoodTypeView {
    UIButton *phoneBT, *padBT;
    CALayer *bottomLineLayer;
}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = MainColor;
    
    if (nil == phoneBT) {
        phoneBT = [UIButton new];
        phoneBT.titleLabel.font = CPFont_M;
        phoneBT.tag = 9527;
        
        [phoneBT setTitle:@"手机" forState:0];
        [phoneBT setTitleColor:C33 forState:0];
        [phoneBT addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:phoneBT];
        
        [phoneBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(100.0f);
        }];
    }
    
    if (nil == padBT) {
        padBT = [UIButton new];
        padBT.titleLabel.font = CPFont_M;
        padBT.tag = 9528;
        
        [padBT setTitle:@"平板电脑" forState:0];
        [padBT setTitleColor:C33 forState:0];
        [padBT addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:padBT];
        
        [padBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(phoneBT.mas_right);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(100.0f);
        }];
    }
    
    if (nil == bottomLineLayer) {
        bottomLineLayer = [CALayer layer];
        bottomLineLayer.frame = CGRectMake(0, self.bounds.size.height - 2, 100.0f, 2.0f);
        bottomLineLayer.backgroundColor =  MainColor.CGColor;
        
        [self.layer insertSublayer:bottomLineLayer atIndex:0];
    }
}

- (void)buttonAction:(UIButton *)sender {
    switch (sender.tag) {
        case 9527:
        {
           bottomLineLayer.frame = CGRectMake(0, self.bounds.size.height - 2, 100.0f, 2.0f);
        }
            break;
        case 9528:
        {
            bottomLineLayer.frame = CGRectMake(100, self.bounds.size.height - 2, 100.0f, 2.0f);
        }
            break;
        default:
            break;
    }
}

@end
