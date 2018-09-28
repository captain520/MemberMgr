//
//  CPDeviceOwnerInfoVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPDeviceOwnerInfoVC.h"
#import "CPSendCodeButton.h"
#import "CPCheckBox.h"
#import "CPAddCartSuccessVC.h"
#import "CPWebVC.h"

@interface CPDeviceOwnerInfoVC ()

@property (nonatomic, strong) CPTextField *accountTF, *codeTF, *passwdTF, *confirmTF;
@property (nonatomic, strong) CPSendCodeButton *sendCodeBT;
@property (nonatomic, strong) CPCheckBox *checkBox;
@property (nonatomic, assign) BOOL agreeProtocol;
@property (nonatomic, strong) CPButton *nextBT;

@property (nonatomic, strong) CPTextField *shopCodeTF;

@property (nonatomic, strong) CPTextField *IDTF;

@end

@implementation CPDeviceOwnerInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self setTitle:@"客户信息"];
}

- (void)setupUI {

    if (nil == self.accountTF) {
        self.accountTF = [CPTextField new];
        self.accountTF.font = [UIFont systemFontOfSize:13.0f];
        self.accountTF.placeholder = @"客户姓名";
        self.accountTF.borderStyle = UITextBorderStyleRoundedRect;
//        self.accountTF.keyboardType = UIKeyboardTypeNumberPad;
        
        [self.view addSubview:self.accountTF];
        
        [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0).offset(NAV_HEIGHT + cellSpaceOffset);
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
    }
    
    if (nil == self.codeTF) {
        self.codeTF = [CPTextField new];
        self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
        self.codeTF.font = [UIFont systemFontOfSize:13.0];
        self.codeTF.borderStyle = UITextBorderStyleRoundedRect;
        self.codeTF.placeholder = @"客户手机号码";
        
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
        self.passwdTF.keyboardType = UIKeyboardTypeNumberPad;
        self.passwdTF.font = [UIFont systemFontOfSize:13.0];
        self.passwdTF.borderStyle = UITextBorderStyleRoundedRect;
        self.passwdTF.placeholder = @"验证码(四位)";
        
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
        self.confirmTF.keyboardType = UIKeyboardTypeNumberPad;
        self.confirmTF.font = [UIFont systemFontOfSize:13.0];
        self.confirmTF.borderStyle = UITextBorderStyleRoundedRect;
        self.confirmTF.placeholder = @"IMEI标识（15位）";
        
        [self.view addSubview:self.confirmTF];
        
        [self.confirmTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwdTF.mas_bottom).offset(cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
        }];
    }
    
    if (nil == self.IDTF) {
        self.IDTF = [CPTextField new];
        self.IDTF.keyboardType = UIKeyboardTypeNumberPad;
        self.IDTF.font = [UIFont systemFontOfSize:13.0];
        self.IDTF.borderStyle = UITextBorderStyleRoundedRect;
        self.IDTF.placeholder = @"身份证号码(可选)";
        
        [self.view addSubview:self.IDTF];
        
        [self.IDTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.confirmTF.mas_bottom).offset(cellSpaceOffset);
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
        NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:@" 我已同意"
                                                                                  attributes:option0];
        NSDictionary *option1 = @{
                                  NSFontAttributeName : [UIFont systemFontOfSize:13.0f],
                                  NSForegroundColorAttributeName : C33,
                                  NSUnderlineStyleAttributeName : @1
                                  };
        NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:@"《免责声明》" attributes:option1];
        
        [attr0 appendAttributedString:attr1];
        
        
        __weak CPDeviceOwnerInfoVC *weakSelf = self;
        
        self.checkBox = [[CPCheckBox alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.checkBox.content = attr0;
        self.checkBox.actionBlock = ^(BOOL aggree) {
            [weakSelf handleAgreeProtocolBlock:aggree];
        };
        
        self.checkBox.showHintBlock = ^{
            [weakSelf getConfigUrl:@"210" block:^(NSString *url, NSString *title) {
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
            make.top.mas_equalTo(self.IDTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(20);
        }];
    }
    
    RAC(self.sendCodeBT ,enabled) = [RACSignal combineLatest:@[self.codeTF.rac_textSignal] reduce:^id{
        self.sendCodeBT.phoneNumber = self.codeTF.text;
        
        return @(CheckPhone(self.codeTF.text));
    }];
    
    if(nil == self.nextBT){
        self.nextBT = [[CPButton alloc] initWithFrame:CGRectZero];
        [self.nextBT setTitle:@"加入回收车" forState:0];
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
                                                         return @(self.accountTF.text.length > 0
                                                         && self.codeTF.text.length > 0
                                                         && self.passwdTF.text.length > 0
                                                         && (self.confirmTF.text.length == 15 || [CPUserInfoModel shareInstance].repaircfg.integerValue == 2)
//                                                         && ([self.confirmTF.text isEqualToString: self.passwdTF.text])
                                                         && self.agreeProtocol);
                                                     }];
        
    }
}

- (void)handleAgreeProtocolBlock:(NSInteger )agrree {
    self.agreeProtocol = agrree;
    
    self.nextBT.enabled = self.accountTF.text.length > 0
    && self.codeTF.text.length > 0
    && self.passwdTF.text.length > 0
    && (self.confirmTF.text.length > 0 || [CPUserInfoModel shareInstance].repaircfg.integerValue == 2)
//    && self.confirmTF.text.length > 0
//    && (self.confirmTF.text == self.accountTF.text)
    && self.agreeProtocol;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)nextAction:(UIButton *)sender {
    NSLog(@"------------------------------");
    
    __weak CPDeviceOwnerInfoVC *weakSelf = self;
    
    NSMutableDictionary *params = @{
                             @"id" : self.model.ID,
                             @"customname" : self.accountTF.text,
                             @"customphone" : self.codeTF.text,
                             @"customimei" : self.confirmTF.text ? self.confirmTF.text : @" ",
                             @"sms" : self.passwdTF.text,
                             @"resultno" : self.model.resultno,
                             @"currentuserid" : @([CPUserInfoModel shareInstance].loginModel.ID)
                             }.mutableCopy;
    
    if (self.IDTF.text.length > 0) {
        [params setObject:self.IDTF.text forKey:@"idcard"];
    } else {
        [params setObject:@"null" forKey:@"idcard"];
    }

    [CPRetrievePriceModel modelPostRequestWith:CPURL_SHOP_SAVE_OWNER_INFO
                                    parameters:params
                                         block:^(CPRetrievePriceModel *result) {
                                             [weakSelf handleSaveOwnerInfoSuccessBlock:result];
                                         } fail:^(NSError *error) {
                                             
                                         }];

//    [self push2VCWith:@"CPAddCartSuccessVC" title:@"下单成功"];
    //    [self push2VCWith:@"CPShopRegistInfoVC" title:@"门店注册"];
}

- (void)handleSaveOwnerInfoSuccessBlock:(CPRetrievePriceModel *)result {
    
//    if (![result isKindOfClass:[CPRetrievePriceModel class]]) {
//        return;
//    }
    
    CPAddCartSuccessVC *vc = [[CPAddCartSuccessVC alloc] init];
    vc.model = self.model;
    
    [self.navigationController pushViewController:vc animated:YES];

}

@end
