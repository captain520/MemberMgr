//
//  CPTitleDetailCell.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseCell.h"

@interface CPTitleDetailCell : CPBaseCell

@property (nonatomic, copy) NSString *title, *content;

@property (nonatomic, strong) CPCommonButtn *actionBT;

@property (nonatomic, strong) UIColor *contentColor;

@end
