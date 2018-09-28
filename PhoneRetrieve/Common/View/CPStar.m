//
//  CPStar.m
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/16.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "CPStar.h"
#define BASE_TAG        (9999)

@implementation CPStar

- (void)setStarCount:(NSInteger)starCount {
    
    _starCount = starCount;
    
    [self refreshUI];
}

- (void)setItemSpace:(NSInteger)itemSpace {
    
    _itemSpace = itemSpace;
    
    [self refreshUI];
}

- (void)setItemSize:(CGSize)itemSize {
    
    _itemSize = itemSize;
    
    [self refreshUI];
}

- (void)setScore:(NSInteger)score {
    
    _score = score;
    
    
    for (NSInteger i = BASE_TAG ; i <= BASE_TAG + score; ++i) {
        UIImageView *imageButton = [self viewWithTag:i];
        
        imageButton.image = CPImage(@"RedStar");
    }
    
    for (NSInteger i = BASE_TAG + score; i < BASE_TAG + self.starCount; ++i) {
        
        UIImageView *imageButton = [self viewWithTag:i];
        imageButton.image = CPImage(@"BlackStar");
    }
}

- (void)refreshUI {
    
    for (NSInteger i = 0; i < self.starCount; ++i) {
        
        UIImageView *imageButton = [self viewWithTag:BASE_TAG + i];

        if (nil == imageButton) {
            imageButton = [UIImageView new];
            imageButton.userInteractionEnabled = YES;
            imageButton.tag = BASE_TAG + i;
            imageButton.contentMode = UIViewContentModeScaleAspectFit;
            imageButton.image = CPImage(@"BlackStar");
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            
            [imageButton addGestureRecognizer:tap];

            [self addSubview:imageButton];
        }
        
        if (i == 0) {
            [imageButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0).offset(self.itemSpace);
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.width.mas_equalTo(self.mas_height);//.multipliedBy(1.0 / self.starCount);;
            }];
        } else {
            
            UIButton *preButton = [self viewWithTag:BASE_TAG + i - 1];;
            
            [imageButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(preButton.mas_right).offset(self.itemSpace);;
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.width.mas_equalTo(self.mas_height);
            }];
        }
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap {

    NSLog(@"------------------------------%@",@(tap.view.tag - BASE_TAG + 1));
    
    for (NSInteger i = BASE_TAG ; i <= tap.view.tag; ++i) {
        UIImageView *imageButton = [self viewWithTag:i];
        
        imageButton.image = CPImage(@"RedStar");
    }
    
    for (NSInteger i = tap.view.tag + 1; i < BASE_TAG + self.starCount; ++i) {
        
        UIImageView *imageButton = [self viewWithTag:i];
        imageButton.image = CPImage(@"BlackStar");
    }
    
    self.score = tap.view.tag - BASE_TAG + 1;
    
    !self.tapActionBlock ? : self.tapActionBlock(self.score);
}

@end
