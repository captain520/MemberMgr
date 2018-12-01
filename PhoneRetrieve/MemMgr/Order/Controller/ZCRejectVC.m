//
//  ZCRejectVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/11/16.
//  Copyright © 2018 Captain. All rights reserved.
//

#import "ZCRejectVC.h"
#import "MSRejectReasonModel.h"
#import "ZCRejectReasonCV.h"
#import "CPCheckBox.h"
#import "CPWebVC.h"

@interface ZCRejectVC ()<CPSelectTextFieldDelegat>

@property (nonatomic,strong) CPLabel *rejectAmountLB;

@property (nonatomic, strong) CPTextField *bankAccontNameTF, *bankAccountTF,*bankSelecteTF;
@property (nonatomic, strong) CPTextField *memeberNameTF,*memeberPhoneTF,*addressTF;
@property (nonatomic, strong) CPSelectTextField *proviceTF, *cityTF, *areaTF;
@property (nonatomic, strong) CPProviceCityAreaModel *cityModel, *proviceModel, *areaModel;

@property (nonatomic, strong) CPTextField *reasonTF;

@property (nonatomic, strong) NSArray <MSRejectReasonModel *> *reasonModels;

@property (nonatomic, strong) ZCRejectReasonCV *reasonCV;

@property (nonatomic, strong) CPCheckBox *checkBox;

@property (nonatomic,strong) CPButton *nextAction;

@end

@implementation ZCRejectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
    
    [self loadProvice];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initialized properties
