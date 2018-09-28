//
//  CPPickerView.h
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/9.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPPickerView : UIPickerView<UIPickerViewDelegate,UIPickerViewDataSource>

- (id)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray;
    
@property (nonatomic, strong) NSArray <NSArray *> *dataArray;

@property (nonatomic, copy) void (^selectBlock)(NSString *item);

- (void)doneAction:(id)sender;

@end
