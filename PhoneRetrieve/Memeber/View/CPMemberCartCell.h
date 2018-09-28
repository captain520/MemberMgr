//
//  CPMemberCartCell.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/14.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseCell.h"
#import "CPCartModel.h"

@interface CPMemberCartCell : CPBaseCell

@property (nonatomic, assign) BOOL hasSelected;
@property (nonatomic, assign) BOOL canEdit;

@property (nonatomic, strong) CPCartModel *model;

@property (nonatomic, copy) void (^actionBlock)(void);

@end