- (void)initailizeBaseProperties {
    
}
#pragma mark - setter && getter method
#pragma mark - Setup UI
- (void)setupUI:(UITableViewCell *)cell {

    self.title = @"机器反还";
    
    __weak typeof(self) weakSelf = self;
    
    {
        _rejectAmountLB = [CPLabel new];
        _rejectAmountLB.text = [NSString stringWithFormat:@"返回金额:¥%.2f",_model.yfprice.floatValue];
        _rejectAmountLB.textAlignment = NSTextAlignmentCenter;
        _rejectAmountLB.font = [UIFont boldSystemFontOfSize:18];
        _rejectAmountLB.textColor = UIColor.redColor;
        
        [cell.contentView addSubview:_rejectAmountLB];
        [_rejectAmountLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(SPACE_OFFSET_F);
            make.right.mas_equalTo(-SPACE_OFFSET_F);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    {
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;
        
        [cell.contentView addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_rejectAmountLB.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(.5);
        }];
        
        CPLabel *receiptTitleLB = [CPLabel new];
        receiptTitleLB.text = @"平台收款信息";
        receiptTitleLB.font = [UIFont boldSystemFontOfSize:15];
        
        [cell.contentView addSubview:receiptTitleLB];
        [receiptTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(sepLine.mas_bottom).offset(8);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
        UIView *sepLine1 = [UIView new];
        sepLine1.backgroundColor = CPBoardColor;
        
        [cell.contentView addSubview:sepLine1];
        [sepLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(receiptTitleLB.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(.5);
        }];
        
        if (nil == self.bankAccontNameTF) {
            self.bankAccontNameTF = [CPTextField new];
            self.bankAccontNameTF.placeholder = @"收款人名称";
            [cell.contentView addSubview:self.bankAccontNameTF];
            [self.bankAccontNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(sepLine1.mas_bottom).offset(cellSpaceOffset);
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
        }
        
        if (nil == self.bankSelecteTF) {
            self.bankSelecteTF = [[CPTextField alloc] initWithFrame:CGRectMake(cellSpaceOffset, 0, SCREENWIDTH - 2 * cellSpaceOffset, CELL_HEIGHT_F)];
            self.bankSelecteTF.placeholder = @"银行名称";
            
            [cell.contentView addSubview:self.bankSelecteTF];
            [self.bankSelecteTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.bankAccontNameTF.mas_bottom).offset(cellSpaceOffset);
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
        }
        
        if (nil == self.bankAccountTF) {
            self.bankAccountTF = [CPTextField new];
            self.bankAccountTF.placeholder = @"银行账号";
            [cell.contentView addSubview:self.bankAccountTF];
            [self.bankAccountTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.bankSelecteTF.mas_bottom).offset(cellSpaceOffset);
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
        }
    }
    
    {
        CPLabel *receiptTitleLB = [CPLabel new];
        receiptTitleLB.text = @"会员收货信息(返回商品收货地址)";
        receiptTitleLB.font = [UIFont boldSystemFontOfSize:15];
        
        [cell.contentView addSubview:receiptTitleLB];
        [receiptTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_bankAccountTF.mas_bottom).offset(8);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;
        
        [cell.contentView addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(receiptTitleLB.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(.5);
        }];
        
        CGFloat width = (SCREENWIDTH - 4 * cellSpaceOffset) / 3;
        
        if (nil == self.memeberNameTF) {
            self.memeberNameTF = [CPTextField new];
            self.memeberNameTF.placeholder = @"会员名称";
            
            [cell.contentView addSubview:self.memeberNameTF];
            [self.memeberNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(SPACE_OFFSET_F);
                make.right.mas_equalTo(-SPACE_OFFSET_F);
                make.height.mas_equalTo(CELL_HEIGHT_F);
                make.top.mas_equalTo(receiptTitleLB.mas_bottom).offset(cellSpaceOffset);
            }];
        }
        
        if (nil == self.memeberPhoneTF) {
            self.memeberPhoneTF = [CPTextField new];
            self.memeberPhoneTF.placeholder = @"会员电话";
            self.memeberPhoneTF.borderStyle = UITextBorderStyleRoundedRect;
            self.memeberPhoneTF.keyboardType = UIKeyboardTypePhonePad;
            
            [cell.contentView addSubview:self.memeberPhoneTF];
            [self.memeberPhoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.memeberNameTF.mas_bottom).offset(SPACE_OFFSET_F);
                make.left.mas_equalTo(self.memeberNameTF.mas_left);
                make.right.mas_equalTo(self.memeberNameTF.mas_right);
                make.height.mas_equalTo(self.memeberNameTF.mas_height);
            }];
        }
        
        
        if (nil == self.proviceTF) {
            
            self.proviceTF = [[CPSelectTextField alloc] initWithFrame:CGRectMake(0, 0, width, CELL_HEIGHT_F)];
            self.proviceTF.placeholder = @"选择省";
            self.proviceTF.cp_editDelegate = self;
            self.proviceTF.type = 0;
            //        self.proviceTF.dataArray = @[@"1111",@"222",@"333"];
            
            [cell.contentView addSubview:self.proviceTF];
            
            [self.proviceTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.memeberPhoneTF.mas_bottom).offset(SPACE_OFFSET_F);
                make.left.mas_equalTo(cellSpaceOffset);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
        }
        
        if (nil == self.cityTF) {
            
            self.cityTF = [[CPSelectTextField alloc] initWithFrame:CGRectMake(0, 0, width, CELL_HEIGHT_F)];
            self.cityTF.placeholder = @"选择市";
            //        self.cityTF.dataArray = @[@"aaa",@"bbb",@"ccc"];
            self.cityTF.cp_editDelegate = self;
            self.cityTF.type = 1;
            
            [cell.contentView addSubview:self.cityTF];
            
            [self.cityTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.proviceTF.mas_top);
                make.left.mas_equalTo(self.proviceTF.mas_right).offset(cellSpaceOffset);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
        }
        
        if (nil == self.areaTF) {
            
            self.areaTF = [[CPSelectTextField alloc] initWithFrame:CGRectMake(0, 0, width, CELL_HEIGHT_F)];
            self.areaTF.placeholder = @"选择区";
            //        self.areaTF.dataArray = @[@"----",@"xxxx",@">>>>>>"];
            self.areaTF.cp_editDelegate = self;
            self.areaTF.type = 2;
            
            [cell.contentView addSubview:self.areaTF];
            
            [self.areaTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.proviceTF.mas_top);
                make.left.mas_equalTo(self.cityTF.mas_right).offset(cellSpaceOffset);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
        }
        
        //  收货地址栏
        {
            self.addressTF = [CPTextField new];
            self.addressTF.placeholder = @"收货地址";
            
            [cell.contentView addSubview:self.addressTF];
            [self.addressTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.proviceTF.mas_bottom).offset(cellSpaceOffset);
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
        }
    }
    
    {
        CPLabel *receiptTitleLB = [CPLabel new];
        receiptTitleLB.text = @"返回原因";
        receiptTitleLB.font = [UIFont boldSystemFontOfSize:15];
        
        [cell.contentView addSubview:receiptTitleLB];
        [receiptTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_addressTF.mas_bottom).offset(8);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;
        
        [cell.contentView addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(receiptTitleLB.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(.5);
        }];
        
        

        {
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            self.reasonCV = [[ZCRejectReasonCV alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, CELL_HEIGHT_F) collectionViewLayout:flowLayout];

            self.reasonCV.dataArray = self.reasonModels;
            [cell.contentView addSubview:self.reasonCV];

            [self.reasonCV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(sepLine.mas_bottom).offset(8);
                make.left.mas_equalTo(SPACE_OFFSET_F);
                make.right.mas_equalTo(-SPACE_OFFSET_F);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
        }
        

        CPLabel *otherReasonHintLB = [CPLabel new];
        otherReasonHintLB.text = @"其他原因:";
        
        [cell.contentView addSubview:otherReasonHintLB];
        [otherReasonHintLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(sepLine.mas_bottom).offset(cellSpaceOffset + CELL_HEIGHT_F);
            make.left.mas_equalTo(SPACE_OFFSET_F);
            make.height.mas_equalTo(CELL_HEIGHT_F);
            make.width.mas_equalTo(60);
        }];
        
    


        
        self.reasonTF = [CPTextField new];
        self.reasonTF.placeholder = @"请输入具体的原因";
        
        [cell.contentView addSubview:self.reasonTF];
        [self.reasonTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(otherReasonHintLB.mas_right).offset(8);
            make.right.mas_equalTo(cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
            make.top.mas_equalTo(otherReasonHintLB.mas_top);
        }];
    }
    
    if (nil == self.checkBox) {
        
        NSDictionary *option0 = @{
                                  NSFontAttributeName : [UIFont systemFontOfSize:13.0f],
                                  NSForegroundColorAttributeName : C33
                                  };
        NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:@" 同意"
                                                                                  attributes:option0];
        NSDictionary *option1 = @{
                                  NSFontAttributeName : [UIFont systemFontOfSize:13.0f],
                                  NSForegroundColorAttributeName : C33,
                                  NSUnderlineStyleAttributeName : @1
                                  };
        NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:@"《乐收栈注册协议》" attributes:option1];
        
        [attr0 appendAttributedString:attr1];
        
        __weak typeof(self) weakSelf = self;
        
        self.checkBox = [[CPCheckBox alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.checkBox.content = attr0;
        self.checkBox.actionBlock = ^(BOOL aggree) {
//            [weakSelf handleAgreeProtocolBlock:aggree];
        };
        
        self.checkBox.showHintBlock = ^{
            [weakSelf getConfigUrl:@"200" block:^(NSString *url, NSString *title) {
                CPWebVC *webVC = [[CPWebVC alloc] init];
                //        webVC.urlStr = @"https://www.baidu.com";
                webVC.contentStr = url;
                webVC.title = title;
                webVC.hidesBottomBarWhenPushed = YES;
                
                [weakSelf.navigationController pushViewController:webVC animated:YES];
            }];
        };
        
        [cell.contentView addSubview:self.checkBox];
        
        [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.reasonTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(20);
        }];
    }
    
    {
        if (nil == self.nextAction) {
            self.nextAction = [CPButton new];
            [cell.contentView addSubview:self.nextAction];
            [self.nextAction setTitle:@"提交注册信息" forState:0];
            [self.nextAction addTarget:self action:@selector(nextAction:) forControlEvents:64];
            [self.nextAction mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.checkBox.mas_bottom).offset(CELL_HEIGHT_F);
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
            RAC(self.nextAction, enabled) = [RACSignal combineLatest:@[
                                                                       self.bankAccontNameTF.rac_textSignal,
                                                                       self.bankAccountTF.rac_textSignal,
                                                                       self.bankSelecteTF.rac_textSignal,
                                                                       self.proviceTF.rac_textSignal,
                                                                       self.cityTF.rac_textSignal,
                                                                       self.areaTF.rac_textSignal,
                                                                       self.memeberNameTF.rac_textSignal,
                                                                       self.memeberPhoneTF.rac_textSignal,
                                                                       self.addressTF.rac_textSignal
                                                                       ]
                                                              reduce:^id{
                                                                  return @(
                                                                  self.bankAccontNameTF.text.length>0
                                                                  && self.bankAccountTF.text.length>0
                                                                  &&self.bankSelecteTF.text.length>0
                                                                  &&self.proviceTF.text.length>0
                                                                  &&self.cityTF.text.length>0
                                                                  &&self.areaTF.text.length>0
                                                                  &&self.memeberNameTF.text.length>0
                                                                  &&self.memeberPhoneTF.text.length>0
                                                                  &&self.addressTF.text.length>0
                                                                  );
                                                              }];
        }
        
        
    }
    
}
#pragma mark - Delegate && dataSource method implement

