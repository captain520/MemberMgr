//
//Created by ESJsonFormatForMac on 18/07/05.
//

#import <Foundation/Foundation.h>
#import "CPBaseModel.h"

@interface CPRecycleQuotePriceModel : CPBaseModel

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger typecfg;

@end


@interface CPRecycleQuotePriceDetailModel : CPBaseModel

@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *Typeid;
@property (nonatomic,copy) NSString *imageurl;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *Description;
@property (nonatomic,copy) NSString *createtime;

@end
