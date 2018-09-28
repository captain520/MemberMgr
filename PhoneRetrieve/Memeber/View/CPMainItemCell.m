//
//  CPMainItemCell.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMainItemCell.h"

@implementation CPMainItemCell {
    UILabel *titleLB;
    UIImageView *iconIV;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    DDLogInfo(@"%s",__FUNCTION__);
    
    iconIV = [UIImageView new];
    iconIV.image = [UIImage imageNamed:@"logo"];
    iconIV.contentMode = UIViewContentModeScaleAspectFit;

    [self.contentView addSubview:iconIV];
    [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.bottom.mas_equalTo(-cellSpaceOffset);
        make.width.mas_equalTo(iconIV.mas_height);
    }];
    
    
    titleLB = [UILabel new];
    titleLB.text = @"Title";
    titleLB.textAlignment = NSTextAlignmentCenter;
    titleLB.numberOfLines = 0;

    [self.contentView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
//        make.top.mas_offset(0);
        make.left.mas_offset(cellSpaceOffset);
        make.right.mas_equalTo(iconIV.mas_left).offset(-cellSpaceOffset);
//        make.bottom.mas_equalTo(self.contentView.mas_centerY);
    }];
    
}

- (void)setTitle:(NSString *)title andImage:(NSString *)imageName {
   
    titleLB.text = title;
    iconIV.image = [UIImage imageNamed:imageName];
}

@end