#pragma mark - CPSelectTextFieldDelegat
- (void)cp_textFieldDidBeginEditing:(UITextField *)textField model:(CPProviceCityAreaModel *)model{};
- (void)cp_textFieldDidEndEditing:(UITextField *)textField model:(CPProviceCityAreaModel *)model{
    
    if (textField == self.proviceTF) {
        [self loadCity:model.Code];
        self.proviceModel = model;
    } else if (textField == self.cityTF) {
        [self loadArea:model.Code];
        self.cityModel = model;
    } else if (textField == self.areaTF) {
        self.areaModel = model;
    } else if (textField == self.bankSelecteTF) {
        //        textField.text = @"00000";
    }

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return  1;}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return 1;};
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {return SCREENHEIGHT + NAV_HEIGHT;};

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = UIColor.whiteColor;
        
        [self setupUI:cell];
    }
    
    
    return cell;
}
#pragma mark - load data
- (void)loadData {
    self.dataTableView.backgroundColor = UIColor.whiteColor;

    __weak typeof(self) weakSelf = self;

    [MSRejectReasonModel modelRequestWith:DOMAIN_ADDRESS@"api/reportresultmarks/findmarklist"
                                                 parameters:nil
                                                 block:^(NSArray *result) {
                                                     [weakSelf handleLoadDataBlock:result];
                                                 } fail:^(CPError *error) {
                                                     
                                                 }];
    
}

