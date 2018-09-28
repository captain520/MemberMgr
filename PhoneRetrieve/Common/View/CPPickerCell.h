//
//  CPPickerCell.h
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/9.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "CPBaseCell.h"
#import "CPPickerView.h"
#import "CPResponderCell.h"

@interface CPPickerCell : CPResponderCell<UIPickerViewDelegate>

@property (nonatomic, copy) NSString *title, *subTitle;

@end
