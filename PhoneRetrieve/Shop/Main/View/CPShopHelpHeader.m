//
//  CPShopHelpHeader.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/7.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopHelpHeader.h"

@implementation CPShopHelpHeader

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    UILabel *versionLB = [UILabel new];
    versionLB.text = infoDict[@"CFBundleShortVersionString"];
    versionLB.font = [UIFont systemFontOfSize:13.0f];
    versionLB.textAlignment = NSTextAlignmentCenter;

    [self.contentView addSubview:versionLB];
    
    [versionLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0).offset(-cellSpaceOffset / 2);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];

    UILabel *appNameLB = [UILabel new];
    appNameLB.text = @"手机乐收栈";
    appNameLB.font = [UIFont systemFontOfSize:13.0f];
    appNameLB.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:appNameLB];
    
    [appNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(versionLB.mas_top).offset(-cellSpaceOffset / 2);
    }];

    UIImageView *logoIV = [UIImageView new];
    logoIV.image = CPImage(@"logo");
    logoIV.layer.cornerRadius = 5.0f;
    logoIV.clipsToBounds = YES;

    [self.contentView addSubview:logoIV];

    [logoIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(appNameLB.mas_top).offset(-cellSpaceOffset);
        make.width.mas_equalTo(2 * CELL_HEIGHT_F);
        make.height.mas_equalTo(2 * CELL_HEIGHT_F);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
}


@end
