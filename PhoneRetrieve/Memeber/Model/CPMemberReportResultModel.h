//
//Created by ESJsonFormatForMac on 18/07/11.
//

#import <Foundation/Foundation.h>

@class CPMemberReportResultCheckjson,CPMemberReportResultJsonData;
@interface CPMemberReportResultModel : CPBaseModel

@property (nonatomic, assign) NSInteger checkcfg;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSArray *checkjson;

@property (nonatomic, copy) NSString *customimei;

@property (nonatomic, copy) NSString *goodsname;

@property (nonatomic, copy) NSString *resultno;

@end

@interface CPMemberReportResultCheckjson : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *reportid;

@property (nonatomic, strong) NSArray <CPMemberReportResultJsonData *> *data;

@end

@interface CPMemberReportResultJsonData : NSObject

@property (nonatomic, copy) NSString *reportitemid;

@property (nonatomic, copy) NSString *name;

//@property (nonatomic, copy) NSString *kouprice;

//@property (nonatomic, copy) NSString *checkremark;

@property (nonatomic, copy) NSString *imageurl;

@property (nonatomic, assign) NSUInteger checkcfg;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *price;

@end

