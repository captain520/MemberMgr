//
//  ZCMemeberSearchVC.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/17.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCBaseSearchVC.h"
#import "ZCSearchDelegateListModel.h"

@interface ZCMemeberSearchVC : ZCBaseSearchVC

@property (nonatomic, copy) void (^selectModel)(DLData *model);

@end
