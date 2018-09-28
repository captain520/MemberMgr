//
//  CPRegistParam.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPRegistParam : NSObject

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *sms;
@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *code, *companyname, *provinceid, *cityid, *districtid, *address,*linkname, *email, *licenseurl, *idcard1url, *idcard2url;

@property (nonatomic, copy) NSString *bname,*bankname, *banknum, *bankbranch, *wxname, *wxnum, *aliname, *alinum, *paycfg;

@property (nonatomic, copy) NSString *push_token;
@property (nonatomic, copy) NSString *type;

+ (instancetype)shareInstance;

@end
