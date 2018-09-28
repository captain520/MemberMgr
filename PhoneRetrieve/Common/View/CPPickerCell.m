//
//  CPPickerCell.m
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/9.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "CPPickerCell.h"
#import "CPResponderButton.h"

@implementation CPPickerCell {
    UILabel *leftLB;
    CPResponderButton *pickerBT, *indictorBT;
    
    NSString *selectItem;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
   
    if (nil == leftLB) {
        
        leftLB = [UILabel new];
        leftLB.font = [UIFont systemFontOfSize:15.0f];
        leftLB.textColor = C33;

        [self.contentView addSubview:leftLB];
        
        [leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cellSpaceOffset);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(80);
        }];
    }
    
    if (nil == indictorBT) {
        
        indictorBT = [CPResponderButton new];

        [indictorBT addTarget:self action:@selector(showPickerView) forControlEvents:UIControlEventTouchUpInside];
        [indictorBT setImage:CPImage(@"arrowDown") forState:UIControlStateNormal];
        
        [self.contentView addSubview:indictorBT];
        
        [indictorBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-cellSpaceOffset);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    }
    
    if (nil == pickerBT) {
        
        pickerBT = [CPResponderButton new];
        pickerBT.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        pickerBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

        [pickerBT setTitleColor:C33 forState:UIControlStateNormal];
        [pickerBT addTarget:self action:@selector(showPickerView) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:pickerBT];
        
        [pickerBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftLB.mas_right).offset(6);
            make.right.mas_equalTo(indictorBT.mas_left).offset(-6);;
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
    }
    
    {
        UIToolbar *tool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44.0f)];
        tool.backgroundColor = MainColor;
        self.inputAccessoryView = tool;
        
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                  target:self
                                                                                  action:nil];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                     style:0
                                                                    target:self
                                                                    action:@selector(doneAction:)];
        
        tool.items = @[flexItem,doneItem];
        
    }
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    leftLB.text = title;
}

- (void)setSubTitle:(NSString *)subTitle {
    
    _subTitle = subTitle;
    
    [pickerBT setTitle:subTitle forState:UIControlStateNormal];
    
}

#pragma mark - Private method

- (void)showPickerView {
    
    [UIView animateWithDuration:0.25f animations:^{
        indictorBT.transform = CGAffineTransformMakeRotation(M_PI);
    }];

    [self becomeFirstResponder];
}

- (void)doneAction:(id)sender {
    [UIView animateWithDuration:0.25f animations:^{
        indictorBT.transform = CGAffineTransformMakeRotation(0);
    }];
    
    CPPickerView *pickerView =(CPPickerView *)self.inputView;
    if (pickerView) {
        [pickerView doneAction:nil];
    }

    [self resignFirstResponder];
}

@end
