//
//Created by ESJsonFormatForMac on 18/10/02.
//

#import "ZCDelegateConsumModel.h"
@implementation ZCDelegateConsumModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [DelegateFeeData class]};
}


- (BOOL)hasNoData {
    return self.currentpage * self.pagesize >= self.total;
}

@end

@implementation DelegateFeeTotalprice

@end


@implementation DelegateFeeData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id",@"Typename" : @"typename"};
}

@end


