//
//  CPAssistantInfoCell.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/8.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseCell.h"
#import "CPMemeberListModel.h"

typedef NS_ENUM(NSUInteger, CPAssistantInfoCellActionType) {
   CPAssistantInfoCellActionTypeDetail = 9527,
   CPAssistantInfoCellActionTypeEdit,
   CPAssistantInfoCellActionTypeDelete
};

@interface CPAssistantInfoCell : CPBaseCell

@property (nonatomic, copy) void (^actionBlock)(CPAssistantInfoCellActionType actionType);

@property (nonatomic, strong) CPMemeberListModel *model;

@end
