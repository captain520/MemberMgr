//
//  CPItemPickerCenter.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/4.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPItemPickerAlert.h"

@interface CPItemPickerAlert()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *itemPickView;

@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, strong) UIButton *okBT, *cancelBT;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, assign) NSUInteger component, row;

@end

@implementation CPItemPickerAlert {
    UIPickerView *itemPick;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialzeBaseProperties];
        
        [self setupUI];
    }
    
    return self;
}

- (void)initialzeBaseProperties {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5f];
}

- (void)setupUI {
    
    _bgView = [UIView new];
    _bgView.backgroundColor = UIColor.whiteColor;
    _bgView.clipsToBounds = YES;
    _bgView.layer.cornerRadius = 10.0f;
    [self addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(200 + 2 * 44);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];

    _itemPickView = [UIPickerView new];
    _itemPickView.backgroundColor = UIColor.whiteColor;
    _itemPickView.delegate = self;
    _itemPickView.dataSource = self;
    _itemPickView.showsSelectionIndicator = YES;

    [self.bgView addSubview:_itemPickView];
    [_itemPickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(200);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    
    _titleLB = [UILabel new];
    _titleLB.backgroundColor = UIColor.whiteColor;
    _titleLB.textAlignment = NSTextAlignmentCenter;
    _titleLB.font = [UIFont boldSystemFontOfSize:18.0f];
    _titleLB.text = @"回收价格比例设置";

    [self.bgView addSubview:_titleLB];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_itemPickView.mas_left);
        make.right.mas_equalTo(_itemPickView.mas_right);
        make.bottom.mas_equalTo(_itemPickView.mas_top);
        make.height.mas_equalTo(44);
    }];
    
    //    分割线
    {
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;
        
        [self.bgView addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_itemPickView.mas_left);
            make.right.mas_equalTo(_itemPickView.mas_right);
            make.bottom.mas_equalTo(_itemPickView.mas_top);
            make.height.mas_equalTo(.5);
        }];
    }
    
    //    分割线
    {
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;
        
        [self.bgView addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_itemPickView.mas_left);
            make.right.mas_equalTo(_itemPickView.mas_right);
            make.top.mas_equalTo(_itemPickView.mas_bottom);
            make.height.mas_equalTo(.5);
        }];
    }
    
    //    确认按钮
    _okBT = [UIButton new];
    _okBT.backgroundColor = [UIColor whiteColor];
    _okBT.titleLabel.textColor = UIColor.blackColor;
    [_okBT setTitle:@"保存" forState:0];
    [_okBT addTarget:self action:@selector(saveAction:) forControlEvents:64];
    [self.bgView addSubview:_okBT];
    [_okBT setTitleColor:UIColor.blackColor forState:0];
    [_okBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_itemPickView.mas_bottom).offset(.5);
        make.left.mas_equalTo(_itemPickView);
        make.height.mas_equalTo(44);
    }];

    //    取消按钮
    _cancelBT = [UIButton new];
    _cancelBT.backgroundColor = UIColor.whiteColor;
    _cancelBT.titleLabel.textColor = UIColor.blackColor;
    [_cancelBT addTarget:self action:@selector(canceAction:) forControlEvents:64];
    [_cancelBT setTitle:@"取消" forState:0];
    [_cancelBT setTitleColor:UIColor.blackColor forState:0];
    [self.bgView addSubview:_cancelBT];
    [_cancelBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_okBT.mas_top);
        make.left.mas_equalTo(_okBT.mas_right).offset(.5);
        make.right.mas_equalTo(_itemPickView.mas_right);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(_okBT.mas_width);
    }];
    
    //    分割线
    {
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;
        
        [self.bgView addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_okBT.mas_right);
            make.top.mas_equalTo(_okBT.mas_top);
            make.bottom.mas_equalTo(_okBT.mas_bottom);
            make.width.mas_equalTo(.5);
        }];
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)dismiss {
    [UIView animateWithDuration:.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UIPickViewDataDelegate && UIPickViewDataDataSource method

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {return self.dataArray.count;}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSArray *tempArray = [self.dataArray objectAtIndex:component];
    return tempArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSArray *tempArray = [self.dataArray objectAtIndex:component];
    
    return [NSString stringWithFormat:@"%@%%",tempArray[row]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.component = component;
    self.row = row;
}

- (void)setDataArray:(NSMutableArray<NSArray *> *)dataArray {
    _dataArray = dataArray;
    
    [self.itemPickView reloadAllComponents];
}

- (void)canceAction:(id)sender {
    [self dismiss];
}

- (void)saveAction:(id)sender {
    !self.actionBlock ? :self.actionBlock(self.component,self.row);
    [self dismiss];
}

@end
