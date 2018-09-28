//
//  CPShippingListCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShippingListCell.h"

@implementation CPShippingListCell {
    CPLabel *orderNoLB, *stateLB, *countLB, *priceLB,*timeLB;
    UIButton *detailBT;
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
    
    orderNoLB = [CPLabel new];
    orderNoLB.text = @"交易单号：983732974892";
    [self.contentView addSubview:orderNoLB];
    
    [orderNoLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cellSpaceOffset / 2);
        make.left.mas_offset(cellSpaceOffset);
    }];
    
    
    stateLB = [CPLabel new];
    stateLB.text = @"待收货";
    stateLB.textColor = CPERROR_COLOR;
    [self.contentView addSubview:stateLB];
    
    [stateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(orderNoLB.mas_top);
        make.right.mas_offset(-cellSpaceOffset);
    }];
    
    countLB = [CPLabel new];
    countLB.text = @"总共3件商品";
    [self.contentView addSubview:countLB];
    
    [countLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(orderNoLB.mas_bottom).offset(4);
        make.left.mas_offset(cellSpaceOffset);
    }];
    
    priceLB = [CPLabel new];
    priceLB.attributedText = cp_commonRedAttr(@"合计：", @"¥1233.00");
    
    [self.contentView addSubview:priceLB];
    
    [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(countLB.mas_top);
        make.left.mas_equalTo(countLB.mas_right).offset(cellSpaceOffset / 2);
    }];
    
    timeLB = [CPLabel new];
    [self.contentView addSubview:timeLB];
    [timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(countLB.mas_bottom).offset(4);
        make.left.mas_equalTo(countLB.mas_left);
    }];
    
    detailBT = [UIButton new];
    detailBT.hidden = YES;
    [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [detailBT setTitle:@"..." forState:0];
    [detailBT setTitleColor:C33 forState:0];
    [self.contentView addSubview:detailBT];
    [detailBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-cellSpaceOffset);
        make.centerY.mas_equalTo(priceLB.mas_centerY);
    }];
    
}

- (void)setModel:(CPShopOrderDetailModel *)model {
    _model = model;
    
    orderNoLB.text = [NSString stringWithFormat:@"交易单号：%@",_model.ordersn];//@"交易单号：983732974892";
    stateLB.text = _model.paycfg  == 0 ? @"待支付" : @"已支付";//@"待收货";
    stateLB.textColor = _model.paycfg ? CPERROR_COLOR: MainColor;
    countLB.text = [NSString stringWithFormat:@"总共%ld件商品",_model.goodscount];
    NSString *price = [NSString stringWithFormat:@"¥:%.2f",_model.totalprice];
    priceLB.attributedText = cp_commonRedAttr(@"合计:",price);
    
    if (model.paycfg == 0) {
        timeLB.text = [NSString stringWithFormat:@"创建时间:%@",model.createtime];
    }else if (model.paycfg == 1) {
        timeLB.text = [NSString stringWithFormat:@"支付时间:%@",model.paytime];
    }
}

- (void)setLogistModel:(CPShopOrderDetailModel *)logistModel {
    
    _model = logistModel;

    orderNoLB.text = [NSString stringWithFormat:@"交易单号：%@",_model.ordersn];//@"交易单号：983732974892";
    stateLB.text = _model.finishcfg ? @"已签收" : @"在途";
    stateLB.textColor = _model.finishcfg? MainColor: CPERROR_COLOR;
    countLB.text = [NSString stringWithFormat:@"总共%ld件商品",_model.goodscount];
    NSString *price = [NSString stringWithFormat:@"¥:%.2f",_model.totalprice];
    priceLB.attributedText = cp_commonRedAttr(@"合计:",price);
}

@end
