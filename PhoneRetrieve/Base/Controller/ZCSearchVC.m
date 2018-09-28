//
//  ZCSearchVC.m
//  MemberManager
//
//  Created by 王璋传 on 2018/9/13.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCSearchVC.h"
#import "ZCDatePickerTF.h"

@interface ZCSearchVC ()

@property (nonatomic, strong) ZCDatePickerTF *beginDateTF, *endDateTF;

@end

@implementation ZCSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    
    
    ZCLabel *beginHintLB = [ZCLabel new];
    beginHintLB.text = @"开始时间:";
    [self.view addSubview:beginHintLB];
    [beginHintLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SPACE_OFFSET_F);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
    }];

    self.beginDateTF = [ZCDatePickerTF new];

    [self.view addSubview:self.beginDateTF];
    [_beginDateTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(beginHintLB.mas_bottom).offset(SPACE_OFFSET_F/2);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];
    
    ZCLabel *endHintLB = [ZCLabel new];
    endHintLB.text = @"结束时间:";
    [self.view addSubview:endHintLB];
    [endHintLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.beginDateTF.mas_bottom).offset(SPACE_OFFSET_F);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
    }];
    
    self.endDateTF = [ZCDatePickerTF new];

    [self.view addSubview:self.endDateTF];
    [self.endDateTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(endHintLB.mas_bottom).offset(SPACE_OFFSET_F/2);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];
    
    ZCButton *actionBT = [ZCButton new];
    [actionBT setTitle:@"搜索" forState:0];
    
    [self.view addSubview:actionBT];
    [actionBT addTarget:self action:@selector(searchAction) forControlEvents:64];
    [actionBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.endDateTF.mas_bottom).offset(CELL_HEIGHT_F);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];
}

- (void)searchAction {
    [self.view endEditing:YES];
}

@end
