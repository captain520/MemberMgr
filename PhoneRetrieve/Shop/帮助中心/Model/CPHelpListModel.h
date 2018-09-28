//
//  CPHelpListModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/21.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@interface CPHelpListModel : CPBaseModel

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *Description;

@end

