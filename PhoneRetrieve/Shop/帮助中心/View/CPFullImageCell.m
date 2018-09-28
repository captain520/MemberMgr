//
//  CPFullImageCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/21.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPFullImageCell.h"

@implementation CPFullImageCell {
    UIImageView *cp_imageView;
    
    CPLabel *testLB;
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
    
    cp_imageView = [UIImageView new];
    cp_imageView.backgroundColor = UIColor.redColor;
//    cp_imageView.contentMode = UIViewContentModeScaleAspectFit;
    cp_imageView.image = CPImage(@"Apple");

    [self addSubview:cp_imageView];
    [cp_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
//    testLB = [CPLabel new];
//    testLB.text = @"300000";
//
//    [self.contentView addSubview:testLB];
//    [testLB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(0);
//    }];
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    
    cp_imageView.image = CPImage(_imageName);
}

@end
