//
//  ZCSubAccountCell.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/19.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCTableViewCell.h"
#import "ZCSearchDelegateListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCSubAccountCell : ZCTableViewCell

@property (nonatomic, strong) DLData *model;
@property (nonatomic, copy) void (^checkInBlock)(DLData *model);
@property (nonatomic, copy) void (^modifyBlock)(DLData *model);
@property (nonatomic, copy) void (^deleteBlock)(DLData *model);
@end

NS_ASSUME_NONNULL_END
