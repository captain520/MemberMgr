//
//  CPResultVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/26.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseTableVC.h"

@interface CPResultVC : CPBaseTableVC

@property (nonatomic,copy) void (^actionBlock)(void);

- (void)updateWithDataArray:(NSArray *)dataArray;

@end
