//
//  CPImageLeftRightCell.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/7.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseCell.h"

@interface CPImageLeftRightCell : CPBaseCell

@property (nonatomic, copy) NSString *image, *leftValue, *rightValue;

- (void)alignRightLabel;

@end
