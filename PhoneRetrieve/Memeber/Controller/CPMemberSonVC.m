//
//  CPMemberSonVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemberSonVC.h"
#import "CPMemberSonModel.h"

@interface CPMemberSonVC ()

@property (nonatomic, strong) NSArray <CPMemberSonModel *> *models;

@end

@implementation CPMemberSonVC {
    CPLabel *titleLB00, *titleLB01;
    
    CPTextField *name00TF, *phone00TF;
    CPTextField *name01TF, *phone01TF;
    
    CPButton *nextActionBT;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)setupUI {
    
    //  子会员1
    {
        titleLB00 = [CPLabel new];
        titleLB00.text = @"子会员1";
        [self.view addSubview:titleLB00];
        [titleLB00 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).offset(NAV_HEIGHT + cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
        }];
        
        
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;
        
        [self.view addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLB00.mas_bottom).offset(4);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(.5);
        }];
        
        name00TF = [CPTextField new];
        name00TF.placeholder = @"子会员名称";
        [self.view addSubview:name00TF];
        [name00TF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(sepLine.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(titleLB00.mas_left);
            make.right.mas_equalTo(titleLB00.mas_right);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];

        phone00TF = [CPTextField new];
        phone00TF.placeholder = @"子会员手机号码";
        [self.view addSubview:phone00TF];
        [phone00TF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(name00TF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(titleLB00.mas_left);
            make.right.mas_equalTo(titleLB00.mas_right);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    //  子会员2
    {
        titleLB01 = [CPLabel new];
        titleLB01.text = @"子会员2";
        [self.view addSubview:titleLB01];
        [titleLB01 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(phone00TF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
        }];
        
        
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;
        
        [self.view addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLB01.mas_bottom).offset(4);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(.5);
        }];
        
        name01TF = [CPTextField new];
        name01TF.placeholder = @"子会员名称";
        [self.view addSubview:name01TF];
        [name01TF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(sepLine.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(titleLB00.mas_left);
            make.right.mas_equalTo(titleLB00.mas_right);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
        phone01TF = [CPTextField new];
        phone01TF.placeholder = @"子会员手机号码";
        [self.view addSubview:phone01TF];
        [phone01TF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(name01TF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(titleLB00.mas_left);
            make.right.mas_equalTo(titleLB00.mas_right);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    //  确认修改/保存按钮
    {
        nextActionBT = [CPButton new];
        [self.view addSubview:nextActionBT];
        [nextActionBT setTitle:@"确  定" forState:0];
        [nextActionBT addTarget:self action:@selector(nextAction:) forControlEvents:64];
        [nextActionBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(phone01TF.mas_bottom).offset(CELL_HEIGHT_F);
            make.left.mas_equalTo(titleLB00.mas_left);
            make.right.mas_equalTo(titleLB00.mas_right);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
        RAC(nextActionBT,enabled) = [RACSignal combineLatest:@[
                                                               name00TF.rac_textSignal,
                                                               name01TF.rac_textSignal,
                                                               phone00TF.rac_textSignal,
                                                               phone01TF.rac_textSignal
                                                               ]
                                                      reduce:^id{
                                                          return @(
                                                          (
                                                           name00TF.text.length > 0 &&
                                                           phone00TF.text.length > 0 &&
                                                           name01TF.text.length == 0 &&
                                                           phone01TF.text.length == 0
                                                           ) || (
                                                                 name00TF.text.length > 0 &&
                                                                 phone00TF.text.length > 0 &&
                                                                 name01TF.text.length > 0 &&
                                                                 phone01TF.text.length > 0
                                                          )
                                                          );
                                                      }];
    }
}

#pragma mark - private method implement


/**
 加载会员相关信息
 */
- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    
    [CPMemberSonModel modelRequestWith:DOMAIN_ADDRESS@"/api/user/findUserChild"
                       parameters:@{@"userid" : @([CPUserInfoModel shareInstance].loginModel.ID)}
                            block:^(id result) {
                                [weakSelf handleLoadDataBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
}

- (void)handleLoadDataBlock:(NSArray <CPMemberSonModel *> *)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        return;
    }
    
    //TODO: 将数据添加进入到相关表里面
    self.models = result;

    NSInteger count = result.count;
    switch (count) {
        case 2:
        {
            CPMemberSonModel *model = self.models.lastObject;
            name01TF.text  = model.linkname;
            phone01TF.text = model.phone;
        }
        case 1:
        {
            CPMemberSonModel *model = self.models.firstObject;
            name00TF.text  = model.linkname;
            phone00TF.text = model.phone;
        }
            break;
            
        default:
            break;
    }
    
}

- (void)nextAction:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    
    if (self.models.count > 0) {
        
    }

    NSMutableArray *userArray = @[
                                   @{
                                       @"userid" : self.models.count > 0 ? self.models.firstObject.ID : @"0",
                                      @"linkname" : name00TF.text,
                                      @"phone" : phone00TF.text
                                      }
                                  ].mutableCopy;
    
    if (name01TF.text.length > 0) {
        [userArray addObject:@{
                               @"userid" : self.models.count > 1 ? self.models.lastObject.ID : @"0",
                               @"linkname" : name01TF.text,
                               @"phone" : phone01TF.text
                               }];
    }
    
    NSString *jsonStr = cp_jsonString(userArray);

    NSMutableDictionary *params = @{
                                    @"userid" : @([CPUserInfoModel shareInstance].loginModel.ID),
                                    @"resultjson" : jsonStr
                                    }.mutableCopy;
    
    [CPBaseModel modelRequestWith:DOMAIN_ADDRESS@"/api/user/insertUserChild"
                       parameters:params
                            block:^(id result) {
                                [weakSelf handleNextActionBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
    
}

- (void)handleNextActionBlock:(CPBaseModel *)result {
    
    __weak typeof(self) weakSelf = self;
    
    [[CPProgress Instance] showSuccess:self.view
                               message:result.msg
                                finish:^(BOOL finished) {
                                    [weakSelf.navigationController popViewControllerAnimated:YES];
                                }];
}



@end
