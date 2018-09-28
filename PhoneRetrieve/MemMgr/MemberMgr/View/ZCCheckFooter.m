//
//  ZCCheckFooter.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/17.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCCheckFooter.h"

@implementation ZCCheckFooter {
    ZCButton *checkBT;
}

- (void)setupUI {
    
    self.contentView.backgroundColor = UIColor.whiteColor;
    
    checkBT = [ZCButton new];
    
    [self.contentView addSubview:checkBT];
    [checkBT setTitle:@"审核" forState:0];
    [checkBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    UIView *sepLine = [UIView new];
    sepLine.backgroundColor = CPBoardColor;
    
    [self.contentView addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(.5);
    }];
}

@end
