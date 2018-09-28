//
//  CPResponderCell.m
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/10.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "CPResponderCell.h"

@implementation CPResponderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)hasText {
    return YES;
}


- (void)insertText:(NSString *)text {
    
}

- (void)deleteBackward {
    
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
