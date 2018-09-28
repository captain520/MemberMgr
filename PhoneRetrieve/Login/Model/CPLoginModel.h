//
//  CPLoginModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

typedef NS_ENUM(NSInteger,CPUserType) {
   CPUserTypeDelegate       =   1,
   CPUserTypeMerchant,
   CPUserTypeShop,
   CPUserTypeAssistant,
   CPUserTypeOther,
};

@interface CPLoginModel : CPBaseModel

@property (nonatomic, assign) NSInteger Typeid;         //1代理，2商家，3门店，4店员

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) NSInteger cityid;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *linkname;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, assign) NSInteger districtid;

@property (nonatomic, copy) NSString *companyname;

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, copy) NSString *cp_code;

@end

