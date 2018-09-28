//
//  CPMemberInfoEditCell.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/4.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemberInfoEditCell.h"

@implementation CPMemberInfoEditCell {
    CPLabel *titleLB, *subTitleLB;
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
    
    iconIV = [UIImageView new];
    iconIV.contentMode = UIViewContentModeScaleAspectFit;
    iconIV.image = [UIImage imageNamed:@"right"];
    [self.contentView addSubview:iconIV];
    [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-cellSpaceOffset);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    titleLB = [CPLabel new];
    titleLB.text = @"-----";
    [self.contentView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cellSpaceOffset);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    subTitleLB = [CPLabel new];
    subTitleLB.text = @"subTitleLB";
    [self.contentView addSubview:subTitleLB];
    [subTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-cellSpaceOffset - 15 - 4);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
}

- (void)setTItle:(NSString *)title subTitle:(NSString *)subTitle hideArrowYesOrNo:(BOOL)hide {
    titleLB.text = title;
    subTitleLB.text = subTitle;
    
    iconIV.hidden = hide;
    
//    [subTitleLB mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-cellSpaceOffset);
//    }];
}

@end
