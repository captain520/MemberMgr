//
//  CPMemeberListModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/24.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@interface CPMemeberListModel : CPBaseModel

@property (nonatomic, assign) NSInteger typeid;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *Code;

@property (nonatomic, copy) NSString *linkname;

@property (nonatomic, copy) NSString *companyname;

@end

