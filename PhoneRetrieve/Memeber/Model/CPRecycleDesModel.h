//
//Created by ESJsonFormatForMac on 18/07/05.
//

#import <Foundation/Foundation.h>

#import "CPBaseModel.h"

@interface CPRecycleDesModel : CPBaseModel

@property (nonatomic, assign) NSInteger cp_code;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray *cp_data;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, assign) NSInteger parentid;

@end

