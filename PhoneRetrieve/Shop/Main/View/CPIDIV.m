//
//  CPIDIV.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPIDIV.h"

@implementation CPIDIV {
    UIImageView *frontIV, *backIV;
    CPLabel *frontLB, *backLB;
}

- (void)setupUI {
    
    frontIV = [UIImageView new];
    frontIV.image = CPImage(@"me_icon_Account");
    [self.contentView addSubview:frontIV];
    [frontIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cellSpaceOffset);
        make.left.mas_equalTo(cellSpaceOffset);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    frontLB = [CPLabel new];
    frontLB.text = @"身份证正面";
    frontLB.textAlignment = NSTextAlignmentCenter;
    frontLB.textColor = [UIColor redColor];
    [self.contentView addSubview:frontLB];
    [frontLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(frontIV.mas_left);
        make.width.mas_equalTo(frontIV.mas_width);
        make.top.mas_equalTo(frontIV.mas_bottom).offset(cellSpaceOffset/2);
    }];

    backIV = [UIImageView new];
    backIV.image = CPImage(@"me_icon_Account");
    [self.contentView addSubview:backIV];
    [backIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(frontIV.mas_top);
        make.left.mas_equalTo(frontIV.mas_right).offset(cellSpaceOffset);
        make.size.mas_equalTo(frontIV);
    }];
    
    backLB = [CPLabel new];
    backLB.text = @"身份证背面";
    backLB.textAlignment = NSTextAlignmentCenter;
    backLB.textColor = [UIColor redColor];
    [self.contentView addSubview:backLB];
    [backLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(frontLB.mas_top);
        make.left.mas_equalTo(backIV.mas_left);
        make.width.mas_equalTo(backIV.mas_width);
//        make.bottom.mas_equalTo(-cellSpaceOffset);
    }];

}

- (void)setModel:(CPUserDetailInfoModel *)model {
    _model = model;
    
    [frontIV sd_setImageWithURL:CPUrl(model.idcard1url) placeholderImage:nil];
    [backIV sd_setImageWithURL:CPUrl(model.idcard2url) placeholderImage:nil];
}


@end
