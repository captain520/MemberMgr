//
//  CPMemeberOrderCell.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseCell.h"
#import "CPOrderListPageModel.h"

@interface CPMemeberOrderCell : CPBaseCell

@property (nonatomic, copy) void (^seeDetailAction)(void);
@property (nonatomic, copy) void (^checkConsignBlock)(void);

@property (nonatomic, strong) CPShopOrderDetailModel *model;

@end
