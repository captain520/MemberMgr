//
//  CPSortCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/8.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPSortCell.h"

@implementation CPSortCell {
    UILabel *noLB, *contentLB;
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
    
    noLB = [CPLabel new];
    noLB.text = @"123";
    noLB.textAlignment = NSTextAlignmentCenter;
    noLB.textColor = [UIColor whiteColor];
    [self addSubview:noLB];
    
    [noLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(cellSpaceOffset);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(20);
    }];
    
    contentLB = [CPLabel new];
    [self addSubview:contentLB];
    
    [contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(noLB.mas_right).offset(cellSpaceOffset/2);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
//        make.right.mas_offset(-cellSpaceOffset);
    }];
}

- (void)setNo:(NSString *)no {
    
    _no = no;
    
    if ([no isEqualToString:@"01"]) {
        noLB.backgroundColor = [UIColor redColor];
        
    } else if ([no isEqualToString:@"02"]) {
        noLB.backgroundColor = [UIColor orangeColor];
        
    } else if ([no isEqualToString:@"03"]) {
        noLB.backgroundColor = MainColor;
        
    } else {
        noLB.backgroundColor = [UIColor grayColor];
    }
    
    noLB.text = _no;
    
    
    CGSize size = [no sizeWithAttributes:@{NSFontAttributeName : CPFont_M}];
    [noLB mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(cellSpaceOffset);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(size.width + 5);
    }];
}

- (void)setContent:(NSString *)content {
    
    _content = content;
    contentLB.text = _content;
}

@end
