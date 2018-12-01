//
//  ZCMemberCheckCell.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/17.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCMemberCheckCell.h"

@implementation ZCMemberCheckCell {
    ZCLabel *codeLB, *nameLB, *phoneLB;
    
    ZCButton *checkBT;
}

- (void)setModel:(DLData *)model {
    _model = model;
    
    codeLB.text = [NSString stringWithFormat:@"会员编码:%@",model.code];
    nameLB.text = [NSString stringWithFormat:@"会员名称:%@",model.linkname];
    phoneLB.text = [NSString stringWithFormat:@"联系电话:%@",model.phone];
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
    
    UIView *sepLine = [UIView new];
    sepLine.backgroundColor = CPBoardColor;
    
    [self addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-44);
        make.height.mas_equalTo(.5);
    }];
    
    checkBT = [ZCButton new];
    
    [self.contentView addSubview:checkBT];
    [checkBT setTitle:@"审核" forState:0];
    [checkBT addTarget:self action:@selector(checkAction:) forControlEvents:64];
    [checkBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-7);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
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
        make.bottom.mas_equalTo(sepLine.mas_top).offset(-SPACE_OFFSET_F/2);
        make.height.mas_equalTo(self->codeLB.mas_height);
    }];
}

- (void)checkAction:(UIButton *)sender {
    !self.checkBlock ? : self.checkBlock();
}


@end
