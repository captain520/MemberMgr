//
//  CPShopAboutHeader.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopAboutHeader.h"

@implementation CPShopAboutHeader {
    UIImageView *bgIV;
    
    CPLabel *nolabel, *nameLB;
}

- (void)setupUI {
    
    bgIV = [UIImageView new];
    bgIV.contentMode = UIViewContentModeScaleToFill;
    bgIV.image = CPImage(@"me_bg");
    [self.contentView addSubview:bgIV];
    
    [bgIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-cellSpaceOffset);
    }];
    

    nolabel = [CPLabel new];
    nolabel.text = @"门店编号: 3312345";
    nolabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:nolabel];
    
    nameLB = [CPLabel new];
    nameLB.text = @"门店名称: 望江路35号分店";
    nameLB.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:nameLB];
    
    [nolabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgIV.mas_centerX);
        make.centerY.mas_equalTo(bgIV.mas_centerY).offset(-cellSpaceOffset);
    }];
    
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nolabel.mas_bottom).offset(cellSpaceOffset);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
}

- (void)setContent:(NSString *)content {
    
    _content = content;
    
    nolabel.text = _content;
}

- (void)setDetail:(NSString *)detail {
    
    _detail = detail;
    
    nameLB.text = detail;
}

@end
