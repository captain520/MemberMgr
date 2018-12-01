//
//Created by ESJsonFormatForMac on 18/11/16.
//

#import <Foundation/Foundation.h>
#import "ZCBaseModel.h"

@class MSReasonData;
@interface MSRejectReasonModel : ZCBaseModel

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, assign) NSInteger provinceid;

@end

