//
//  CPOrderActionView.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPOrderActionView.h"

@implementation CPOrderActionView {
    
    CPLabel *hintLB, *priceLB;
    
    UIButton *nextActionBT;
}

- (void)setupUI {
    
    UIView *sepline = [UIView new];
    sepline.backgroundColor = CPBoardColor;
    [self addSubview:sepline];
    
    [sepline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(CPBoardWidth);
    }];
    
    {
        self.selecteAllBT = [UIButton new];
        self.selecteAllBT.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//        self.selecteAllBT.backgroundColor = UIColor.redColor;
        self.selecteAllBT.titleLabel.font = CPFont_S;
        [self.selecteAllBT setTitleColor:C33 forState:0];
        [self.selecteAllBT setImage:CPImage(@"Tick_default") forState:0];// Tick_default   Tick_preseed √
        [self.selecteAllBT setTitle:@"全选" forState:0];
        [self addSubview:self.selecteAllBT];
        [self.selecteAllBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(cellSpaceOffset);
            make.width.mas_equalTo(60);
            make.bottom.mas_equalTo(0);
        }];
        
    }

    hintLB = [CPLabel new];
    hintLB.text = @"总计:0项";
    if (IS_MEMBER_ACCOUNT) {
        hintLB.text = @"客户成交价合计:";
    }
    [self addSubview:hintLB];
    
    priceLB = [CPLabel new];
    priceLB.textColor = UIColor.redColor;
    priceLB.text = @"¥0.00";
    [self addSubview:priceLB];
    
    nextActionBT = [UIButton new];
    nextActionBT.backgroundColor = MainColor;
    [nextActionBT setTitle:@"立即发货" forState:0];
    [nextActionBT addTarget:self action:@selector(buttonAction:) forControlEvents:64];
    [self addSubview:nextActionBT];
    
    [hintLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(self.selecteAllBT.mas_right).offset(cellSpaceOffset);
        make.bottom.mas_equalTo(0);
    }];
    
    [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(hintLB.mas_right).offset(cellSpaceOffset/2);
        make.bottom.mas_equalTo(0);
    }];
    
    [nextActionBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(100.0f);
    }];
    
}

- (void)setAmount:(NSString *)amount {
    
    _amount = amount;
    
    priceLB.text = [NSString stringWithFormat:@"¥%@",_amount];
}

- (void)setCapacity:(NSInteger )capacity {
    _capacity = capacity;
    if (IS_MEMBER_ACCOUNT) {
        hintLB.text = @"客户成交价合计:";
    } else {
        hintLB.text = [NSString stringWithFormat:@"总计:%ld项",_capacity];
    }
}

- (void)buttonAction:(id)sender {
    !self.actionBlock ? : self.actionBlock();
}

@end
