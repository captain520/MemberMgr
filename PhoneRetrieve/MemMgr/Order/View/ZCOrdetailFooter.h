//
//  ZCOrdetailFooter.h
//  MemberManager
//
//  Created by 王璋传 on 2018/9/14.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCTableViewHeaderFooterView.h"

@interface ZCOrdetailFooter : ZCTableViewHeaderFooterView

@property (nonatomic, copy) void (^checkReportAction)(void);

@end
