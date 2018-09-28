//
//  CPShopRegistVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopRegistLoginVC.h"
#import "CPRegistStepView.h"
#import "CPSendCodeButton.h"
#import "CPCheckBox.h"
#import "CPWebVC.h"

@interface CPShopRegistLoginVC ()

@property (nonatomic, strong) CPTextField *accountTF, *codeTF, *passwdTF, *confirmTF;
@property (nonatomic, strong) CPSendCodeButton *sendCodeBT;
@property (nonatomic, strong) CPCheckBox *checkBox;
@property (nonatomic, assign) BOOL agreeProtocol;
@property (nonatomic, strong) CPButton *nextBT;

@property (nonatomic, strong) CPTextField *shopCodeTF;

@end

@implementation CPShopRegistLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)setupUI {
    
    CPRegistStepView *stepView = nil;

    if (self.registType == CPRegistTypeMember) {
        
        stepView = [[CPRegistStepView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREENWIDTH, 44.9f) itemTitles:@[ @"注册只需3步",@"登录信息",@"会员信息"]];
        stepView.currentStep = 0;
        
        [self.view addSubview:stepView];
    } else {
        stepView = [[CPRegistStepView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREENWIDTH, 44.9f)];
        stepView.currentStep = 0;
        
        [self.view addSubview:stepView];
    }


    if (nil == self.accountTF) {
        self.accountTF = [CPTextField new];
        self.accountTF.font = [UIFont systemFontOfSize:13.0f];
        self.accountTF.placeholder = @"手机号码(门店负责人联系方式)";
        self.accountTF.borderStyle = UITextBorderStyleRoundedRect;
        self.accountTF.keyboardType = UIKeyboardTypeNumberPad;
        
        [self.view addSubview:self.accountTF];
        
        [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(stepView.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];

    }
    
    if (nil == self.sendCodeBT) {
        self.sendCodeBT = [[CPSendCodeButton alloc] initWithFrame:CGRectMake(0, 110, 120, CELL_HEIGHT_F)];
        self.sendCodeBT.layer.cornerRadius = 5.0f;
        self.sendCodeBT.clipsToBounds = YES;
        [self.sendCodeBT setBackgroundImage:CPEnableImage forState:UIControlStateNormal];
        [self.sendCodeBT setBackgroundImage:CPDisableImage forState:UIControlStateDisabled];
        [self.sendCodeBT setTitle:@"获取验证码" forState:UIControlStateNormal];
        
        [self.view addSubview:self.sendCodeBT];
        
        [self.sendCodeBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-cellSpaceOffset);
            make.top.mas_equalTo(self.accountTF.mas_bottom).offset(cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
            make.width.mas_equalTo(120.0f);
        }];
        
        RAC(self.sendCodeBT,enabled) = [RACSignal combineLatest:@[self.accountTF.rac_textSignal] reduce:^id{
            self.sendCodeBT.phoneNumber = self.accountTF.text;
            return @(CheckPhone(self.accountTF.text));
        }];
    }
    
    if (nil == self.codeTF) {
        self.codeTF = [CPTextField new];
        self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
        self.codeTF.font = [UIFont systemFontOfSize:13.0];
        self.codeTF.borderStyle = UITextBorderStyleRoundedRect;
        self.codeTF.placeholder = @"验证码(4位)";
        
        [self.view addSubview:self.codeTF];
        
        [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.sendCodeBT.mas_top);
            make.left.mas_equalTo(cellSpaceOffset);
            make.bottom.mas_equalTo(self.sendCodeBT.mas_bottom);
            make.right.mas_equalTo(self.sendCodeBT.mas_left).offset(-8);
        }];

    }

    if (nil == self.passwdTF) {
        self.passwdTF = [CPTextField new];
//        self.passwdTF.keyboardType = UIKeyboardTypeNumberPad;
        self.passwdTF.font = [UIFont systemFontOfSize:13.0];
        self.passwdTF.borderStyle = UITextBorderStyleRoundedRect;
        self.passwdTF.placeholder = @"设置登录密码";
        self.passwdTF.secureTextEntry = YES;
        
        [self.view addSubview:self.passwdTF];
        
        [self.passwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.codeTF.mas_bottom).offset(cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            
        }];
    }
    
    if (nil == self.confirmTF) {
        self.confirmTF = [CPTextField new];
//        self.confirmTF.keyboardType = UIKeyboardTypeNumberPad;
        self.confirmTF.font = [UIFont systemFontOfSize:13.0];
        self.confirmTF.borderStyle = UITextBorderStyleRoundedRect;
        self.confirmTF.placeholder = @"确认登陆密码";
        self.confirmTF.secureTextEntry = YES;
        
        [self.view addSubview:self.confirmTF];
        
        [self.confirmTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwdTF.mas_bottom).offset(cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
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

        
        __weak CPShopRegistLoginVC *weakSelf = self;
        
        self.checkBox = [[CPCheckBox alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.checkBox.content = attr0;
        self.checkBox.actionBlock = ^(BOOL aggree) {
            [weakSelf handleAgreeProtocolBlock:aggree];
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

        [self.view addSubview:self.checkBox];
        
        [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.confirmTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(20);
        }];
    }
    
    if(nil == self.nextBT){
        self.nextBT = [[CPButton alloc] initWithFrame:CGRectZero];
        [self.nextBT setTitle:@"下一步" forState:0];
        [self.nextBT addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:self.nextBT];
        
        [self.nextBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.checkBox.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
        RAC(self.nextBT,enabled) = [RACSignal combineLatest:@[
                                                         self.accountTF.rac_textSignal,
                                                         self.codeTF.rac_textSignal,
                                                         self.passwdTF.rac_textSignal,
                                                         self.confirmTF.rac_textSignal]
                                                reduce:^id{
                                                    return @(
                                                    CheckPhone(self.accountTF.text)
                                                    && self.codeTF.text.length == 4
                                                    && self.passwdTF.text.length > 0
                                                    && self.confirmTF.text.length > 0
                                                    && ([self.confirmTF.text isEqualToString: self.passwdTF.text])
                                                    && self.agreeProtocol);
        }];
        
    }
}

- (void)handleAgreeProtocolBlock:(NSInteger )agrree {
    self.agreeProtocol = agrree;
    
    self.nextBT.enabled = CheckPhone(self.accountTF.text)
    && self.codeTF.text.length == 4
    && self.passwdTF.text.length > 5
    && self.confirmTF.text.length > 5
    && ([self.confirmTF.text isEqualToString:self.passwdTF.text])
    && self.agreeProtocol;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)nextAction:(UIButton *)sender {
    NSLog(@"------------------------------");
    
    [CPRegistParam shareInstance].phone = self.accountTF.text;
    [CPRegistParam shareInstance].sms = self.codeTF.text;
    [CPRegistParam shareInstance].password = cp_md5(self.confirmTF.text);

    if (self.registType == CPRegistTypeMember) {
        [self push2VCWith:@"CPMemberRegisterStep01VC" title:@"会员注册"];
    } else {
        [self push2VCWith:@"CPShopRegistInfoTBVC" title:@"门店注册"];
    }
}

@end
