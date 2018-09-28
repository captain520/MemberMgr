//
//  CPSelectCell.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseCell.h"

@interface CPSelectCell : CPBaseCell

@property (nonatomic, assign) BOOL hasSelected;
@property (nonatomic, copy) NSString *content;

@end
