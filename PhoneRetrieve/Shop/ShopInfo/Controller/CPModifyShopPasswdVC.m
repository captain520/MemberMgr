//
//  CPModifyShopPasswdVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPModifyShopPasswdVC.h"
#import "CPSendCodeButton.h"
#import "CPLoginVC.h"

@interface CPModifyShopPasswdVC ()

@property (nonatomic, strong) CPTextField *accountTF, *codeTF, *passwdTF;
@property (nonatomic, strong) CPSendCodeButton *sendCodeBT;
@property (nonatomic, strong) CPButton *nextBT;

@end

@implementation CPModifyShopPasswdVC

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
    

    
    if (nil == self.accountTF) {
        self.accountTF = [CPTextField new];
        self.accountTF.font = [UIFont systemFontOfSize:13.0f];
        self.accountTF.placeholder = @"旧密码";
        self.accountTF.borderStyle = UITextBorderStyleRoundedRect;
        self.accountTF.keyboardType = UIKeyboardTypeNumberPad;
        self.accountTF.rightViewMode = UITextFieldViewModeAlways;
        
        [self.view addSubview:self.accountTF];
        
        [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0).offset(NAV_HEIGHT + cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    if (nil == self.sendCodeBT) {
        self.sendCodeBT = [[CPSendCodeButton alloc] initWithFrame:CGRectMake(0, 0, 120, CELL_HEIGHT_F)];
        self.sendCodeBT.layer.cornerRadius = 5.0f;
        self.sendCodeBT.clipsToBounds = YES;
        [self.sendCodeBT setBackgroundImage:CPEnableImage forState:UIControlStateNormal];
        [self.sendCodeBT setBackgroundImage:CPDisableImage forState:UIControlStateDisabled];
        [self.sendCodeBT setTitle:@"获取验证码" forState:UIControlStateNormal];
        
        [self.accountTF addSubview:self.sendCodeBT];
        
        [self.sendCodeBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(5);
            make.right.mas_equalTo(-5);
            make.bottom.mas_offset(-5);
//            make.width.mas_equalTo(120.0f);
            make.width.mas_equalTo(0.0f);
        }];
    }
    
    if (nil == self.codeTF) {
        self.codeTF = [CPTextField new];
        self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
        self.codeTF.font = [UIFont systemFontOfSize:13.0];
        self.codeTF.borderStyle = UITextBorderStyleRoundedRect;
        self.codeTF.placeholder = @"输入新密码";
        
        [self.view addSubview:self.codeTF];
        
        [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.accountTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
            make.right.mas_offset(-cellSpaceOffset);
        }];
        
    }
    
    if (nil == self.passwdTF) {
        self.passwdTF = [CPTextField new];
        self.passwdTF.keyboardType = UIKeyboardTypeNumberPad;
        self.passwdTF.font = [UIFont systemFontOfSize:13.0];
        self.passwdTF.borderStyle = UITextBorderStyleRoundedRect;
        self.passwdTF.placeholder = @"新密码确认";
        
        [self.view addSubview:self.passwdTF];
        
        [self.passwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.codeTF.mas_bottom).offset(cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            
        }];
    }
    
    if(nil == self.nextBT){
        self.nextBT = [[CPButton alloc] initWithFrame:CGRectZero];
        [self.nextBT setTitle:@"确认修改" forState:0];
        [self.nextBT addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.nextBT];
        
        [self.nextBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwdTF.mas_bottom).offset(3 * CELL_HEIGHT_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
        RAC(self.nextBT,enabled) = [RACSignal combineLatest:@[
                                                              self.accountTF.rac_textSignal,
                                                              self.codeTF.rac_textSignal,
                                                              self.passwdTF.rac_textSignal
                                                              ]
                                                     reduce:^id{
                                                         return @(self.accountTF.text.length > 0
                                                         && self.codeTF.text.length > 0
                                                         && self.passwdTF.text.length > 0
                                                         && [self.passwdTF.text isEqualToString:self.codeTF.text]
                                                         );
                                                     }];
        
    }
}

#pragma mark - private method

- (void)nextAction:(UIButton *)sender {
    NSLog(@"------------------------------");
    [self.view endEditing:YES];
    
    __weak typeof(self) weakSelf = self;

    NSDictionary *params = @{
                             @"userid" : @([CPUserInfoModel shareInstance].loginModel.ID),
                             @"oldpassword" : cp_md5(self.accountTF.text),
                             @"password" : cp_md5(self.passwdTF.text)
                             };
    [CPBaseModel modelRequestWith:CPURL_ASSISTANT_UPDATE_USER_PASSWD
                       parameters:params
                            block:^(id result) {
                                [weakSelf handleNextActionBlock:result];
                            } fail:^(CPError *error) {
                            }];

//    [CPBaseModel modelPostRequestWith:CPURL_ASSISTANT_UPDATE_USER_PASSWD
//                           parameters:params
//                                block:^(id result) {
//
//                                } fail:^(NSError *error) {
//
//                                }];
}

- (void)handleNextActionBlock:(CPBaseModel *)result {
    
    [[CPProgress Instance] showSuccess:self.view
                               message:result.msg
                                finish:^(BOOL finished) {
//                                    [self.navigationController popViewControllerAnimated:YES];
                                    CPLoginVC *vc = [[CPLoginVC alloc] init];
                                    vc.hidesBottomBarWhenPushed = YES;
                                    
                                    [self.navigationController pushViewController:vc animated:YES];
                                }];
}


@end
