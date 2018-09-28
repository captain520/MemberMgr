//
//  CPLoginVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPLoginVC.h"
#import "CPSendCodeButton.h"
#import "CPRegisterTypeListVC.h"
#import "CPShopTabBarController.h"
#import "CPShippingInformationListVC.h"
#import "CPLoginModel.h"
#import "CPUserOperationModel.h"
#import "CPCustomerHelpModel.h"
#import "CPConfigUrlModel.h"

typedef NS_ENUM(NSInteger, CPLoginType){
    CPLoginTypePasswd,
    CPLoginTypeCode,
};

@interface CPLoginVC ()

@property (nonatomic, strong) UIImageView *logoIV;
@property (nonatomic, strong) UITextField *accountTF, *passwdTF;
@property (nonatomic, strong) UIButton *loginBT;
@property (nonatomic, strong) CPSendCodeButton *sendCodeBT;
@property (nonatomic, assign) CPLoginType loginType;

@end

@implementation CPLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)tap3Action:(id)sender {
//    self.accountTF.text = @"15179676384";
//    self.passwdTF.text = @"1234567";
}

- (void)setupUI {
    
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3Action:)];
        tap.numberOfTapsRequired = 3;
        [self.view addGestureRecognizer:tap];
    }
    
    if (nil == self.logoIV) {
        self.logoIV = [UIImageView new];
        self.logoIV.image = CPImage(@"logo");
        
        [self.view addSubview:self.logoIV];
        
        [self.logoIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(100.0f);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
    }
    
    NSDictionary *params = [NSKeyedUnarchiver unarchiveObjectWithFile:cp_documentFilePath(@"LoginInfo")];

    if (nil == self.accountTF) {
        self.accountTF = [UITextField new];
        self.accountTF.placeholder = @"请输入您的手机号码/会员编号";
//        self.accountTF.text = @"15814099327";
//        self.accountTF.text = @"13407065418";   // 子会员
        self.accountTF.text = @"15179676384";
//        self.accountTF.text = @"18033446838";
//        self.accountTF.text = @"17063893998";
        if (params[@"phone"]) {
            self.accountTF.text = params[@"phone"];
        }
        self.accountTF.borderStyle = UITextBorderStyleRoundedRect;
//        self.accountTF.keyboardType = UIKeyboardTypeNumberPad;
        self.accountTF.font = [UIFont systemFontOfSize:15.0f];
        self.accountTF.tintColor = MainColor;
        
        [self.view addSubview:self.accountTF];
        
        [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.logoIV.mas_bottom).offset(2 * cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(44.0f);
        }];
    }
    
    if (nil == self.sendCodeBT) {
        self.sendCodeBT = [[CPSendCodeButton alloc] initWithFrame:CGRectMake(0, 0, 120, 44.0f)];
        self.sendCodeBT.layer.cornerRadius = 5.0f;
        self.sendCodeBT.clipsToBounds = YES;
        [self.sendCodeBT setBackgroundImage:CPEnableImage forState:UIControlStateNormal];
        [self.sendCodeBT setBackgroundImage:CPDisableImage forState:UIControlStateDisabled];
        [self.sendCodeBT setTitle:@"获取验证码" forState:UIControlStateNormal];
        RAC(self.sendCodeBT,enabled) = [RACSignal combineLatest:@[self.accountTF.rac_textSignal] reduce:^id{
            
            self.sendCodeBT.phoneNumber = self.accountTF.text;
            
            return @(CheckPhone(self.accountTF.text));
        }];
        
        [self.view addSubview:self.sendCodeBT];
        
        [self.sendCodeBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-cellSpaceOffset);
            make.top.mas_equalTo(self.accountTF.mas_bottom).offset(cellSpaceOffset);
            make.height.mas_equalTo(44.0f);
            make.width.mas_equalTo(0.0f);
        }];
    }

    if (nil == self.passwdTF) {
        self.passwdTF = [UITextField new];
        self.passwdTF.placeholder = @"请输入您的登陆密码";
//        self.passwdTF.text = @"123456";
        self.passwdTF.borderStyle = UITextBorderStyleRoundedRect;
//        self.passwdTF.keyboardType = UIKeyboardTypeNumberPad;
        self.passwdTF.font = [UIFont systemFontOfSize:15.0f];
        self.passwdTF.tintColor = MainColor;
        self.passwdTF.secureTextEntry = YES;
        
        if (params[@"password"]) {
            self.passwdTF.text = params[@"password"];
        }

        [self.view addSubview:self.passwdTF];
        
        [self.passwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.accountTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(self.accountTF.mas_left);
            make.right.mas_equalTo(self.sendCodeBT.mas_left);
            make.height.mas_equalTo(44.0f);
        }];
    }
    
    UIButton *loginTypeSwitchButton = [UIButton new];
    [loginTypeSwitchButton setTitleColor:C33 forState:UIControlStateNormal];
    [loginTypeSwitchButton setAttributedTitle:[self getAttributedText:@"使用短信验证码登录"] forState:UIControlStateNormal];
    [loginTypeSwitchButton addTarget:self action:@selector(switchLoginType:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:loginTypeSwitchButton];
    
    [loginTypeSwitchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwdTF.mas_bottom).offset(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.height.mas_equalTo(30.0f);
    }];
    
    if (nil == self.loginBT) {
        self.loginBT = [UIButton new];
        self.loginBT.clipsToBounds = YES;
        self.loginBT.layer.cornerRadius = 5.0f;
        
        [self.loginBT setTitle:@"立即登录" forState:UIControlStateNormal];
        [self.loginBT setBackgroundImage:CPEnableImage forState:UIControlStateNormal];
        [self.loginBT setBackgroundImage:CPDisableImage forState:UIControlStateDisabled];
        [self.loginBT addTarget:self action:@selector(loginAction:) forControlEvents:64];

        [self.view addSubview:self.loginBT];
        
        [self.loginBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(loginTypeSwitchButton.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(self.accountTF.mas_left);
            make.right.mas_equalTo(self.accountTF.mas_right);
            make.height.mas_equalTo(44.0f);
        }];
    }
    
    
    UIButton *registBT = [UIButton new];
    [registBT setTitleColor:C33 forState:UIControlStateNormal];
    [registBT setAttributedTitle:[self getAttributedText:@"立即注册"] forState:UIControlStateNormal];
    [registBT addTarget:self action:@selector(push2RegisterVC) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:registBT];
    
    [registBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBT.mas_bottom).offset(cellSpaceOffset);
        make.right.mas_equalTo(loginTypeSwitchButton.mas_right);
        make.height.mas_equalTo(30.0f);
    }];
    
    {
        RAC(self.loginBT, enabled) = [RACSignal combineLatest:@[self.accountTF.rac_textSignal,self.passwdTF.rac_textSignal] reduce:^id{
            return @(/*CheckPhone(self.accountTF.text) && */self.passwdTF.text.length > 0);
        }];
    }
    
    
    {
        CPLabel *companyNameLB = [CPLabel new];
        companyNameLB.text = @"深圳市奇积网络科技有限公司";
        companyNameLB.textAlignment = NSTextAlignmentCenter;
        companyNameLB.textColor = C66;
        
        [self.view addSubview:companyNameLB];
        [companyNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-60.0f);
        }];
    }

}

