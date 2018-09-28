//
//  CPSelectTextField.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPSelectTextField.h"

@implementation CPSelectTextField

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.delegate = self;
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {

    self.rightViewMode = UITextFieldViewModeAlways;
    self.borderStyle = UITextBorderStyleRoundedRect;
    self.clipsToBounds = YES;
    self.tintColor = UIColor.clearColor;
    
    UIButton *downArrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height)];
    [downArrow setImage:CPImage(@"home_down") forState:UIControlStateNormal];
    [downArrow addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightView = downArrow;
    
    {
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 220)];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        
        self.inputView = self.pickerView;
    }
}

- (void)buttonAction:(UIButton *)sender {
    [self becomeFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    DDLogInfo(@"%s",__FUNCTION__);
    
    if (self.cp_editDelegate && [self.cp_editDelegate respondsToSelector:@selector(cp_textFieldDidBeginEditing:model:)]) {
        [self.cp_editDelegate cp_textFieldDidBeginEditing:textField model:nil];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
   
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    CPProviceCityAreaModel *model = self.dataArray[row];
//    textField.text = self.dataArray[[self.pickerView selectedRowInComponent:0] ];
    if (self.type == 0) {
        textField.text = model.province;
    } else if (1 == self.type) {
        textField.text = model.city;
    } else {
        textField.text = model.district;
    }

    DDLogInfo(@"%@",textField.text);
    if (self.cp_editDelegate && [self.cp_editDelegate respondsToSelector:@selector(cp_textFieldDidEndEditing:model:)]) {
        [self.cp_editDelegate cp_textFieldDidEndEditing:textField model:model];
    }
    
}

#pragma mark - delegate and datasouce

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    CPProviceCityAreaModel *model = self.dataArray[row];
    
    if (self.type == 0) {
        return model.province;
    } else if (1 == self.type) {
        return model.city;
    } else {
        return model.district;
    }
}

@end
