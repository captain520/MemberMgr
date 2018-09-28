//
//  CPButton.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPButton.h"

@implementation CPButton

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5.0f;
    self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    self.layer.borderColor = CPBoardColor.CGColor;
    self.layer.borderWidth = 0.5f;

    [self setBackgroundImage:CPEnableImage forState:UIControlStateNormal];
    [self setBackgroundImage:CPDisableImage forState:UIControlStateDisabled];
}

- (void)drawRect:(CGRect)rect {
}

@end
