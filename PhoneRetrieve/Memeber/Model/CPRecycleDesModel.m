//
//Created by ESJsonFormatForMac on 18/07/05.
//

#import "CPRecycleDesModel.h"
@implementation CPRecycleDesModel

+ (NSDictionary *)objectClassInArray{
    return @{@"cp_data" : [CPRecycleDesModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Description" : @"description",@"cp_data" : @"data", @"cp_code" : @"code",@"ID" : @"id" };
}

@end
