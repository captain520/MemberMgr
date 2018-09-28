//
//  CPImageTitleUpDownCell.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPImageTitleUpDownCell.h"

@implementation CPImageTitleUpDownCell {
    UIImageView *iconIV;
    CPLabel *titleLB;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI  {
    
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = CPBoardColor.CGColor;

    titleLB = [CPLabel new];
    titleLB.text = @"sldfjasl";
    titleLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];

    iconIV = [UIImageView new];
//    iconIV.contentMode = UIViewContentModeCenter;
    iconIV.image = [UIImage imageNamed:@"logo"];
    [self.contentView addSubview:iconIV];
    [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(4);
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(iconIV.mas_height);
        make.bottom.mas_equalTo(titleLB.mas_top);
    }];
    
//    {
//        UIView *sepLine = [UIView new];
//        sepLine.backgroundColor = CPBoardColor;
//
//        [self.contentView addSubview:sepLine];
//        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(0);
//            make.right.mas_equalTo(0);
//            make.bottom.mas_equalTo(0);
//            make.height.mas_equalTo(.5);
//        }];
//    }

}

- (void)updateImage:(NSString *)imageUrl title:(NSString *)title {
    [iconIV sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    titleLB.text = title;
}

@end
