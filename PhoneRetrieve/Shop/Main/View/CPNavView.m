//
//  CPNavView.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/8.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPNavView.h"

@implementation CPNavView {
}

- (void)setupUI {
    
    self.backButton = [UIButton new];
//    self.backButton.backgroundColor = [UIColor redColor];
    [self.backButton setImage:CPImage(@"left") forState:0];
    [self addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(CPStatusBarHeight);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(2 * cellSpaceOffset);
    }];
    
    
    self.righButton = [UIButton new];
    [self.righButton setTitleColor:C33 forState:0];
    [self.righButton setTitle:@"确定" forState:0];
    self.righButton.hidden = YES;
    [self addSubview:self.righButton];
    [self.righButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CPStatusBarHeight);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-cellSpaceOffset);
    }];
}

@end
