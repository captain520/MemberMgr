//
//  CPItemPickerCenter.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/4.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPItemPickerAlert : UIView

@property (nonatomic, strong) NSMutableArray <NSArray *> *dataArray;

//  加载视图
- (void)show;

//  移除视图
- (void)dismiss;

@property (nonatomic, copy) void (^actionBlock)(NSUInteger compoent, NSUInteger row);

@end
