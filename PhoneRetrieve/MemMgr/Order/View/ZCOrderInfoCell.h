//
//  ZCOrderInfoCell.h
//  MemberManager
//
//  Created by 王璋传 on 2018/9/14.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCTableViewCell.h"

@interface ZCOrderInfoCell : ZCTableViewCell

@property (nonatomic, copy) void (^seeDetailAction)(void);
@property (nonatomic, copy) void (^checkConsignBlock)(void);

@end
