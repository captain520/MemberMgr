//
//  ZCOrdetailFooter.m
//  MemberManager
//
//  Created by 王璋传 on 2018/9/14.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCOrdetailFooter.h"

@implementation ZCOrdetailFooter {
    ZCLabel *banlanceStateLB, *payableLB, *actualPayLB;
    
    ZCButton *checkReportBT;
}

- (void)setupUI {
    
    //  余额提示
    ZCLabel *hintLB = [ZCLabel new];
    hintLB.text = @"余额";
    
    [self.contentView addSubview:hintLB];
    [hintLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(SPACE_OFFSET_F);
    }];
    
    //    支付状态
    banlanceStateLB = [ZCLabel new];
    banlanceStateLB.text = @"已支付";
    banlanceStateLB.textColor = UIColor.redColor;
    [self.contentView addSubview:banlanceStateLB];
    [banlanceStateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hintLB.mas_top);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
        make.height.mas_equalTo(hintLB.mas_height);
    }];
    
    
    //  分割线
    {
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = BorderColor;
        
        [self.contentView addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(hintLB.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(.5);
        }];
        
        checkReportBT = [ZCButton new];
        [self.contentView addSubview:checkReportBT];
        [checkReportBT setTitle:@"验机报告" forState:0];
        [checkReportBT addTarget:self action:@selector(checkReportAction:) forControlEvents:64];
        [checkReportBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(sepLine.mas_bottom).offset(8);
            make.right.mas_equalTo(-SPACE_OFFSET_F);
            make.width.mas_equalTo(100);
            make.bottom.mas_equalTo(-8);
        }];
    }
    
    
    //    应付余额
    payableLB = [ZCLabel new];
    payableLB.text = @"应付余额：1233";
    [self.contentView addSubview:payableLB];
    [payableLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hintLB.mas_bottom);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.height.mas_equalTo(hintLB.mas_height).multipliedBy(0.8);
    }];
    
    //    应付余额
    actualPayLB = [ZCLabel new];
    actualPayLB.text = @"实付余额：1233";
    actualPayLB.textColor = UIColor.redColor;
    [self.contentView addSubview:actualPayLB];
    [actualPayLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->payableLB.mas_bottom);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.height.mas_equalTo(hintLB.mas_height).multipliedBy(0.8);
        make.bottom.mas_equalTo(0);
    }];
    
    {
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = BorderColor;
        
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

@end
