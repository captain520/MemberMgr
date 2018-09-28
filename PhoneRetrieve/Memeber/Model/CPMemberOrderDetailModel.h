//
//Created by ESJsonFormatForMac on 18/07/11.
//

#import <Foundation/Foundation.h>
#import "CPBaseModel.h"

@interface CPMemberOrderDetailModel : CPBaseModel

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *customimei;

@property (nonatomic, copy) NSString *Typename;

@property (nonatomic, copy) NSString *brandname;

@property (nonatomic, copy) NSString *currentprice;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger checkcfg;

@property (nonatomic, copy) NSString *sfprice;

@property (nonatomic, copy) NSString *resultno;

@property (nonatomic, assign) NSInteger doorid;

@property (nonatomic, copy) NSString *goodsurl;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, assign) NSInteger goodsid;

@property (nonatomic, assign) NSInteger paycfg;

@property (nonatomic, copy) NSString *ptprice;

@property (nonatomic, copy) NSString *yfprice;

@property (nonatomic, assign) BOOL yfpaycfg;

@property (nonatomic, copy) NSString *goodsname;


@end

