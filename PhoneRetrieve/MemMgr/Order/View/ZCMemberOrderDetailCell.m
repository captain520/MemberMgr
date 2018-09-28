//
//  CPMemberOrderDetailCell.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCMemberOrderDetailCell.h"

@implementation ZCMemberOrderDetailCell {
    UIImageView *iconIV;
    ZCLabel *orderNOLB, *nameLB, *customPriceLB, *platformPriceLB, *imeiLB;
    
    ZCLabel *customPayStatusLB;
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
    iconIV.backgroundColor = UIColor.lightGrayColor;
    
    [self.contentView addSubview:iconIV];
    [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(4);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.bottom.mas_equalTo(-4);
        make.width.mas_equalTo(self->iconIV.mas_height);
    }];
    
    //  订单号
    orderNOLB = [ZCLabel new];
    orderNOLB.text = @"订单号：123124234";
    [self.contentView addSubview:orderNOLB];
    [orderNOLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->iconIV.mas_top);
        make.left.mas_equalTo(self->iconIV.mas_right).offset(4);
    }];
    
    //  设备名称
    nameLB = [ZCLabel new];
    nameLB.text = @"iPhone 6s Plus";
    [self.contentView addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->orderNOLB.mas_bottom);
        make.left.mas_equalTo(self->orderNOLB.mas_left);
        make.height.mas_equalTo(self->orderNOLB.mas_height);
    }];
    
    //   客户成交价
    customPriceLB = [ZCLabel new];
    customPriceLB.text = @"客户成交价：12312";
    [self.contentView addSubview:customPriceLB];
    [customPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->nameLB.mas_bottom);
        make.left.mas_equalTo(orderNOLB.mas_left);
        make.height.mas_equalTo(self->orderNOLB.mas_height);
    }];
    
    customPayStatusLB = [ZCLabel new];
    [self.contentView addSubview:customPayStatusLB];
    [customPayStatusLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-SPACE_OFFSET_F);
        make.centerY.mas_equalTo(self->customPriceLB.mas_centerY);
    }];

    //    平台成交价
    platformPriceLB = [ZCLabel new];
    platformPriceLB.text = @"平台成交价：12312";
    [self.contentView addSubview:platformPriceLB];
    [platformPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->customPriceLB.mas_bottom);
        make.left.mas_equalTo(self->orderNOLB.mas_left);
        make.height.mas_equalTo(self->orderNOLB.mas_height);
    }];
    
    //    IMEI
    imeiLB = [ZCLabel new];
    imeiLB.text = @"IMEI:12312312";
    [self.contentView addSubview:imeiLB];
    [imeiLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->platformPriceLB.mas_bottom);
        make.left.mas_equalTo(self->orderNOLB.mas_left);
        make.height.mas_equalTo(self->orderNOLB.mas_height);
        make.bottom.mas_equalTo(self->iconIV.mas_bottom);
    }];
}

@end
