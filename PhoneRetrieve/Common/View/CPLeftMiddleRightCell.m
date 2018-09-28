//
//  CPLeftMiddleRightCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPLeftMiddleRightCell.h"

@implementation CPLeftMiddleRightCell {
    CPLabel *leftLB, *middleLB, *rightLB;
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
   
    {
        leftLB = [CPLabel new];
        leftLB.text = @"当日订单";
        [self.contentView addSubview:leftLB];
        [leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(cellSpaceOffset);
            make.bottom.mas_equalTo(0);
        }];
    }
    
    {
        rightLB = [CPLabel new];
        rightLB.text = @"合计数量";
        [self.contentView addSubview:rightLB];
        [rightLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.bottom.mas_equalTo(0);
        }];
    }
    
    {
        middleLB = [CPLabel new];
        middleLB.text = @"合计金额：";
        middleLB.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:middleLB];
        [middleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(leftLB.mas_right);
            make.right.mas_equalTo(rightLB.mas_left);
            make.bottom.mas_equalTo(0);
        }];
    }
}

@end
