//
//  ZCLabel.m
//  MemberManager
//
//  Created by 王璋传 on 2018/9/12.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCLabel.h"

@implementation ZCLabel

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    self.font = [UIFont systemFontOfSize:15];
    self.textColor = C33;
}

@end
