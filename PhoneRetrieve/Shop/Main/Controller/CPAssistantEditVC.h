//
//  CPAssistantEditVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/8.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseVC.h"
//#import "CPMemeberListModel.h"
//#import "CPMemeberListModel.h"

typedef NS_ENUM(NSUInteger,CPAssistantActionType) {
    CPAssistantActionTypeAdd,               //  新增
    CPAssistantActionTypeEdit,              //  编辑修改
    CPAssistantActionTypeOther,             //  预留
};

@interface CPAssistantEditVC : CPBaseVC

@property (nonatomic ,assign) CPAssistantActionType type;
@property (nonatomic, copy) NSString *userid;

//@property (nonatomic, strong) CPMemeberListModel *model;

@end
