//
//  CPOrderSearchVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPOrderSearchVC.h"
#import "CPDatePickerTF.h"
#import "CPAssistanteOrderDetailModel.h"
#import "CPAssistantOrderListVC.h"
#import "CPOrderListPageModel.h"
#import "CPPayStateSearchResultVCViewController.h"
#import "CPShippingStateVC.h"
#import "CPAssistantOrderListPageModel.h"
#import "CPAssistantOrderListPageModel.h"
#import "CPGoodOrderListVC.h"
#import "CPMemeberListModel.h"

@interface CPOrderSearchVC ()<UISearchBarDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) CPDatePickerTF *begintInputTF, *endInputTF;
@property (nonatomic, strong) CPLabel *beginLB, *endLB;
@property (nonatomic, strong) CPButton *nextActionBT;
@property (nonatomic, strong) CPTextField *shopSelectedTF;
@property (nonatomic, strong) NSArray *shopsModels;
@property (nonatomic, strong) CPMemeberListModel *selectedShopModel;
@property (nonatomic, strong) UIPickerView *pickerView;

//@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation CPOrderSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setType:(CPOrderSearchType)type {
    
    _type = type;
}

- (UIPickerView *)pickerView {
    
    if (nil == _pickerView) {
        _pickerView = [UIPickerView new];
        _pickerView.delegate = self;
    }
    
    return _pickerView;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.shopsModels.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    CPMemeberListModel *model = self.shopsModels[row];
    
    return model.linkname;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSInteger row =  [self.pickerView selectedRowInComponent:0];
    self.selectedShopModel = self.shopsModels[row];
    textField.text = self.selectedShopModel.linkname ? self.selectedShopModel.linkname : @"全部店员";
}

- (void)setupUI {
  
//    self.datePicker = [[UIDatePicker alloc] init];
//    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    NSString *placeholder = @"物流单号/交易单号";
//    if (self.type == CPOrderSearchTypeOrder) {
    placeholder = @"订单号";
//    }

    self.searchBar = [[UISearchBar alloc] init];;
    self.searchBar.delegate           = self;
    self.searchBar.placeholder        = placeholder;
    self.searchBar.backgroundImage    = [UIImage new];
    self.searchBar.layer.borderColor  = CPBoardColor.CGColor;
    self.searchBar.layer.borderWidth  = CPBoardWidth;
    self.searchBar.layer.cornerRadius = 5.0f;
    
    [self.view addSubview:self.searchBar];

    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(NAV_HEIGHT + cellSpaceOffset);
        make.left.mas_offset(cellSpaceOffset);
        make.right.mas_offset(-cellSpaceOffset);
        make.height.mas_offset(CELL_HEIGHT_F);
    }];
    
