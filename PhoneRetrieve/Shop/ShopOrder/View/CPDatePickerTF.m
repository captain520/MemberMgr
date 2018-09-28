//
//  CPDatePickerTF.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPDatePickerTF.h"

@interface CPDatePickerTF()<UITextFieldDelegate>

@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation CPDatePickerTF

- (void)setupUI {
    
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    self.datePicker.maximumDate = [NSDate date];
    
    self.inputView = self.datePicker;
    self.delegate = self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.text = cp_date2String(self.datePicker.date, @"yyyy/MM/dd HH:mm:ss");

}

@end
