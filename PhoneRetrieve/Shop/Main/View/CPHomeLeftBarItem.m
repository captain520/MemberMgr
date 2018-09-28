//
//  CPHomeLeftBarItem.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/1.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPHomeLeftBarItem.h"

@implementation CPHomeLeftBarItem {
    CPCommonButtn *titleBT, *imageBT;
}

- (void)setupUI {

    titleBT = [CPCommonButtn new];//[[CPCommonButtn alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [titleBT setTitle:@"深圳市" forState:0];
    titleBT.userInteractionEnabled = NO;
    [self addSubview:titleBT];
    [titleBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-22);
        make.bottom.mas_equalTo(0);
    }];

    imageBT = [CPCommonButtn new];
    imageBT.userInteractionEnabled = NO;
    [imageBT setImage:CPImage(@"home_down") forState:0];
    [self addSubview:imageBT];
    [imageBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(titleBT.mas_right).offset(2);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
}

- (void)setCityName:(NSString *)cityName {
    
    _cityName = cityName;
    
    [titleBT setTitle:_cityName forState:0];
}

@end
