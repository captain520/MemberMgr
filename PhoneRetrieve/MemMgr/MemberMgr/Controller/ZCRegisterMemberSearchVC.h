//
//  ZCRegisterMemberSearchVC.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/10/16.
//  Copyright © 2018 Captain. All rights reserved.
//

#import "ZCBaseSearchVC.h"
#import "ZCSearchDelegateListModel.h"

@interface ZCRegisterMemberSearchVC : ZCBaseSearchVC

@property (nonatomic, copy) void (^selectModel)(DLData *model);

@end
