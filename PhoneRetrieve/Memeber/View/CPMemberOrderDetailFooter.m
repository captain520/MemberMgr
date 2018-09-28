//
//  CPMemberOrderDetailFooter.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemberOrderDetailFooter.h"

@implementation CPMemberOrderDetailFooter {
    CPLabel *banlanceStateLB, *payableLB, *actualPayLB;
    
    CPButton *checkReportBT;
}

- (void)setupUI {
    
    //  余额提示
    CPLabel *hintLB = [CPLabel new];
    hintLB.text = @"余额";
    
    [self.contentView addSubview:hintLB];
    [hintLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(cellSpaceOffset);
    }];

    //    支付状态
    banlanceStateLB = [CPLabel new];
    banlanceStateLB.text = @"已支付";
    banlanceStateLB.textColor = UIColor.redColor;
    [self.contentView addSubview:banlanceStateLB];
    [banlanceStateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hintLB.mas_top);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.height.mas_equalTo(hintLB.mas_height);
    }];
    
    
    //  分割线
    {
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;
        
        [self.contentView addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(hintLB.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(.5);
        }];
        
        checkReportBT = [CPButton new];
        [self.contentView addSubview:checkReportBT];
        [checkReportBT setTitle:@"验机报告" forState:0];
        [checkReportBT addTarget:self action:@selector(checkReportAction:) forControlEvents:64];
        [checkReportBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(sepLine.mas_bottom).offset(8);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.width.mas_equalTo(100);
            make.bottom.mas_equalTo(-8);
        }];
    }

    
    //    应付余额
    payableLB = [CPLabel new];
    payableLB.text = @"应付余额：1233";
    [self.contentView addSubview:payableLB];
    [payableLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hintLB.mas_bottom);
        make.left.mas_equalTo(cellSpaceOffset);
        make.height.mas_equalTo(hintLB.mas_height).multipliedBy(0.8);
    }];
    
    //    应付余额
    actualPayLB = [CPLabel new];
    actualPayLB.text = @"实付余额：1233";
    actualPayLB.textColor = UIColor.redColor;
    [self.contentView addSubview:actualPayLB];
    [actualPayLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(payableLB.mas_bottom);
        make.left.mas_equalTo(cellSpaceOffset);
        make.height.mas_equalTo(hintLB.mas_height).multipliedBy(0.8);
        make.bottom.mas_equalTo(0);
    }];
    
    {
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
    
}

- (void)checkReportAction:(id)sender {
    !self.checkReportAction ? : self.checkReportAction();
}

- (void)setModel:(CPMemberOrderDetailModel *)model {
    _model = model;
    
    payableLB.text = [NSString stringWithFormat:@"应付余额：%.2f",model.yfprice.floatValue];
    actualPayLB.text = [NSString stringWithFormat:@"实付余额：%.2f",model.sfprice.floatValue];
    banlanceStateLB.text = model.yfpaycfg ? @"已支付" : @"未支付";
    banlanceStateLB.textColor = model.yfpaycfg ? MainColor : CPERROR_COLOR;
}

@end
