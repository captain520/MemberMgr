//
//  CPLabel.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPLabel.h"

@implementation CPLabel

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    self.font = CPFont_M;
    self.textColor = C33;
    self.numberOfLines = 0;
}

@end
