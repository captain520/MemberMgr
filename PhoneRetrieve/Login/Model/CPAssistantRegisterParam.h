//
//  CPAssistantRegisterParam.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/6.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPAssistantRegisterParam : NSObject

@property (nonatomic, copy) NSString *linkname,*phone, *code, *sms, *password, *idcard1url, *idcard2url;

+ (instancetype)shareInstance;

@end
