//
//  CPTextField.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CPTextFieldActionType) {
    CPTextFieldActionTypeNone,
    CPTextFieldActionTypeLeftAction,
    CPTextFieldActionTypeRightAction,
    CPTextFieldActionTypeLeftAndRightAction
};

@protocol CPTextFieldDelegate<NSObject>

@end


@interface CPTextField : UITextField

@property (nonatomic, weak) id <CPTextFieldDelegate> cp_delegate;

@property (nonatomic, assign) CPTextFieldActionType actionType;

@property (nonatomic, copy) NSString *leftActionImageName, *rightActionImageName;

@end
