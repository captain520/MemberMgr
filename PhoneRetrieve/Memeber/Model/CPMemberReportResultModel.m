//
//Created by ESJsonFormatForMac on 18/07/11.
//

#import "CPMemberReportResultModel.h"
@implementation CPMemberReportResultModel

+ (NSDictionary *)objectClassInArray{
    return @{@"checkjson" : [CPMemberReportResultCheckjson class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

@end


@implementation CPMemberReportResultCheckjson

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [CPMemberReportResultJsonData class]};
}

@end


@implementation CPMemberReportResultJsonData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Description" : @"description"};
}

@end


