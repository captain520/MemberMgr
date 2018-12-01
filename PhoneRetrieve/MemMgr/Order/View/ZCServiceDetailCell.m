//
//  ZCOrderDetailCell.m
//  MemberManager
//
//  Created by 王璋传 on 2018/9/14.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCServiceDetailCell.h"

@implementation ZCServiceDetailCell {
    ZCLabel *orderNoLB, *nameLB, *amountLB, *dateLB, *serviceFeeLB, *memeberNameLB;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DelegateFeeData *)model {
    _model = model;
    
    orderNoLB.text = [NSString stringWithFormat:@"订单号:%@",model.resultno];
//    nameLB.text = [NSString stringWithFormat:@"%@ (%@)",model.goodsname,model.Typename];
    nameLB.attributedText = [self deviceNameAndTypeAttr:model.goodsname type:model.Typename];
    amountLB.text = [NSString stringWithFormat:@"实际平台回收价:¥%@",model.currentprice];
    dateLB.text = [NSString stringWithFormat:@"时间:%@",model.createtime];
    serviceFeeLB.text = [NSString stringWithFormat:@"服务费:¥%@",model.commision];
    memeberNameLB.text = [NSString stringWithFormat:@"会员:%@(%@)",model.doorname,model.doorcode];
}

- (void)setupUI {
    
    orderNoLB = [ZCLabel new];
    orderNoLB.text = @"订单号:12343w9458o345o";
    orderNoLB.font = [UIFont systemFontOfSize:13];
    
    [self.contentView addSubview:orderNoLB];
    [orderNoLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SPACE_OFFSET_F/2);
        make.left.mas_equalTo(SPACE_OFFSET_F);
    }];
    
    
    nameLB = [ZCLabel new];
    nameLB.text = @"Iphone 6s Plus (手机)";
    nameLB.font = [UIFont systemFontOfSize:13];
    
    [self.contentView addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->orderNoLB.mas_bottom);
        make.left.mas_equalTo(self->orderNoLB.mas_left);
        make.height.mas_equalTo(self->orderNoLB.mas_height);
    }];
    
    
    amountLB = [ZCLabel new];
    amountLB.text = @"实际平台回收价:¥20";
    amountLB.font = [UIFont systemFontOfSize:13];
    
    [self.contentView addSubview:amountLB];
    [amountLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->nameLB.mas_bottom);
        make.left.mas_equalTo(self->orderNoLB.mas_left);
        make.height.mas_equalTo(self->orderNoLB.mas_height);
    }];
    
    
    serviceFeeLB = [ZCLabel new];
    serviceFeeLB.text = @"服务费:¥20";
    serviceFeeLB.font = [UIFont systemFontOfSize:13];    serviceFeeLB.textColor = CPERROR_COLOR;
    
    [self.contentView addSubview:serviceFeeLB];
    [serviceFeeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->nameLB.mas_bottom);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
        make.height.mas_equalTo(self->orderNoLB.mas_height);
    }];
    
    
    dateLB = [ZCLabel new];
    dateLB.text = @"时间:2018/09/16";
    dateLB.font = [UIFont systemFontOfSize:13];
    
    [self.contentView addSubview:dateLB];
    [dateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->amountLB.mas_bottom);
        make.left.mas_equalTo(self->orderNoLB.mas_left);
        make.height.mas_equalTo(self->orderNoLB.mas_height);
        make.bottom.mas_equalTo(-SPACE_OFFSET_F/2);
    }];
    
    
    memeberNameLB = [ZCLabel new];
    memeberNameLB.text = @"会员:船长(YH123592)";
    memeberNameLB.font = [UIFont systemFontOfSize:13];
    
    [self.contentView addSubview:memeberNameLB];
    [memeberNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->amountLB.mas_bottom);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
        make.height.mas_equalTo(self->orderNoLB.mas_height);
    }];
    
}

- (NSAttributedString *)deviceNameAndTypeAttr:(NSString *)name type:(NSString *)type {
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:name attributes:nil];
    NSAttributedString *attr0 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"(%@)",type] attributes:@{NSForegroundColorAttributeName : MainColor}];

    [attr appendAttributedString:attr0];
    
    return attr;
}

@end
