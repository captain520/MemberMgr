//
//  ZCOrderListHeaderView.m
//  MemberManager
//
//  Created by 王璋传 on 2018/9/14.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCOrderListHeaderView.h"

@implementation ZCOrderListHeaderView {
    ZCLabel *memeberNameLB, *chargeNameLB, *orderNOLB;;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    self.contentView.backgroundColor = UIColor.whiteColor;

    memeberNameLB = [ZCLabel new];
    memeberNameLB.font = [UIFont systemFontOfSize:13.];
    memeberNameLB.text = @"会员：船长";
    
    [self.contentView addSubview:memeberNameLB];
    [memeberNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(SPACE_OFFSET_F);
    }];
    
    chargeNameLB = [ZCLabel new];
    chargeNameLB.font = [UIFont systemFontOfSize:13];
    chargeNameLB.text = @"负责人：Old wang";
    
    [self.contentView addSubview:chargeNameLB];
    [chargeNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->memeberNameLB.mas_top);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
        make.height.mas_equalTo(self->memeberNameLB.mas_height);
    }];
    
    UIView *sepLine = [UIView new];
    sepLine.backgroundColor = BorderColor;
    
    [self.contentView addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->memeberNameLB.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(.5);
    }];
    
    orderNOLB = [ZCLabel new];
    orderNOLB.font = [UIFont systemFontOfSize:13];
    orderNOLB.text = @"订单号：123oiwqrisflls102939";
    
    [self.contentView addSubview:orderNOLB];
    [orderNOLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->memeberNameLB.mas_left);
        make.top.mas_equalTo(self->memeberNameLB.mas_bottom);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(self->memeberNameLB.mas_height);
    }];
    
    UIView *sepLine1 = [UIView new];
    sepLine1.backgroundColor = BorderColor;
    
    [self.contentView addSubview:sepLine1];
    [sepLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(.5);
        make.bottom.mas_equalTo(0);
    }];

}

- (void)setModel:(CPShopOrderDetailModel *)model {
    _model = model;
    
    orderNOLB.text = model.ordersn;
}

@end
