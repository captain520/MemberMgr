//
//  CPMainActionButton.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/1.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPCommonButtn.h"

typedef NS_ENUM(NSUInteger, CPMainActionButtonType) {
    CPMainActionButtonTypeRetrivePhone,     //  手机回收
    CPMainActionButtonTypeRetrivePad,       //  iPad回收
    CPMainActionButtonTypeCart,             //  回收车
    CPMainActionButtonTypeAssisManager,     //  店员管理
    CPMainActionButtonTypeRetriveFlow,      //  回收流程
    CPMainActionButtonTypeRetriveDes,       //  回收说明
    CPMainActionButtonTypeOther             //  预留类型
};


@interface CPMainActionButton : CPCommonButtn

@property (nonatomic, assign) CPMainActionButtonType type;

@end
