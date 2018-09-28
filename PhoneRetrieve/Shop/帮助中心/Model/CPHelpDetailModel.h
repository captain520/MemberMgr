//
//  CPHelpDetailModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/22.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@interface CPHelpDetailModel : CPBaseModel

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *Description;

@end
