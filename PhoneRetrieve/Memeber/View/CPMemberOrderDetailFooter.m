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
    
    CPButton *agreeBT, *rejectBT, *offLineBT;
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
        [checkReportBT setTitle:@"质检报告" forState:0];
        [checkReportBT addTarget:self action:@selector(checkReportAction:) forControlEvents:64];
        [checkReportBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(sepLine.mas_bottom).offset(8);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
        }];
    }

    
    //    应付余额
    payableLB = [CPLabel new];
    payableLB.text = @"应付余额：1233";
    [self.contentView addSubview:payableLB];
    [payableLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hintLB.mas_bottom).offset(4);
        make.left.mas_equalTo(cellSpaceOffset);
        make.height.mas_equalTo(hintLB.mas_height).multipliedBy(0.8);
    }];
    
    //    应付余额
    actualPayLB = [CPLabel new];
    actualPayLB.text = @"实付余额：1233";
    actualPayLB.textColor = UIColor.redColor;
    [self.contentView addSubview:actualPayLB];
    [actualPayLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(payableLB.mas_bottom).offset(4);
        make.left.mas_equalTo(cellSpaceOffset);
        make.height.mas_equalTo(hintLB.mas_height).multipliedBy(0.8);
    }];
    
    {
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;
        
        [self.contentView addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(actualPayLB.mas_bottom).offset(4);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(.5);
        }];
    }
    
    {
        CPLabel *hintLB = [CPLabel new];
        hintLB.text = @"⚠️ 请认真查看质检报告后再进行下面操作!";
        hintLB.textColor = UIColor.redColor;

        [self.contentView addSubview:hintLB];
        [hintLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(actualPayLB.mas_bottom).offset(18);
            make.left.mas_equalTo(SPACE_OFFSET_F);
            make.right.mas_equalTo(0);
        }];
        
        agreeBT = [CPButton new];
        [agreeBT setTitle:@"同意成交" forState:0];
        [agreeBT addTarget:self action:@selector(agreeAction:) forControlEvents:64];
        [agreeBT setBackgroundImage:[UIImage imageWithColor:UIColor.blueColor] forState:0];
        
        [self.contentView addSubview:agreeBT];
        
        
        rejectBT = [CPButton new];
        [rejectBT setTitle:@"机器返回" forState:0];
        [rejectBT addTarget:self action:@selector(rejectAction:) forControlEvents:64];
        [rejectBT setBackgroundImage:[UIImage imageWithColor:CPERROR_COLOR] forState:0];
        
        [self.contentView addSubview:rejectBT];
        
        
        offLineBT = [CPButton new];
        [offLineBT setTitle:@"平台议价" forState:0];
        [offLineBT addTarget:self action:@selector(offLineAction:) forControlEvents:64];
        [offLineBT setBackgroundImage:[UIImage imageWithColor:FONT_GREEN] forState:0];
        
        [self.contentView addSubview:offLineBT];
        
        [agreeBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(hintLB.mas_bottom).offset(24);
            make.left.mas_equalTo(SPACE_OFFSET_F);
            make.height.mas_equalTo(30);
        }];
        
        [rejectBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(agreeBT.mas_top);
            make.left.mas_equalTo(agreeBT.mas_right).offset(SPACE_OFFSET_F);
            make.height.mas_equalTo(agreeBT.mas_height);
            make.width.mas_equalTo(agreeBT.mas_width);
        }];
        
        [offLineBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(agreeBT.mas_top);
            make.left.mas_equalTo(rejectBT.mas_right).offset(SPACE_OFFSET_F);
            make.right.mas_equalTo(-SPACE_OFFSET_F);
            make.height.mas_equalTo(agreeBT.mas_height);
            make.width.mas_equalTo(agreeBT.mas_width);
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

- (void)agreeAction:(id)sender {
    !self.agreeActionBlock ? : self.agreeActionBlock();
}

- (void)rejectAction:(id)sender {
    !self.rejectActionBlock ? : self.rejectActionBlock();
}

- (void)offLineAction:(id)sender {
    !self.offLineActionBlock ? : self.offLineActionBlock();
}

@end
