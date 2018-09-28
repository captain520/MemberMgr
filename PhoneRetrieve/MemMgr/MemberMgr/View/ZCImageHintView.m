//
//  ZCImageHintView.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/17.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCImageHintView.h"

@interface ZCImageHintView()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) CPLabel *hintLB;

@end

@implementation ZCImageHintView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }

    return self;
}

- (void)setupUI {
    
    _hintLB = [CPLabel new];
    _hintLB.text = @"营业执照";
    
    [self addSubview:_hintLB];
    [self.hintLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    self.imageView = [UIImageView new];
    self.imageView.image = [UIImage imageNamed:@"placeHolderImage"];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.hintLB.mas_top);
    }];
}

@end
