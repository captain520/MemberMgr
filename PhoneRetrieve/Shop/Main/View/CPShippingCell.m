//
//  CPShippingCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/23.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShippingCell.h"

@implementation CPShippingCell {
    
    UIImageView *iconIV;
    
    CPLabel *nameLB, *typeNameLB,*priceLB,*orderNOLB;

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
    iconIV.backgroundColor = BgColor;
    iconIV.image = CPImage(@"apple");
    [self.contentView addSubview:iconIV];
    [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cellSpaceOffset/2);
        make.left.mas_equalTo(cellSpaceOffset);
        make.bottom.mas_equalTo(-cellSpaceOffset/2);
        make.width.mas_equalTo(iconIV.mas_height);
    }];
    
    nameLB = [CPLabel new];
    nameLB.text = @"iPhone 6s";
    [self.contentView addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconIV.mas_top);
        make.left.mas_equalTo(iconIV.mas_right).offset(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
    }];
    
    priceLB = [CPLabel new];
    priceLB.text = @"¥122.00";
    priceLB.textColor = UIColor.redColor;
    [self.contentView addSubview:priceLB];
    [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(iconIV.mas_centerY);
        make.left.mas_equalTo(iconIV.mas_right).offset(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
    }];
    
    orderNOLB = [CPLabel new];
    orderNOLB.numberOfLines = 1;
    orderNOLB.text = @"订单号：12343";
    [self.contentView addSubview:orderNOLB];
    [orderNOLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconIV.mas_right).offset(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.bottom.mas_equalTo(iconIV.mas_bottom);
    }];
}

- (void)setModel:(ShippingDetailData *)model {
    _model = model;
    
    
    [iconIV sd_setImageWithURL:CPUrl(_model.goodsurl) placeholderImage:CPImage(@"default")];

    priceLB.text = [NSString stringWithFormat:@"¥%@",_model.price];
    orderNOLB.text = [NSString stringWithFormat:@"评估单号:%@",_model.resultno];
    
    NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:_model.goodsname attributes:nil];
    NSString *typeName = [NSString stringWithFormat:@"(%@)",_model.Typename];
    NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:typeName attributes:@{NSForegroundColorAttributeName : UIColor.redColor}];;
    [attr0 appendAttributedString:attr1];
    
    nameLB.attributedText = attr0;
}

@end
