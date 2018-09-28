//
//  ZCMemberListCell.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/15.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCMemberListCell.h"

@implementation ZCMemberListCell {
    ZCLabel *codeLB, *nameLB, *phoneLB;
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
    
    codeLB = [ZCLabel new];
    codeLB.text = @"会员编码:YF292211112";
    
    [self.contentView addSubview:codeLB];
    [codeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.top.mas_equalTo(SPACE_OFFSET_F/2);
    }];
    
    nameLB = [ZCLabel new];
    nameLB.text = @"会员名称:船长";
    
    [self.contentView addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.top.mas_equalTo(self->codeLB.mas_bottom);
        make.height.mas_equalTo(self->codeLB.mas_height);
    }];
    
    phoneLB = [ZCLabel new];
    phoneLB.text = @"联系电话:YF292211112";
    
    [self.contentView addSubview:phoneLB];
    [phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.top.mas_equalTo(self->nameLB.mas_bottom);
        make.bottom.mas_equalTo(-SPACE_OFFSET_F/2);
        make.height.mas_equalTo(self->codeLB.mas_height);
    }];
}

@end
