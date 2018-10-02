//
//Created by ESJsonFormatForMac on 18/09/30.
//

#import <Foundation/Foundation.h>
#import "ZCBaseModel.h"

@class Oldbankinfo,Areainfo;
@interface ZCUserDetailModel : ZCBaseModel

@property (nonatomic, assign) NSInteger doorid;

@property (nonatomic, copy) NSString *bname;

@property (nonatomic, assign) NSInteger agentid;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *default_pgprice_pre;

@property (nonatomic, assign) NSInteger checkid;

@property (nonatomic, copy) NSString *pgprice_pre;

@property (nonatomic, copy) NSString *bankbranch;

@property (nonatomic, copy) NSString *linkname;

@property (nonatomic, copy) NSString *checkcode;

@property (nonatomic, assign) NSInteger shopid;

@property (nonatomic, copy) NSString *checkname;

@property (nonatomic, strong) Oldbankinfo *oldbankinfo;

@property (nonatomic, assign) NSInteger statuscfg;

@property (nonatomic, assign) NSInteger paycfg;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *idcard1url;

@property (nonatomic, copy) NSString *idcard2url;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *licenseurl;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *banknum;

@property (nonatomic, copy) NSString *checktime;

@property (nonatomic, copy) NSString *commission;

@property (nonatomic, strong) Areainfo *areainfo;

@property (nonatomic, copy) NSString *totalcommission;

@property (nonatomic, assign) NSInteger typeid;

@property (nonatomic, copy) NSString *companyname;

@property (nonatomic, copy) NSString *bankname;

@property (nonatomic, copy) NSString *address;

@end

@interface Oldbankinfo : NSObject

@property (nonatomic, copy) NSString *bname;

@property (nonatomic, copy) NSString *bankname;

@property (nonatomic, copy) NSString *banknum;

@end

@interface Areainfo : NSObject

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, copy) NSString *districtname;

@property (nonatomic, copy) NSString *cityname;

@property (nonatomic, assign) NSInteger districtid;

@property (nonatomic, copy) NSString *provincename;

@property (nonatomic, assign) NSInteger cityid;

@end

