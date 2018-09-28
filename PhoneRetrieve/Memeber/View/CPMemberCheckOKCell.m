//
//  CPMemberCheckOKCell.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/14.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemberCheckOKCell.h"

@implementation CPMemberCheckOKCell {
    CPLabel *itemNameLB;
    
    UIImageView *iconIV;
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
    
    UIView *dotView = [UIView new];
    dotView.backgroundColor = FONT_GREEN;
    dotView.clipsToBounds = YES;
    dotView.layer.cornerRadius = 5.0f;
    [self.contentView addSubview:dotView];
    [dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cellSpaceOffset);
        make.top.mas_equalTo(cellSpaceOffset);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    
    itemNameLB = [CPLabel new];
    itemNameLB.text = @"颜色";
    [self.contentView addSubview:itemNameLB];
    [itemNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dotView.mas_right).offset(8);
        make.centerY.mas_equalTo(dotView.mas_centerY);
    }];
    
    iconIV = [UIImageView new];
    iconIV.image = [UIImage imageNamed:@"checkMark_Right"];
    [self.contentView addSubview:iconIV];
    [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-cellSpaceOffset);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}

- (void)setModel:(CPMemberReportResultJsonData *)model {
    _model = model;
    
    itemNameLB.text = model.name;
}


@end
