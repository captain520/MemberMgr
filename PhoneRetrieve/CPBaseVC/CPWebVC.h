//
//  CPWebVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/6.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseVC.h"

@interface CPWebVC : CPBaseVC

@property (nonatomic, strong) NSString *urlStr;

@property (nonatomic, strong) NSString *contentStr;

@property (nonatomic, assign) BOOL shouldHomeItem;

@end
