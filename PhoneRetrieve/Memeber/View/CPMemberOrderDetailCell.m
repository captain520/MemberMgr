//
//  CPMemberOrderDetailCell.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemberOrderDetailCell.h"

@implementation CPMemberOrderDetailCell {
    UIImageView *iconIV;
    CPLabel *orderNOLB, *nameLB, *customPriceLB, *platformPriceLB, *imeiLB;
    
    CPLabel *customPayStatusLB;
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
    
    iconIV = [UIImageView new];
    iconIV.image = [UIImage imageNamed:@"logo"];
    
    [self.contentView addSubview:iconIV];
    [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(4);
        make.left.mas_equalTo(cellSpaceOffset);
        make.bottom.mas_equalTo(-4);
        make.width.mas_equalTo(iconIV.mas_height);
    }];
    
    //  订单号
    orderNOLB = [CPLabel new];
    orderNOLB.text = @"订单号：123124234";
    [self.contentView addSubview:orderNOLB];
    [orderNOLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconIV.mas_top);
        make.left.mas_equalTo(iconIV.mas_right).offset(4);
    }];
    
    //  设备名称
    nameLB = [CPLabel new];
    nameLB.text = @"iPhone 6s Plus";
    [self.contentView addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(orderNOLB.mas_bottom);
        make.left.mas_equalTo(orderNOLB.mas_left);
        make.height.mas_equalTo(orderNOLB.mas_height);
    }];
    
    //   客户成交价
    customPriceLB = [CPLabel new];
    customPriceLB.text = @"客户成交价：12312";
    [self.contentView addSubview:customPriceLB];
    [customPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLB.mas_bottom);
        make.left.mas_equalTo(orderNOLB.mas_left);
        make.height.mas_equalTo(orderNOLB.mas_height);
    }];
    
    customPayStatusLB = [CPLabel new];
    [self.contentView addSubview:customPayStatusLB];
    [customPayStatusLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-cellSpaceOffset);
        make.centerY.mas_equalTo(customPriceLB.mas_centerY);
    }];

    //    平台成交价
    platformPriceLB = [CPLabel new];
    platformPriceLB.text = @"平台成交价：12312";
    [self.contentView addSubview:platformPriceLB];
    [platformPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(customPriceLB.mas_bottom);
        make.left.mas_equalTo(orderNOLB.mas_left);
        make.height.mas_equalTo(orderNOLB.mas_height);
    }];
    
    //    IMEI
    imeiLB = [CPLabel new];
    imeiLB.text = @"IMEI:12312312";
    [self.contentView addSubview:imeiLB];
    [imeiLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(platformPriceLB.mas_bottom);
        make.left.mas_equalTo(orderNOLB.mas_left);
        make.height.mas_equalTo(orderNOLB.mas_height);
        make.bottom.mas_equalTo(iconIV.mas_bottom);
    }];
}

- (void)setModel:(CPMemberOrderDetailModel *)model {
    _model = model;
    
    [iconIV sd_setImageWithURL:[NSURL URLWithString:model.goodsurl] placeholderImage:CPImage(@"logo")];
    orderNOLB.text = [NSString stringWithFormat:@"订单号：%@",model.resultno];
    nameLB.text = [NSString stringWithFormat:@"%@",model.goodsname];
    customPriceLB.text = [NSString stringWithFormat:@"客户成交价：%.2f",model.price.floatValue];
    platformPriceLB.text = [NSString stringWithFormat:@"平台成交价：%.2f",model.currentprice.floatValue];
    imeiLB.text = [NSString stringWithFormat:@"IMEI：%@",model.customimei];
    
    customPayStatusLB.text = model.paycfg ? @"已支付" : @"未支付";
    customPayStatusLB.textColor = model.paycfg ? MainColor : CPERROR_COLOR;
}

@end
