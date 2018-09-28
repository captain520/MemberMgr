//
//  CPCheckBox.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPView.h"

@interface CPCheckBox : CPView

@property (nonatomic, copy) NSAttributedString *content;

@property (nonatomic, copy) void (^actionBlock)(BOOL aggree);
@property (nonatomic, copy) void (^showHintBlock)(void);

@end
