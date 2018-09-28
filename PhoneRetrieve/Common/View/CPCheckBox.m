//
//  CPCheckBox.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPCheckBox.h"

@implementation CPCheckBox {
    UIButton *checkIV;
    
    UIButton *contentLB;
}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    if (nil == checkIV) {
        checkIV = [UIButton new];
        checkIV.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        checkIV.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [checkIV setImage:CPImage(@"selected") forState:UIControlStateSelected];
        [checkIV setImage:CPImage(@"unselected") forState:UIControlStateNormal];
//        [checkIV setImage:CPImage(@"Tick_preseed") forState:UIControlStateSelected];
//        [checkIV setImage:CPImage(@"Tick_default") forState:UIControlStateNormal];
        [checkIV setTitle:@" 同意" forState:0];
        [checkIV setTitleColor:C33 forState:0];
        [checkIV addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:checkIV];
        
        [checkIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(checkIV.mas_height);
        }];
    }
    
    if (nil == contentLB) {
        
        contentLB = [UIButton new];
        [contentLB addTarget:self action:@selector(showProtocolView) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:contentLB];

        [contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(checkIV.mas_right).offset(cellSpaceOffset / 2);
            make.centerY.mas_equalTo(checkIV.mas_centerY);
        }];
    }
}

- (void)buttonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    !self.actionBlock ? : self.actionBlock(sender.isSelected);
}

- (void)setContent:(NSAttributedString *)content {
    
    _content = content;
    
    [contentLB setAttributedTitle:content forState:0];
}

- (void)showProtocolView {
    NSLog(@"-----");
    !self.showHintBlock ? : self.showHintBlock();
    
}


@end
