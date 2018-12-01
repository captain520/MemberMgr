//
//Created by ESJsonFormatForMac on 18/10/02.
//

#import <Foundation/Foundation.h>
#import "ZCBaseModel.h"

@class DelegateFeeTotalprice,DelegateFeeData;
@interface ZCDelegateConsumModel : ZCBaseModel

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, assign) NSInteger pagesize;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger currentpage;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) DelegateFeeTotalprice *totalprice;

@property (nonatomic, assign, readonly) BOOL hasNoData;

@end
@interface DelegateFeeTotalprice : NSObject

@property (nonatomic, assign) NSInteger goodscount;

@property (nonatomic, assign) NSInteger totalprice;

@property (nonatomic, assign) NSInteger totalcommision;

@end

@interface DelegateFeeData : NSObject

@property (nonatomic, copy) NSString *Typename;

@property (nonatomic, assign) NSInteger doorid;

@property (nonatomic, copy) NSString *doorcode;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *commision;

@property (nonatomic, copy) NSString *goodsname;

@property (nonatomic, copy) NSString *currentprice;

@property (nonatomic, copy) NSString *resultno;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, assign) NSInteger goodsid;

@property (nonatomic, copy) NSString *doorname;

@end

