//
//  CPMemberOrderDetailFooter.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPHeaderFooter.h"
#import "CPMemberOrderDetailModel.h"

@interface CPMemberOrderDetailFooter : CPHeaderFooter

@property (nonatomic, copy) void (^checkReportAction)(void);

@property (nonatomic, strong) CPMemberOrderDetailModel *model;

@end
