//
//  CPAssistanteOrderDetailModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/19.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@interface CPAssistanteOrderDetailModel : CPBaseModel


@property (nonatomic, copy) NSString *username;

@property (nonatomic, assign) NSInteger doorid;

@property (nonatomic, assign) NSInteger agentid;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *paytime;

@property (nonatomic, assign) NSInteger sendcfg;

@property (nonatomic, assign) NSInteger repaircfg;

@property (nonatomic, copy) NSString *Typename;

@property (nonatomic, copy) NSString *sendtime;

@property (nonatomic, assign) NSInteger shopid;

@property (nonatomic, copy) NSString *customname;

@property (nonatomic, copy) NSString *customphone;

@property (nonatomic, copy) NSString *resultjson;

@property (nonatomic, copy) NSString *customimei;

@property (nonatomic, copy) NSString *shopname;

@property (nonatomic, assign) BOOL statuscfg;

@property (nonatomic, assign) NSInteger paycfg;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *goodsname;

@property (nonatomic, copy) NSString *agentname;

@property (nonatomic, copy) NSString *goodsurl;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, assign) NSInteger goodsid;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *statuscfgtime;

@property (nonatomic, copy) NSString *resultno;

@property (nonatomic, copy) NSString *doorname;

@end

