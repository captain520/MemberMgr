//
//  CPSelectCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPSelectCell.h"

@implementation CPSelectCell {
    UIImageView *stateIV;
    CPLabel *contentLB;
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

    stateIV = [UIImageView new];
    stateIV.image = CPImage(@"Tick_default");
    [self.contentView addSubview:stateIV];
    
    contentLB = [CPLabel new];
    [self.contentView addSubview:contentLB];
    
    [stateIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.left.mas_equalTo(cellSpaceOffset);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(stateIV.mas_right).offset(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)setHasSelected:(BOOL)hasSelected {
    
    _hasSelected = hasSelected;
    
    if (_hasSelected) {
        stateIV.image = CPImage(@"Tick_preseed");
    } else {
        stateIV.image = CPImage(@"Tick_default");
    }
}

- (void)setContent:(NSString *)content {
    
//    _content = content;
    _content = [CPUserInfoModel shareInstance].operationDes;
    
    contentLB.text = _content;
}

@end
