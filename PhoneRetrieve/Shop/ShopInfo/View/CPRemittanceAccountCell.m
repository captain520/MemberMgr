//
//  CPRemittanceAccountCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRemittanceAccountCell.h"

@implementation CPRemittanceAccountCell {
    CPLabel *contentLB;
    
    UIButton *selecteBT;
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
    
    selecteBT = [UIButton new];
//    [selecteBT setImage:CPImage(@"Tick_default") forState:UIControlStateNormal];
//    [selecteBT setImage:CPImage(@"Tick_preseed") forState:UIControlStateSelected];
    [selecteBT addTarget:self action:@selector(buttonAction:) forControlEvents:64];
    
    [self.contentView addSubview:selecteBT];
    [selecteBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_offset(-cellSpaceOffset);
        make.bottom.mas_equalTo(0);
        make.width.mas_offset(20.0f);
    }];
    
    contentLB = [CPLabel new];

    [self.contentView addSubview:contentLB];
    
    [contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(cellSpaceOffset);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)buttonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)setContent:(NSString *)content {
    
    _content = content;
    
    contentLB.text = _content;
}

- (void)setShouldSelected:(BOOL)shouldSelected {
    
    _shouldSelected = shouldSelected;

    if (_shouldSelected == YES) {
        [selecteBT setImage:CPImage(@"Tick_preseed") forState:UIControlStateNormal];
    } else {
        [selecteBT setImage:CPImage(@"Tick_default") forState:UIControlStateNormal];
    }
}

@end
