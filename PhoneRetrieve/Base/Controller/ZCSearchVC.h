//
//  ZCSearchVC.h
//  MemberManager
//
//  Created by 王璋传 on 2018/9/13.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCBaseVC.h"

@interface ZCSearchVC : ZCBaseVC

@property (nonatomic,strong) void (^loadDataBlock)(id data);

@end
