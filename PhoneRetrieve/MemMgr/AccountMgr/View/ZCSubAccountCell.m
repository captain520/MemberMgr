//
//  ZCSubAccountCell.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/19.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCSubAccountCell.h"

@implementation ZCSubAccountCell {
    ZCLabel *codeLB, *nameLB, *phoneLB;
    
    ZCButton *checkBT, *ownMeberBT, *modifyBT;
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
    checkBT.tag = CPBASETAG + 2;
    
    [self.contentView addSubview:checkBT];
    [checkBT setTitle:@"删除" forState:0];
    [checkBT addTarget:self action:@selector(checkAction:) forControlEvents:64];
    [checkBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-7);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    
    modifyBT = [ZCButton new];
    modifyBT.tag = CPBASETAG + 1;
    
    [self.contentView addSubview:modifyBT];
    [modifyBT setTitle:@"修改" forState:0];
    [modifyBT addTarget:self action:@selector(checkAction:) forControlEvents:64];
    [modifyBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-7);
        make.right.mas_equalTo(checkBT.mas_left).offset(-SPACE_OFFSET_F/2);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    ownMeberBT = [ZCButton new];
    ownMeberBT.tag = CPBASETAG;
    
    [self.contentView addSubview:ownMeberBT];
    [ownMeberBT setTitle:@"入住会员" forState:0];
    [ownMeberBT addTarget:self action:@selector(checkAction:) forControlEvents:64];
    [ownMeberBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.bottom.mas_equalTo(-7);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];

    
    codeLB = [ZCLabel new];
    codeLB.text = @"子账号名称:船长";
    
    [self.contentView addSubview:codeLB];
    [codeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.top.mas_equalTo(SPACE_OFFSET_F/2);
    }];
    
    nameLB = [ZCLabel new];
    nameLB.text = @"子账号编码:YF292211112";
    
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
    
    DDLogInfo(@"%s tag:%ld",__FUNCTION__,(long)sender.tag);
}

@end
