//
//  CPRateControlVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/14.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRateControlVC.h"
#import "CPMemberRateListModel.h"

@interface CPRateControlVC ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *itemPickView;

@property (nonatomic, strong) UIButton *saveButton;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSArray <CPMemberRateListModel *> *rateModels;


@end

@implementation CPRateControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = [NSString stringWithFormat:@"会员号：%@",[CPUserInfoModel shareInstance].loginModel.cp_code];
    self.navigationItem.leftBarButtonItem = nil;
    
    [self initialzedBaseProperties];
    [self setupUI];
    
    [self loadMemberRateList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self updateCurrentIndictor];
}

- (void)initialzedBaseProperties {
//    self.dataArray = @[
//                       @[
//                           @"11111",
//                           @"11111",
//                           @"11111",
//                           @"11111",
//                           @"11111"
//                           ]
//                       ];
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)setupUI {
    
    CPLabel *titleLB = [CPLabel new];
    titleLB.text = @"单次回收价格比例";
    titleLB.font = [UIFont boldSystemFontOfSize:25];
    [self.view addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT + cellSpaceOffset);
        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(0);
        make.height.mas_equalTo(2 * CELL_HEIGHT_F);
    }];
    
    _saveButton =  [CPButton new];
    
    [self.view addSubview:_saveButton];
    [_saveButton setTitle:@"保  存" forState:0];
    [_saveButton addTarget:self action:@selector(saveAction:) forControlEvents:64];
    [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.bottom.mas_equalTo(-100);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];

    _itemPickView = [UIPickerView new];
    _itemPickView.backgroundColor = UIColor.whiteColor;
    _itemPickView.delegate = self;
    _itemPickView.dataSource = self;
    _itemPickView.showsSelectionIndicator = YES;
    
    [self.view addSubview:_itemPickView];
    [_itemPickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLB.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.saveButton.mas_top).offset(-cellSpaceOffset);
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
    
    CPMemberRateListModel *model = tempArray[row];
    
    return [NSString stringWithFormat:@"%@%%",model.values];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    self.component = component;
//    self.row = row;
}

- (void)loadMemberRateList {
    
    __weak typeof(self) weakSelf = self;
    
    [CPMemberRateListModel modelRequestWith:DOMAIN_ADDRESS@"/api/userpre/findpre"
                                 parameters:nil
                                      block:^(id result) {
                                          [weakSelf handleLoadMemeberRateListBlock:result];
                                      } fail:^(CPError *error) {
                                          
                                      }];
}

- (void)handleLoadMemeberRateListBlock:(NSArray <CPMemberRateListModel *> *)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        return;
    }
    
    self.rateModels = result;
    
    self.dataArray = @[result];
    
    [self.itemPickView reloadAllComponents];
    
    [self updateCurrentIndictor];
}

#pragma mark - private method
- (void)saveAction:(id)sender {
    
    NSInteger row = [self.itemPickView selectedRowInComponent:0];
    [self updateRate:row];
}

- (void)updateRate:(NSInteger)row {
    
    __weak typeof(self) weakSelf = self;
    
    CPMemberRateListModel *model = self.rateModels[row];
    
    [CPBaseModel modelRequestWith:DOMAIN_ADDRESS@"/api/user/setPgprice_pre"
                       parameters:@{
                                    @"userid":@([CPUserInfoModel shareInstance].loginModel.ID),
                                    @"pgprice_pre": model.values
                                    }
                            block:^(id result) {
                                [weakSelf handleUdpateRateBlock:result row:row];
                            } fail:^(CPError *error) {
                                
                            }];
}

- (void)handleUdpateRateBlock:(CPBaseModel *)result row:(NSUInteger)row {
    CPMemberRateListModel *model = self.rateModels[row];
    [CPUserInfoModel shareInstance].userDetaiInfoModel.default_pgprice_pre = model.values;
    [self.view makeToast:@"设置成功" duration:1.0f position:CSToastPositionCenter];
}

- (void)updateCurrentIndictor {
    NSString *default_pgprice_pre = [CPUserInfoModel shareInstance].userDetaiInfoModel.pgprice_pre;
    
    [self.rateModels enumerateObjectsUsingBlock:^(CPMemberRateListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.values.integerValue == default_pgprice_pre.integerValue) {
            [self.itemPickView selectRow:idx inComponent:0 animated:YES];
            *stop = YES;
        }
    }];
}



@end
