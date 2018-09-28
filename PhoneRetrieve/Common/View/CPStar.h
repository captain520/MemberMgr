//
//  CPStar.h
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/16.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPStar : UIView

@property (nonatomic,assign) NSInteger starCount;
@property (nonatomic, assign) NSInteger itemSpace;
@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, copy) void (^tapActionBlock)(NSInteger score);

@property (nonatomic, assign) NSInteger score;

@end
