//
//  ZCDatePickerTF.m
//  MemberManager
//
//  Created by 王璋传 on 2018/9/13.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCDatePickerTF.h"

@implementation ZCDatePickerTF {
    UIDatePicker *datePicker;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setupUI {
    
    {
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.text = cp_date2String([NSDate date], @"yyyy/MM/dd HH:mm:ss");
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = C33;
        self.tintColor = UIColor.clearColor;
        
        datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        datePicker.maximumDate = [NSDate date];
        
        self.inputView = datePicker;
        
        self.delegate = self;
    }
    
    UIButton *actionBT = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CELL_HEIGHT_F, CELL_HEIGHT_F)];
    [actionBT setImage:[UIImage imageNamed:@"calendar"] forState:0];
    
    [actionBT addTarget:self action:@selector(rightAction) forControlEvents:64];


    self.rightView = actionBT;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.text = cp_date2String(datePicker.date, @"yyyy/MM/dd HH:mm:ss");
}

- (void)rightAction {
    [self becomeFirstResponder];
}

@end
