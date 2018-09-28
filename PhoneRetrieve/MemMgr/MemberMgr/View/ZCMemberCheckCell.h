//
//  ZCMemberCheckCell.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/17.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCTableViewCell.h"

@interface ZCMemberCheckCell : ZCTableViewCell

@property (nonatomic, copy) void (^checkBlock)(void);

@end
