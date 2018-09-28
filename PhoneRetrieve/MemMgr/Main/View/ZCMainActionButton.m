//
//  CPMainItemCell.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCMainActionButton.h"

@implementation ZCMainActionButton {
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
    
    self.backgroundColor = UIColor.whiteColor;
    
    iconIV = [UIImageView new];
    iconIV.image = [UIImage imageNamed:@"logo"];
    iconIV.contentMode = UIViewContentModeScaleAspectFit;

    [self addSubview:iconIV];
    [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SPACE_OFFSET_F);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
        make.bottom.mas_equalTo(-SPACE_OFFSET_F);
        make.width.mas_equalTo(self->iconIV.mas_height);
    }];

    titleLB = [UILabel new];
    titleLB.text = @"Title";
    titleLB.textAlignment = NSTextAlignmentCenter;
    titleLB.numberOfLines = 0;

    [self addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_offset(SPACE_OFFSET_F);
        make.right.mas_equalTo(self->iconIV.mas_left).offset(-SPACE_OFFSET_F);
    }];
    
}

- (void)setTitle:(NSString *)title andImage:(NSString *)imageName {
   
    titleLB.text = title;
    iconIV.image = [UIImage imageNamed:imageName];
}

@end