//    self.shopSelectedTF = [CPTextField new];
//    self.shopSelectedTF.text                 = @"全部店员";
//    self.shopSelectedTF.delegate             = self;
//    self.shopSelectedTF.actionType           = CPTextFieldActionTypeRightAction;
//    self.shopSelectedTF.rightActionImageName = @"home_down";
//    self.shopSelectedTF.inputView            = self.pickerView;
//
//    [self.view addSubview:self.shopSelectedTF];
//    [self.shopSelectedTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_searchBar.mas_bottom).offset(cellSpaceOffset);
//        make.left.mas_equalTo(cellSpaceOffset);
//        make.right.mas_equalTo(-cellSpaceOffset);
//        make.height.mas_equalTo(CELL_HEIGHT_F);
//    }];
    
    
    _beginLB = [CPLabel new];
    _beginLB.font      = CPFont_S;
    _beginLB.text      = @"开始日期";
    _beginLB.textColor = C99;
    
    [self.view addSubview:_beginLB];
    
    [_beginLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchBar.mas_bottom).offset(cellSpaceOffset);
        make.left.mas_equalTo(cellSpaceOffset);
    }];

    _begintInputTF = [[CPDatePickerTF alloc] initWithFrame:CGRectMake(0, 0, 0, CELL_HEIGHT_F)];
    _begintInputTF.actionType = CPTextFieldActionTypeRightAction;
    _begintInputTF.rightActionImageName = @"data";
    [self.view addSubview:_begintInputTF];
    [_begintInputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_beginLB.mas_bottom).offset(cellSpaceOffset);
        make.left.mas_equalTo(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];
    
    
    _endLB = [CPLabel new];
    _endLB.textColor = C99;
    _endLB.font = CPFont_S;
    _endLB.text = @"结束日期";
    [self.view addSubview:_endLB];
    
    [_endLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_begintInputTF.mas_bottom).offset(cellSpaceOffset);
        make.left.mas_equalTo(cellSpaceOffset);
    }];

    
    _endInputTF = [[CPDatePickerTF alloc] initWithFrame:CGRectMake(0, 0, 0, CELL_HEIGHT_F)];
    _endInputTF.actionType = CPTextFieldActionTypeRightAction;
    _endInputTF.rightActionImageName = @"data";
    [self.view addSubview:_endInputTF];
    [_endInputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_endLB.mas_bottom).offset(cellSpaceOffset);
        make.left.mas_equalTo(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];
    
    self.nextActionBT = [CPButton new];
    [self.nextActionBT setTitle:@"搜 索" forState:0];
    [self.nextActionBT addTarget:self action:@selector(searchAction:) forControlEvents:64];
    
    [self.view addSubview:self.nextActionBT];
    [self.nextActionBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_endInputTF.mas_bottom).offset(CELL_HEIGHT_F);;
        make.left.mas_equalTo(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"%s",__FUNCTION__);
    
    [self.view endEditing:YES];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)searchAction:(id)sender {
    
    if (self.type == CPOrderSearchTypeShopPaidOrder
        || self.type == CPOrderSearchTypeShopUnpaidOrder
        || self.type == CPOrderSearchTypeShippingOnWay || self.type == CPOrderSearchTypeShippingFinished
        ) {
        
        [self queryShopPayStateVC];
        
        return;
    } else if (self.type == CPOrderSearchTypeOverDueOrder || self.type == CPOrderSearchTypeOverFinishedOrder) {
        
        [self queryOrderState];
        
        return;
    }
    
    
    DDLogInfo(@">>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = @{
                             @"typeid": @([CPUserInfoModel shareInstance].loginModel.Typeid),
                             @"userid": @([CPUserInfoModel shareInstance].loginModel.ID)
                             }.mutableCopy;
    if (self.searchBar.text.length > 0) {
        [params setObject:self.searchBar.text forKey:@"resultno"];
    }
    
    if (self.begintInputTF.text.length > 0 ) {
        [params setObject:self.begintInputTF.text forKey:@"starttime"];
    }
    
    if (self.endInputTF.text.length > 0 ) {
        [params setObject:self.endInputTF.text forKey:@"endtime"];
    }
    
    [CPAssistanteOrderDetailModel orderModelRequestWith:CPURL_ASSISTANT_GET_RETRIEVE_ORDER
                                        parameters:params
                                             block:^(NSArray <CPAssistanteOrderDetailModel *> *result) {
                                                 [weakSelf handleLoadDataSuccessBlock:result];
                                             } fail:^(CPError *error) {

                                             }];
}

- (void)handleLoadDataSuccessBlock:(NSArray <CPAssistanteOrderDetailModel *> *)result {
    
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        
        [self.view makeToast:@"暂无符合的数据" duration:2.0 position:CSToastPositionCenter];

        return;
    }
    
    CPAssistantOrderListVC *vc = [[CPAssistantOrderListVC alloc] init];
    vc.dataArray = result;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 门店订单查询

- (void)queryShopPayStateVC {
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = @{
                                    @"typeid": @([CPUserInfoModel shareInstance].loginModel.Typeid),
                                    @"userid": @([CPUserInfoModel shareInstance].loginModel.ID)
                                    }.mutableCopy;
    if (self.searchBar.text.length > 0) {
        [params setObject:self.searchBar.text forKey:@"ordersn"];
    }
    
    if (self.begintInputTF.text.length > 0 ) {
        [params setObject:self.begintInputTF.text forKey:@"starttime"];
    }
    
    if (self.endInputTF.text.length > 0 ) {
        [params setObject:self.endInputTF.text forKey:@"endtime"];
    }
    
    if (self.type == CPOrderSearchTypeShopUnpaidOrder
        || self.type == CPOrderSearchTypeShippingOnWay
        || self.type == CPOrderSearchTypeShippingFinished
        || self.type == CPOrderSearchTypeShopPaidOrder
        ) {
        
        
        //  支付状态
        {
            NSInteger paycfg = 0;//aycfg 支付状态：0未支付，1已支付
            if (self.type == CPOrderSearchTypeShopUnpaidOrder) {
                paycfg = 0;
                [params setObject:@(paycfg) forKey:@"paycfg"];
            } else if (self.type == CPOrderSearchTypeShopPaidOrder) {
                paycfg = 1;
                [params setObject:@(paycfg) forKey:@"paycfg"];
            }
            
        }
        
        //  物流状态
        
        {
            NSInteger logistcfg = 0;//aycfg 支付状态：0未支付，1已支付
            if (self.type == CPOrderSearchTypeShippingOnWay) {
                logistcfg = 0;
                [params setObject:@(logistcfg) forKey:@"finishcfg"];
            } else if (self.type == CPOrderSearchTypeShippingFinished) {
                logistcfg = 1;
                [params setObject:@(logistcfg) forKey:@"finishcfg"];
            }
        }
        

    }

    [CPOrderListPageModel modelRequestWith:DOMAIN_ADDRESS@"/api/Order/findOrderList"
                                parameters:params
                                     block:^(CPOrderListPageModel *result) {
                                         [weakSelf handlequeryShopPayStateVCBlock:result];
                                     } fail:^(CPError *error) {
                                         
                                     }];
}