#pragma mark - Setter && getter method

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSAttributedString *)getAttributedText:(NSString *)text {

    NSDictionary *option = @{
                              NSForegroundColorAttributeName : C33,
                              NSFontAttributeName : [UIFont systemFontOfSize:12.0f],
                              NSUnderlineStyleAttributeName : @1
                              };
    
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:text attributes:option];
    

    return attr;
}

#pragma mark - Priavet method

- (void)switchLoginType:(UIButton *)sender {
    
    if (self.loginType == CPLoginTypePasswd) {
        
        //  当前是短信验证码登录，可切换到密码登录
        self.loginType = CPLoginTypeCode;
        
        [sender setAttributedTitle:[self getAttributedText:@"使用密码登录"] forState:0];
        self.passwdTF.placeholder = @"请输入您收到的短信验证码";
        
        [self.sendCodeBT mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(120.0f);
        }];
        
        [self.passwdTF mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.sendCodeBT.mas_left).offset(-cellSpaceOffset / 2);
        }];

    } else if (self.loginType == CPLoginTypeCode) {
        
        //  当前是密码登录，可切换到短信验证码登录
        self.loginType = CPLoginTypePasswd;
        
        self.passwdTF.placeholder = @"请输入您的登陆密码";
        
        [sender setAttributedTitle:[self getAttributedText:@"使用短信验证码登录"] forState:0];
        
        [self.sendCodeBT mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0.0f);
        }];
        
        [self.passwdTF mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.sendCodeBT.mas_left).offset(0);
        }];
    }
}

