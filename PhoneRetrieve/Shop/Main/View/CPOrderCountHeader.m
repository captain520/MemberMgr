//
//  CPOrderCountHeader.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPOrderCountHeader.h"

@implementation CPOrderCountHeader {
    CPLabel *contentLB;
}

- (void)setupUI {
    
    contentLB = [CPLabel new];
    contentLB.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:contentLB];
    
    [contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.bottom.mas_equalTo(0);
    }];
    
    UIView *sepLine = [UIView new];
    sepLine.backgroundColor = CPBoardColor;
    
    [self.contentView addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(.5);
    }];
}


- (void)setAmount:(CGFloat)amount {
    
    _amount = amount;
    
    if (IS_MEMBER_ACCOUNT) {
        contentLB.text = [NSString stringWithFormat:@"总共%.0f件商品",_count];
    } else {
        contentLB.text = [NSString stringWithFormat:@"总共%.0f件商品，共计¥%.2f",_count,_amount];
    }
}

- (void)setCount:(CGFloat)count {
    
    _count = count;
    
    if (IS_MEMBER_ACCOUNT) {
        contentLB.text = [NSString stringWithFormat:@"总共%.0f件商品，共计¥%.2f",_count,_amount];
    } else {
        contentLB.text = [NSString stringWithFormat:@"总共%.0f件商品，共计¥%.2f",_count,_amount];
    }
}

@end
