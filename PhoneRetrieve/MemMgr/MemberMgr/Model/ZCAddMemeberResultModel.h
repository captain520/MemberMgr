//
//Created by ESJsonFormatForMac on 18/09/28.
//

#import <Foundation/Foundation.h>
#import "ZCBaseModel.h"

@class AMData;
@interface ZCAddMemeberResultModel : ZCBaseModel

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) AMData *data;

@property (nonatomic, assign) NSInteger Code;

@end
@interface AMData : NSObject

@property (nonatomic, assign) NSInteger typeid;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) NSInteger cityid;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *Code;

@property (nonatomic, copy) NSString *linkname;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, assign) NSInteger districtid;

@property (nonatomic, copy) NSString *companyname;

@property (nonatomic, assign) NSInteger provinceid;

@end