- (void)push2RegisterVC {
    
    CPRegisterTypeListVC *registerVC = [[CPRegisterTypeListVC alloc] init];
    
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)loginAction:(UIButton *)sender {
    
    NSString *url = nil;
    
    NSDictionary *params = @{
                             @"phone" : self.accountTF.text,
                             @"password" : cp_md5(self.passwdTF.text),
                             @"type" : @"2",
                             @"push_token" : [CPUserInfoModel shareInstance].push_token ? [CPUserInfoModel shareInstance].push_token : @""
                             };
    
    if (self.loginType == CPLoginTypePasswd) {
        url = CPURL_USER_PASSWD_LOGIN;
        [NSKeyedArchiver archiveRootObject:params toFile:cp_documentFilePath(@"LoginInfo")];
    } else if (self.loginType == CPLoginTypeCode) {
        url = CPURL_USER_MESSAGE_CODE_LOGIN;;
        
        params = @{
                                 @"phone" : self.accountTF.text,
                                 @"sms" : self.passwdTF.text
                                 };
    }

//    DDLogInfo(@"------------------------------");
//    [CPBaseModel modelRequestWith:DOMAIN_ADDRESS@"/api/user/getDetailUserInfo"
//                       parameters:@{@"userid" : @1}
//                            block:^(id result) {
//                                NSLog(@"%@",result);
//                            } fail:^(NSError *error) {
//                                
//                            }];
    
    __weak CPLoginVC *weakSelf = self;

    [CPLoginModel modelRequestWith:url
                        parameters:params
                             block:^(CPLoginModel *result) {
                                 [weakSelf handleLoginBlock:result];
                             } fail:^(NSError *error) {
                                 
                             }];
    
    [CPUserOperationModel modelRequestWith:DOMAIN_ADDRESS@"/api/Goodsoperation/findGoodsOperation"
                       parameters:nil
                            block:^(CPUserOperationModel *result) {
                                [CPUserInfoModel shareInstance].operationDes = result.result;
                            } fail:^(CPError *error) {
                                
                            }];
    
    [CPCustomerHelpModel modelRequestWith:DOMAIN_ADDRESS@"/api/Sysinfo/getSysInfo"
                               parameters:nil
                                    block:^(CPCustomerHelpModel *result) {
                                        [CPUserInfoModel shareInstance].customerHelpModel = result;
                                    } fail:^(CPError *error) {
                                        
                                    }];
    
    [CPConfigUrlModel modelRequestWith:DOMAIN_ADDRESS@"/api/sysconfig/getSysConfigByCode"
                            parameters:@{@"code" : @"100"}
                                 block:^(CPConfigUrlModel *result) {
//                                     [CPUserInfoModel shareInstance].helpHtml = result.Description;
                                 } fail:^(CPError *error) {
                                     
                                 }];
}

- (void)handleLoginBlock:(CPLoginModel *)result {

    if (result.Typeid != 3 && result.Typeid != 4 && result.Typeid != 6 && result.Typeid != 7) {
        [self.view makeToast:@"账号不存在" duration:2.0f position:CSToastPositionCenter];
        return;
    };
    

    __weak typeof(self) weakSelf = self;
    
    if (!result.linkname) {
        result.linkname = @"匿名用户";
    }
    [CPUserInfoModel shareInstance].isLogined = YES;
    [CPUserInfoModel shareInstance].isShop = result.Typeid == 3;;
    [CPUserInfoModel shareInstance].loginModel = result;
    
    [[CPProgress Instance] showSuccess:self.view
                               message:@"登陆成功"
                                finish:^(BOOL finished) {
                                    DDLogInfo(@"------------------------------");
                                    [weakSelf back];
//                                    CPShopTabBarController *tbVC = (CPShopTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//                                    [tbVC initializedBaseViewControllersFor:result.Typeid];
////                                    if ([CPUserInfoModel shareInstance].isShop) {
////                                        [tbVC initializedBaseViewControllersFor:CPTabVCTypeShop];
////                                    } else {
////                                        [tbVC initializedBaseViewControllersFor:CPTabVCTypeAssistant];
////                                    }
//
//                                    [weakSelf.navigationController popViewControllerAnimated:NO];
//                                        [tbVC setSelectedIndex:0];
////                                    [weakSelf dismissViewControllerAnimated:YES completion:^{
////                                        [tbVC setSelectedIndex:0];
////                                    }];
                                }];
    
    [self loadUserDetailInfo];
}

/**
 获取用户详细信息
 */
- (void)loadUserDetailInfo {
    
    __weak typeof(self) weakSelf = self;
    
    [CPUserDetailInfoModel modelRequestWith:DOMAIN_ADDRESS@"/api/user/getDetailUserInfo"
                                 parameters:@{@"userid" : @([CPUserInfoModel shareInstance].loginModel.ID)}
                                      block:^(CPUserDetailInfoModel *result) {
                                          [weakSelf handleLoadUserDetailinfoBlock:result];
                                      } fail:^(NSError *error) {
                                          
                                      }];
}

- (void)handleLoadUserDetailinfoBlock:(CPUserDetailInfoModel *)result {
    if (result && [result isKindOfClass:[CPUserDetailInfoModel class]]) {
        [CPUserInfoModel shareInstance].userDetaiInfoModel = result;
    }
}

@end
