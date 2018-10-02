//
//Created by ESJsonFormatForMac on 18/09/28.
//

#import <Foundation/Foundation.h>
#import "ZCBaseModel.h"

@class DLData;
@interface ZCSearchDelegateListModel : ZCBaseModel

@property (nonatomic, assign) NSInteger Code;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger currentpage;

@property (nonatomic, assign) NSInteger pagesize;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign, readonly) NSInteger hasNoData;

@end
@interface DLData : NSObject

@property (nonatomic, assign) NSInteger Typeid;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *linkname;

@property (nonatomic, assign) NSInteger checkcfg;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, copy) NSString *companyname;

@property (nonatomic, copy) NSString *prelinkname;

@property (nonatomic, assign) NSInteger statuscfg;

@property (nonatomic, assign) BOOL belongcfg;

@end

