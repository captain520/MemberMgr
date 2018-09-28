//
//  ZZStartView.m
//  ZhiZaiDemo
//
//  Created by wangzhangchuan on 2017/11/21.
//  Copyright © 2017年 wangzhangchuan. All rights reserved.
//

#import "CPStartView.h"

@interface CPStartView()

@property (nonatomic, strong) UIView *starMaskView;

@end

@implementation CPStartView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    CGFloat width = (self.bounds.size.width) / 5;
    CGFloat height = self.frame.size.height;
    
    for (NSInteger i = 0; i < 5; ++i) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        imageView.image = [UIImage imageNamed:@"BlackStar"];
        imageView.contentMode = UIViewContentModeScaleAspectFit;

        [self addSubview:imageView];
    }
    
}

- (UIView *)starMaskView {
    
    if (nil == _starMaskView) {
        
        _starMaskView = [[UIView alloc] initWithFrame:CGRectZero];
        _starMaskView.clipsToBounds = YES;
        
        CGFloat width = (self.bounds.size.width) / 5;
        CGFloat height = self.frame.size.height;
        
        for (NSInteger i = 0; i < 5; ++i) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
            imageView.image = [UIImage imageNamed:@"RedStar"];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            
            [_starMaskView addSubview:imageView];
        }
        
        [self addSubview:_starMaskView];
    }
    
    return _starMaskView;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self updateStarRate:touches];

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self updateStarRate:touches];
}

- (void)updateStarRate:(NSSet <UITouch *> *)touches {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    if (!CGRectContainsPoint(self.bounds, point)) {
        return;
    }

    [UIView animateWithDuration:0.25f animations:^{
        self.starMaskView.frame = CGRectMake(0, 0, point.x, self.bounds.size.height);
    } completion:^(BOOL finished) {
        NSInteger score = point.x / self.bounds.size.width * 5 * 100;
        !self.actionBlock ? : self.actionBlock(MIN(score,500));
    }];
}

@end
