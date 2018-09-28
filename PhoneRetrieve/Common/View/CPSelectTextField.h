//
//  CPSelectTextField.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPTextField.h"
#import "CPProviceCityAreaModel.h"

@protocol CPSelectTextFieldDelegat <NSObject>

- (void)cp_textFieldDidBeginEditing:(UITextField *)textField model:(CPProviceCityAreaModel *)model;
- (void)cp_textFieldDidEndEditing:(UITextField *)textField model:(CPProviceCityAreaModel *)model;
    
@end


@interface CPSelectTextField : CPTextField<UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSArray <CPProviceCityAreaModel *>*dataArray;

@property (nonatomic, weak) id cp_editDelegate;

@property (nonatomic, assign) NSInteger type; // 0: provice 1: city 2:area


@end
