//
//  CPTabBarView.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

@interface CPTabBarView : UIView

@property (nonatomic, strong) NSArray <NSString *> *dataArray;

@property (nonatomic, strong) UIColor *bottomLineColor, *selectedColor;

@property (nonatomic, copy) void (^selectBlock)(NSInteger index);

@property (nonatomic, assign) NSInteger currentIndex;

@end