- (void)handleLoadDataBlock:(NSArray *)result {
    self.reasonModels = result;
    
    
    self.reasonCV.dataArray = result;
    [self.reasonCV reloadData];
//    [self.dataTableView reloadData];
}

#pragma mark - Private method implement
-(void)nextAction:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    
    NSString *remark = @" ";
    
    NSMutableArray *tempData = @[].mutableCopy;
    [self.reasonCV.indexPathsForVisibleItems enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MSRejectReasonModel *model = [self.reasonModels objectAtIndex:obj.row];
        [tempData addObject:model.name];
    }];
    
    if (tempData.count > 0) {
        remark = [tempData componentsJoinedByString:@","];
    }
    
    DDLogInfo(@"------------------------------");
    NSMutableDictionary *params = @{
                             @"resultid" : _model.ID,
                             @"provinceid" : self.proviceModel.Code,
                             @"provincename" : self.proviceModel.province,
                             @"cityid" : self.cityModel.Code,
                             @"cityname" : self.cityModel.province,
                             @"cityname" : self.cityModel.Code,
                             @"districtname" : self.cityModel.province,
                             @"address" : self.addressTF.text,
                             @"name" : self.bankAccontNameTF.text,
                             @"mobile" : self.memeberPhoneTF.text,
                             @"remark" : remark,
                             @"userid" : USER_ID,
                             @"usertypeid" : @([CPUserInfoModel shareInstance].userDetaiInfoModel.Typeid)
                             }.mutableCopy;
    
    if (self.reasonTF.text.length > 0) {
        [params setObject:self.reasonTF.text forKey:@"other"];
    }
    
    [CPBaseModel modelRequestWith:DOMAIN_ADDRESS@"/api/Reportresultreturnrecords/insertRecord"
                       parameters:params
                            block:^(id result) {
                                [weakSelf handleSubmitBlock:nil];
                            } fail:^(CPError *error) {
                                [[CPProgress Instance] showError:weakSelf.view message:error.cp_msg finish:nil];

                            }];
}

- (void)handleSubmitBlock:(id)resut {
    
    [[CPProgress Instance] showSuccess:self.view message:@"提交成功" finish:^(BOOL finished) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)loadProvice {
    
    __weak typeof(self) weakSelf = self;
    
    [CPProviceCityAreaModel modelRequestWith:DOMAIN_ADDRESS@"/api/area/findData?parentcode=0"
                                  parameters:nil
                                       block:^(id result) {
                                           [weakSelf handleLoadProviceBlock:result];
                                       } fail:^(CPError *error) {
                                           
                                       }];
}

- (void)handleLoadProviceBlock:(NSArray <CPProviceCityAreaModel *> *)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        return;
    }
    
    self.proviceTF.dataArray = result;
}

- (void)loadCity:(NSString *)paramCode {
    
    __weak typeof(self) weakSelf = self;
    
    [CPProviceCityAreaModel modelRequestWith:DOMAIN_ADDRESS@"/api/area/findData"
                                  parameters:@{@"parentcode" : paramCode}
                                       block:^(id result) {
                                           [weakSelf handleLoadCityBlock:result];
                                       } fail:^(CPError *error) {
                                           
                                       }];
}

- (void)handleLoadCityBlock:(NSArray <CPProviceCityAreaModel *> *)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        return;
    }
    
    self.cityTF.dataArray = result;
}

- (void)loadArea:(NSString *)paramCode {
    
    __weak typeof(self) weakSelf = self;
    
    [CPProviceCityAreaModel modelRequestWith:DOMAIN_ADDRESS@"/api/area/findData"
                                  parameters:@{@"parentcode" : paramCode}
                                       block:^(id result) {
                                           [weakSelf handleLoadAreaBlock:result];
                                       } fail:^(CPError *error) {
                                           
                                       }];
}

- (void)handleLoadAreaBlock:(NSArray <CPProviceCityAreaModel *> *)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        return;
    }
    
    self.areaTF.dataArray = result;
}


@end
