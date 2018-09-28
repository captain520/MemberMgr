//
//  CPMemberUpdateBankInfoVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemberUpdateBankInfoVC.h"

@interface CPMemberUpdateBankInfoVC ()

@property (nonatomic, strong) CPTextField *bankAccontNameTF, *bankAccountTF,*bankSelecteTF,*bankBranchTF;

@property (nonatomic,strong) CPButton *nextAction;

@end

@implementation CPMemberUpdateBankInfoVC

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
    if (nil == self.bankAccontNameTF) {
        self.bankAccontNameTF = [CPTextField new];
        self.bankAccontNameTF.placeholder = @"收款人名称";
        if ([CPUserInfoModel shareInstance].userDetaiInfoModel.bname.length > 0) {
            self.bankAccontNameTF.text = [CPUserInfoModel shareInstance].userDetaiInfoModel.bname;
        }
        [self.view addSubview:self.bankAccontNameTF];
        [self.bankAccontNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).offset(NAV_HEIGHT + cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    if (nil == self.bankSelecteTF) {
        self.bankSelecteTF = [[CPTextField alloc] initWithFrame:CGRectMake(cellSpaceOffset, 0, SCREENWIDTH - 2 * cellSpaceOffset, CELL_HEIGHT_F)];
        self.bankSelecteTF.placeholder = @"银行名称";
        //            self.bankSelecteTF.tintColor = UIColor.clearColor;
        
        if ([CPUserInfoModel shareInstance].userDetaiInfoModel.bankname.length > 0) {
            self.bankSelecteTF.text = [CPUserInfoModel shareInstance].userDetaiInfoModel.bankname;
        }
        [self.view addSubview:self.bankSelecteTF];
        [self.bankSelecteTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bankAccontNameTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    if (nil == self.bankBranchTF) {
        self.bankBranchTF = [[CPTextField alloc] initWithFrame:CGRectMake(cellSpaceOffset, 0, SCREENWIDTH - 2 * cellSpaceOffset, CELL_HEIGHT_F)];
        self.bankBranchTF.placeholder = @"支行名称";
        self.bankBranchTF.hidden = YES;
        //            self.bankBranchTF.tintColor = UIColor.clearColor;
        if ([CPUserInfoModel shareInstance].userDetaiInfoModel.bankbranch.length > 0) {
            self.bankBranchTF.text = [CPUserInfoModel shareInstance].userDetaiInfoModel.bankbranch;
        }

        [self.view addSubview:self.bankBranchTF];
        [self.bankBranchTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bankSelecteTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    if (nil == self.bankAccountTF) {
        self.bankAccountTF = [CPTextField new];
        self.bankAccountTF.placeholder = @"银行账号";
        if ([CPUserInfoModel shareInstance].userDetaiInfoModel.banknum.length > 0) {
            self.bankAccountTF.text = [CPUserInfoModel shareInstance].userDetaiInfoModel.banknum;
        }
        [self.view addSubview:self.bankAccountTF];
        [self.bankAccountTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bankSelecteTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    if (nil == self.nextAction) {
        self.nextAction = [CPButton new];
        [self.view addSubview:self.nextAction];
        [self.nextAction setTitle:@"保  存" forState:0];
        [self.nextAction addTarget:self action:@selector(nextAction:) forControlEvents:64];
        [self.nextAction mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bankAccountTF.mas_bottom).offset(CELL_HEIGHT_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
        RAC(self.nextAction, enabled) = [RACSignal combineLatest:@[
                                                                  self.bankAccontNameTF.rac_textSignal,
                                                                  self.bankSelecteTF.rac_textSignal,
                                                                  self.bankAccountTF.rac_textSignal,
//                                                                  self.bankBranchTF.rac_textSignal
                                                                  ]
                                                         reduce:^id{
                                                            return @(
//                                                             self.bankBranchTF.text.length > 0 &&
                                                             self.bankAccontNameTF.text.length > 0 &&
                                                             self.bankSelecteTF.text.length > 0 &&
                                                             self.bankAccountTF.text.length > 0
                                                             );
                                                         }];
    }
}

#pragma mark - private method implement
-(void)nextAction:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    
    NSDictionary *params = @{
                             @"userid" : @([CPUserInfoModel shareInstance].loginModel.ID),
                             @"bankname" : self.bankSelecteTF.text,
                             @"banknum" : self.bankAccountTF.text,
                             @"bankbranch" : @"null",
                             @"bname" : self.bankAccontNameTF.text
                             };
    
    [CPBaseModel modelRequestWith:DOMAIN_ADDRESS@"/api/user/updatebankinfo"
                       parameters:params
                            block:^(id result) {
                                [weakSelf handleNextActionBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
}

- (void)handleNextActionBlock:(CPBaseModel *)resut {
    
    __weak typeof(self) weakSelf = self;
    
    [[CPProgress Instance] showSuccess:self.view message:@"保存成功" finish:^(BOOL finished) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}
@end
