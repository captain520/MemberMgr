//
//  CPTextField.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPTextField.h"

@interface CPTextField()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *leftActionBT, *rightActionBT;

@end

@implementation CPTextField

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        [self initializedBaseProperties];
        [self setupUILeftAndRightView];
        [self setupUI];
    }
    
    return self;
}

- (void)initializedBaseProperties {
    self.font = CPFont_M;
    self.borderStyle = UITextBorderStyleRoundedRect;
}

- (void)setupUILeftAndRightView {
   
    _leftActionBT = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height)];
    [_leftActionBT addTarget:self action:@selector(leftAction:) forControlEvents:64];
    self.leftView = _leftActionBT;
    
    _rightActionBT = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CELL_HEIGHT_F, CELL_HEIGHT_F)];
//    _rightActionBT.backgroundColor = [UIColor redColor];
    [_rightActionBT addTarget:self action:@selector(rightAction:) forControlEvents:64];
    self.rightView = _rightActionBT;
}

- (void)setupUI {
    
}

- (void)setActionType:(CPTextFieldActionType)actionType {
    
    _actionType = actionType;
    
    switch (actionType) {
        case CPTextFieldActionTypeLeftAction:
        {
            self.leftViewMode = UITextFieldViewModeAlways;
            self.rightViewMode = UITextFieldViewModeNever;
        }
            break;
        case CPTextFieldActionTypeRightAction:
        {
            self.leftViewMode= UITextFieldViewModeNever;
            self.rightViewMode= UITextFieldViewModeAlways;
        }
            break;
            
        case CPTextFieldActionTypeLeftAndRightAction:
        {
            self.leftViewMode= UITextFieldViewModeAlways;
            self.rightViewMode= UITextFieldViewModeAlways;
        }
            break;
        default:
            break;
    }
}

- (void)setLeftActionImageName:(NSString *)leftActionImageName {
    
    _leftActionImageName = leftActionImageName;
    
    [self.leftActionBT setImage:CPImage(_leftActionImageName) forState:0];
}

- (void)setRightActionImageName:(NSString *)rightActionImageName {
    
    _rightActionImageName = rightActionImageName;
    
    [self.rightActionBT setImage:CPImage(_rightActionImageName) forState:0];
//    [self.rightActionBT setBackgroundImage:CPImage(_rightActionImageName) forState:0];
    
}

#pragma mark - UITextFieldDelegate method

- (void)leftAction:(UIButton *)sender {
    NSLog(@"%s",__FUNCTION__);
    
    [self becomeFirstResponder];
}

- (void)rightAction:(UIButton *)sender {
    NSLog(@"%s",__FUNCTION__);
    [self becomeFirstResponder];
}

@end
