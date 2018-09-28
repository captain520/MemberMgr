//
//Created by ESJsonFormatForMac on 18/07/05.
//

#import "CPRecycleQuotePriceModel.h"
@implementation CPRecycleQuotePriceModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

@end

@implementation CPRecycleQuotePriceDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id", @"Typeid" : @"typeid",@"Description":@"description"};
}

@end