- (void)handlequeryShopPayStateVCBlock:(CPOrderListPageModel *)result {
    if (!result || ![result isKindOfClass:[CPOrderListPageModel class]] || result.cp_data.count == 0) {
        [self.view makeToast:@"暂无符合的数据" duration:2.0 position:CSToastPositionCenter];
        return;
    }
    
    if (self.type == CPOrderSearchTypeShippingOnWay || self.type == CPOrderSearchTypeShippingFinished) {
        
        !self.payFilterBlock ? : self.payFilterBlock(result);
        
        [self.navigationController popViewControllerAnimated:YES];
//        CPShippingStateVC *vc = [[CPShippingStateVC alloc] init];
//        vc.title = self.title;
//        vc.dataArray = result.cp_data;
//
//        [self.navigationController pushViewController:vc animated:YES];

    } else {
        
        !self.payFilterBlock ? : self.payFilterBlock(result);

        [self.navigationController popViewControllerAnimated:YES];
//        CPPayStateSearchResultVCViewController *vc = [[CPPayStateSearchResultVCViewController alloc] init];
//        //    vc.title = @"支付订单查询结果";
//        vc.payStateOrderModel = resul;
//        vc.title = self.title;
//
//        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)queryOrderState {

    DDLogInfo(@">>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
    __weak typeof(self) weakSelf = self;
    
    NSString *statuscfg = @"0";
    if (self.type == CPOrderSearchTypeOverDueOrder) {
        statuscfg = @"1";
    } else if (self.type == CPOrderSearchTypeOverFinishedOrder) {
        statuscfg = @"0";
    }
    
    NSMutableDictionary *params = @{
                                    @"typeid": @([CPUserInfoModel shareInstance].loginModel.Typeid),
                                    @"userid": @([CPUserInfoModel shareInstance].loginModel.ID),
                                    @"statuscfg" : statuscfg
                                    }.mutableCopy;
    
    if (self.searchBar.text.length > 0) {
        [params setObject:self.searchBar.text forKey:@"resultno"];
    }
    
    if (self.begintInputTF.text.length > 0 ) {
        [params setObject:self.begintInputTF.text forKey:@"starttime"];
    }
    
    if (self.endInputTF.text.length > 0 ) {
        [params setObject:self.endInputTF.text forKey:@"endtime"];
    }
    
    [CPAssistantOrderListPageModel modelRequestWith:CPURL_ASSISTANT_GET_RETRIEVE_ORDER
                                         parameters:params
                                              block:^(CPAssistantOrderListPageModel *result) {
                                                  [weakSelf handleQueryOrderStateSuccessBlock:result];
                                              } fail:^(CPError *error) {
                                                  
                                              }];
}

- (void)handleQueryOrderStateSuccessBlock:(CPAssistantOrderListPageModel *)result {
    
    if (!result || ![result isKindOfClass:[CPAssistantOrderListPageModel class]] || result.cp_data.count == 0) {
        [self.view makeToast:@"暂无符合的数据" duration:2.0 position:CSToastPositionCenter];
        
        return;
    }
    
    CPGoodOrderListVC *vc = [[CPGoodOrderListVC alloc] init];
    vc.result = result;
    
    if (self.type == CPOrderSearchTypeOverDueOrder) {
        vc.title = @"回收车失效订单查询";
        vc.goodOrderListType = CPGoodOrderListTypeCartOverDueOrder;
    } else {
        vc.goodOrderListType = CPGoodOrderListTypeShopRetrieveOrder;
        vc.title = @"门店回收订单查询";
    }

    [self.navigationController pushViewController:vc animated:YES];

}


- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    
    NSDictionary *params = @{
                             @"typeid" : @"4",
                             @"userid" : @([CPUserInfoModel shareInstance].loginModel.ID)
                             };
    
    [CPMemeberListModel modelRequestWith:DOMAIN_ADDRESS@"/api/user/findUserList"
                              parameters:params
                                   block:^(id result) {
                                       [weakSelf handleLoadDataBlock:result];
                                   } fail:^(CPError *error) {
                                       
                                   }];
}

- (void)handleLoadDataBlock:(NSArray <CPMemeberListModel *> *)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        
        CPBaseModel *emptyModel = (CPBaseModel *)result;
        
//        [self.view makeToast:emptyModel.msg duration:1.0f position:CSToastPositionCenter];
        
        return;
    }
    
    self.shopsModels = result;

    [self.pickerView reloadAllComponents];
    
}


@end
