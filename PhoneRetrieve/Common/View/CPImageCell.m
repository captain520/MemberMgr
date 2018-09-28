//
//  CPImageCell.m
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/10.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "CPImageCell.h"


@implementation CPImageCell {
    UIImageView *contentIV;
}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    if (nil == contentIV) {
        
        contentIV = [UIImageView new];
        contentIV.userInteractionEnabled = YES;

        [self.contentView addSubview:contentIV];
        
        [contentIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    
    if (nil == self.deleteButton) {
        
        self.deleteButton = [UIButton new];
        self.deleteButton.backgroundColor = UIColor.redColor;
        
        [self.deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:self.deleteButton];
        
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right);
            make.top.mas_equalTo(self.contentView.mas_top);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    }
}

- (void)setImage:(UIImage *)image {
    
    _image = image;
    
    contentIV.image = image;
}

- (void)deleteAction:(id)sender {
    NSLog(@"%s",__FUNCTION__);
    !self.deleteAction ? : self.deleteAction(self.indexPath);
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
}

@end
