//
//  CPTabBarView.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCTabBarView.h"

@implementation ZCTabBarView {
    CALayer *bottomLayer;
}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

- (void)setDataArray:(NSArray<NSString *> *)dataArray {
   
    _dataArray = dataArray;
    
    [self setupUI];
}

- (void)setupUI {
    
    CGFloat width = SCREENWIDTH / _dataArray.count;

    [_dataArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *tabButton = [UIButton new];
        tabButton.tag = idx + CPBASETAG;
        [tabButton setTitleColor:C33 forState:UIControlStateNormal];
        [tabButton setTitleColor:self->_selectedColor? _selectedColor : MainColor forState:UIControlStateSelected];
        [tabButton setTitle:obj forState:0];
        [tabButton addTarget:self action:@selector(buttonAction:) forControlEvents:64];
        [self addSubview:tabButton];
        
        [tabButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(idx * width);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(width);
        }];
    }];
    
    {
        bottomLayer = [CALayer layer];
        bottomLayer.frame = CGRectMake(0, self.bounds.size.height, width, 1.0f);
        bottomLayer.backgroundColor = _bottomLineColor ? _bottomLineColor.CGColor : MainColor.CGColor;
        [self.layer insertSublayer:bottomLayer atIndex:0];
    }
    
    [self updateAt:CPBASETAG];
}

- (void)buttonAction:(UIButton *)sender {
    DDLogInfo(@"-----%s:%@",__FUNCTION__,@(sender.tag - CPBASETAG));

    [self updateAt:sender.tag];
    
    !self.selectBlock ? : self.selectBlock(sender.tag - CPBASETAG);
}

- (void)updateAt:(NSInteger)tag {
    
    CGFloat width = SCREENWIDTH / _dataArray.count;
    
//    UIButton *firstBT = [self viewWithTag:tag];
//    firstBT.selected = YES;
    
    [self.dataArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *bt = [self viewWithTag:idx + CPBASETAG];
        bt.selected = (tag == idx + CPBASETAG);
    }];
    
    bottomLayer.frame = CGRectMake(width * (tag - CPBASETAG), self.bounds.size.height-2, width, 2.0f);
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor {
    
    _bottomLineColor = bottomLineColor;
    
    bottomLayer.backgroundColor = _bottomLineColor.CGColor;
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    
    _selectedColor = selectedColor;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    
    [self updateAt:_currentIndex + CPBASETAG];
}

@end
