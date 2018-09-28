//
//  ZCButton.m
//  MemberManager
//
//  Created by 王璋传 on 2018/9/12.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCButton.h"

@implementation ZCButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    self.exclusiveTouch = YES;

    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.backgroundColor = MainColor;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5.0f;
    self.layer.shadowColor = UIColor.grayColor.CGColor;
    self.layer.shadowOffset = CGSizeMake(10, 10);
    self.layer.shadowRadius = 10;

    [self setTitleColor:C33 forState:0];
}

@end
