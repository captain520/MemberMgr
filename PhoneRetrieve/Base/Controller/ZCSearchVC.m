//
//  ZCSearchVC.m
//  MemberManager
//
//  Created by 王璋传 on 2018/9/13.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCSearchVC.h"
#import "ZCDatePickerTF.h"
#import "ZCDelegateConsumModel.h"

@interface ZCSearchVC ()

@property (nonatomic, strong) ZCDatePickerTF *beginDateTF, *endDateTF;

@end

@implementation ZCSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"服务费查询"];
    
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
    
    [self loadData];
}

- (void)loadData {
    
    NSMutableDictionary *params = @{
                                    @"agentid" : USER_ID,
                                    @"starttime" : self.beginDateTF.text,
                                    @"endtime" : self.endDateTF.text,
                                    @"currentpage" : @(1),
                                    @"pagesize" : @"100",
                                    }.mutableCopy;
    
    __weak typeof(self) weakSelf = self;
    
    [ZCDelegateConsumModel modelRequestPageWith:DOMAIN_ADDRESS@"/api/Reportresultcommision/findPageList"
                                     parameters:params
                                          block:^(id  _Nonnull result) {
                                              [weakSelf handleLoadDataSuccessBlock:result];
                                          } fail:^(CPError * _Nonnull error) {
                                              
                                          }];
}

- (void)handleLoadDataSuccessBlock:(ZCDelegateConsumModel *)result {
    
    if (!result || ![result.data isKindOfClass:[NSArray class]] || result.data.count == 0) {
        
        [self.view makeToast:@"未获取到数据" duration:2.0f position:CSToastPositionCenter];

        return;
    }
    
    !self.loadDataBlock ? : self.loadDataBlock(result);
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
