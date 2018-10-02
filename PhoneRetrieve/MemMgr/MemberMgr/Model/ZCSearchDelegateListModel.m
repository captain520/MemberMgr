//
//Created by ESJsonFormatForMac on 18/09/28.
//

#import "ZCSearchDelegateListModel.h"
@implementation ZCSearchDelegateListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [DLData class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Code" : @"code"};
}

- (BOOL)isHasNoData {
    return self.currentpage * self.pagesize >= self.total;
}

@end

@implementation DLData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Typeid" : @"typeid", @"ID" : @"id"};
}

@end


