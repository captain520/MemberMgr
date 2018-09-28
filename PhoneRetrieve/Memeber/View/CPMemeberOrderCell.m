//
//  CPMemeberOrderCell.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemeberOrderCell.h"

@implementation CPMemeberOrderCell {
    CPLabel *countLB, *customPriceLB, *platformPriceLB, *balanceLB, *finallyPriceLB,*dateLB, *logisticsLB;
    
    CPButton *logisticsCheckBT, *dealBT;
    
    CPLabel *customPriceStateLB, *finallyPriceStateLB;
}

- (void)setModel:(CPShopOrderDetailModel *)model {
    _model = model;
    
    countLB.text = [NSString stringWithFormat:@"商品数量：%@",@(model.goodscount)];
    customPriceLB.text = [NSString stringWithFormat:@"客户成交价：¥%.2f",model.totalprice];
    customPriceStateLB.text = [NSString stringWithFormat:@"(%@)",model.paycfg  ?  @"已支付" : @"未支付"];
    customPriceStateLB.textColor = model.paycfg ? MainColor : CPERROR_COLOR;
    
    balanceLB.text = [NSString stringWithFormat:@"应付余额：¥%.2f",model.yfprice.floatValue];
    platformPriceLB.text = [NSString stringWithFormat:@"平台回收价：¥%.2f",model.ptprice.floatValue];
    finallyPriceLB.text = [NSString stringWithFormat:@"实付余额：¥%.2f",model.sfprice.floatValue];
    finallyPriceStateLB.text = [NSString stringWithFormat:@"(%@)",model.yfpaycfg?  @"已支付" : @"未支付"];
    finallyPriceStateLB.textColor = model.yfpaycfg ? MainColor : CPERROR_COLOR;
    dateLB.text = [NSString stringWithFormat:@"交易时间：¥%@",model.createtime];
    logisticsLB.text = [NSString stringWithFormat:@"物流单号：%@",model.logisticsno];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupUI {
    
    countLB = [CPLabel new];
    countLB.text = [NSString stringWithFormat:@"商品数量：%@",@(0)];
    
    [self.contentView addSubview:countLB];
    [countLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(4);
        make.left.mas_equalTo(cellSpaceOffset);
    }];
    
    //   客户成交价
    customPriceLB = [CPLabel new];
    customPriceLB.text = [NSString stringWithFormat:@"客户成交价：¥%@",@(0)];
    
    [self.contentView addSubview:customPriceLB];
    [customPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(countLB.mas_bottom);
        make.left.mas_equalTo(cellSpaceOffset);
        make.height.mas_equalTo(countLB.mas_height);
    }];
    
    customPriceStateLB = [CPLabel new];
    customPriceStateLB.textColor = UIColor.redColor;
    customPriceStateLB.text = [NSString stringWithFormat:@"(%@)",@"已支付"];
    
    [self.contentView addSubview:customPriceStateLB];
    [customPriceStateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(countLB.mas_bottom);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.height.mas_equalTo(countLB.mas_height);
    }];
    
    
    platformPriceLB = [CPLabel new];
    platformPriceLB.text = [NSString stringWithFormat:@"平台回收价：¥%@",@(0)];
    
    [self.contentView addSubview:platformPriceLB];
    [platformPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(customPriceLB.mas_bottom);
        make.left.mas_equalTo(cellSpaceOffset);
        make.height.mas_equalTo(countLB.mas_height);
    }];
    
    
    balanceLB = [CPLabel new];
    balanceLB.text = [NSString stringWithFormat:@"应付余额：¥%@",@(0)];
    
    [self.contentView addSubview:balanceLB];
    [balanceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(platformPriceLB.mas_bottom);
        make.left.mas_equalTo(cellSpaceOffset);
        make.height.mas_equalTo(countLB.mas_height);
    }];
    
    
    //  实际余额
    finallyPriceLB = [CPLabel new];
    finallyPriceLB.text = [NSString stringWithFormat:@"实付余额：¥%@",@(0)];
    
    [self.contentView addSubview:finallyPriceLB];
    [finallyPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(balanceLB.mas_bottom);
        make.left.mas_equalTo(cellSpaceOffset);
        make.height.mas_equalTo(countLB.mas_height);
    }];
    
    finallyPriceStateLB = [CPLabel new];
    finallyPriceStateLB.textColor = UIColor.redColor;
    finallyPriceStateLB.text = [NSString stringWithFormat:@"(%@)",@"已支付"];

    [self.contentView addSubview:finallyPriceStateLB];
    [finallyPriceStateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(balanceLB.mas_bottom);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.height.mas_equalTo(countLB.mas_height);
    }];
    

    dateLB = [CPLabel new];
    dateLB.text = [NSString stringWithFormat:@"交易时间：¥%@",@"2012030123"];
    
    [self.contentView addSubview:dateLB];
    [dateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(finallyPriceLB.mas_bottom);
        make.left.mas_equalTo(cellSpaceOffset);
        make.height.mas_equalTo(countLB.mas_height).multipliedBy(1);
    }];

    logisticsLB = [CPLabel new];
    logisticsLB.text = [NSString stringWithFormat:@"物流单号：¥%@",@"2012030123"];
    
    [self.contentView addSubview:logisticsLB];
    [logisticsLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(dateLB.mas_bottom);
        make.left.mas_equalTo(cellSpaceOffset);
        make.bottom.mas_equalTo(-4);
        make.height.mas_equalTo(countLB.mas_height).multipliedBy(1);
    }];
    
    
    logisticsCheckBT = [CPButton new];
    logisticsCheckBT.titleLabel.font = [UIFont systemFontOfSize:11];
    [logisticsCheckBT setTitle:@"查看物流" forState:0];
    [logisticsCheckBT addTarget:self action:@selector(checkConsignPage:) forControlEvents:64];
    [self.contentView addSubview:logisticsCheckBT];
    [logisticsCheckBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(logisticsLB.mas_centerY);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.height.mas_equalTo(logisticsLB).multipliedBy(0.7);;
        make.width.mas_equalTo(60);
    }];
    
    //  交易详情按钮
    dealBT = [CPButton new];
    dealBT.titleLabel.font = [UIFont systemFontOfSize:11];
    
    [dealBT setTitle:@"交易详情" forState:0];
    [dealBT addTarget:self action:@selector(seeOrderDetailAction:) forControlEvents:64];
    [self.contentView addSubview:dealBT];
    [dealBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(dateLB.mas_centerY).offset(-0);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.height.mas_equalTo(logisticsCheckBT.mas_height).multipliedBy(1);;
        make.width.mas_equalTo(60);
    }];
    

    UIView *sepLine = [UIView new];
    sepLine.backgroundColor = CPBoardColor;
    
    [self.contentView addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logisticsLB.mas_top).offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(.5);
    }];
}

- (void)seeOrderDetailAction:(id)sender {
    !self.seeDetailAction ? : self.seeDetailAction();
}

- (void)checkConsignPage:(id)sender {
    !self.checkConsignBlock ? : self.checkConsignBlock();
}


@end
