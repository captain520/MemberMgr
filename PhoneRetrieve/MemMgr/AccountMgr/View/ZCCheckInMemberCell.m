//
//  ZCCheckInMemberCell.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/10/16.
//  Copyright © 2018 Captain. All rights reserved.
//

#import "ZCCheckInMemberCell.h"

@implementation ZCCheckInMemberCell {
    CPLabel *accountLB, *codeLB, *phoneLB, *timeLB;
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
    
    accountLB = [CPLabel new];
    
    [self.contentView addSubview:accountLB];
    [accountLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cellSpaceOffset/2);
        make.left.mas_equalTo(cellSpaceOffset);
    }];
    
    codeLB = [CPLabel new];
    
    [self.contentView addSubview:codeLB];
    [codeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(accountLB.mas_bottom);
        make.left.mas_equalTo(cellSpaceOffset);
        make.height.mas_equalTo(accountLB.mas_height);
    }];
    
    
    phoneLB = [CPLabel new];
    
    [self.contentView addSubview:phoneLB];
    [phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(codeLB.mas_bottom);
        make.left.mas_equalTo(cellSpaceOffset);
        make.height.mas_equalTo(accountLB.mas_height);
    }];
    
    
    timeLB = [CPLabel new];
    
    [self.contentView addSubview:timeLB];
    [timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLB.mas_bottom);
        make.left.mas_equalTo(cellSpaceOffset);
        make.height.mas_equalTo(accountLB.mas_height);
        make.bottom.mas_equalTo(-cellSpaceOffset/2);
    }];

}

- (void)setModel:(DLData *)model {
    _model = model;
    
    accountLB.text = [NSString stringWithFormat:@"子账号名称: %@",model.linkname];
    codeLB.text = [NSString stringWithFormat:@"子账号编码: %@",model.code];
    phoneLB.text = [NSString stringWithFormat:@"联系电话: %@",model.phone];
    timeLB.text = [NSString stringWithFormat:@"入驻马时间: %@",model.createtime];
}

@end
