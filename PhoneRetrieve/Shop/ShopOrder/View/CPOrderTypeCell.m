//
//  CPOrderTypeCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/13.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPOrderTypeCell.h"

@implementation CPOrderTypeCell {
    UILabel *contentLB;
    CPCommonButtn *questionBT;
    
    UIView *bgView;
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
    
    bgView = [UIView new];
    bgView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.top.mas_equalTo(cellSpaceOffset/2);
        make.bottom.mas_equalTo(-cellSpaceOffset/2);
    }];

    contentLB = [CPLabel new];
    [bgView addSubview:contentLB];
    [contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_offset(cellSpaceOffset);
    }];
    
    questionBT = [CPCommonButtn new];
    questionBT.hidden = YES;
    [bgView addSubview:questionBT];
    [questionBT setImage:CPImage(@"question_mark") forState:0];
    [questionBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-cellSpaceOffset);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}

- (void)setContent:(NSString *)content {
    _content = content;
    
    contentLB.text = content;
}

@end
