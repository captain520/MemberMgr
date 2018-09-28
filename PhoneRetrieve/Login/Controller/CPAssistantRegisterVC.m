//
//  CPAssistantRegisterVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/6.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPAssistantRegisterVC.h"
#import "CPSendCodeButton.h"
#import "CPCheckBox.h"
#import <TZImagePickerController.h>
#import "CPPhotoUploadBT.h"
#import "CPAssistantRegisterParam.h"
#import "CPWebVC.h"

@interface CPAssistantRegisterVC ()

@property (nonatomic, strong) CPTextField *nameTF, *shopCodeTF, *accountTF, *codeTF, *passwdTF, *confirmTF;
@property (nonatomic, strong) CPSendCodeButton *sendCodeBT;
@property (nonatomic, strong) CPCheckBox *checkBox;
@property (nonatomic, assign) BOOL agreeProtocol;
@property (nonatomic, strong) CPButton *nextBT;

@property (nonatomic, strong) CPPhotoUploadBT *IDFrontBT, *IDBackBT;

@end

@implementation CPAssistantRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {

    {
        self.nameTF = [CPTextField new];
        self.nameTF.placeholder = @"用户名";
        [self.view addSubview:self.nameTF];
        [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(cellSpaceOffset + NAV_HEIGHT);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }

    {
        
        self.shopCodeTF = [CPTextField new];
        self.shopCodeTF.placeholder = @"门店编码";
        [self.view addSubview:self.shopCodeTF];
        [self.shopCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(cellSpaceOffset + NAV_HEIGHT);
            make.top.mas_equalTo(self.nameTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }

    if (nil == self.accountTF) {
        self.accountTF = [CPTextField new];
        self.accountTF.font = [UIFont systemFontOfSize:13.0f];
        self.accountTF.placeholder = @"手机号码";
        self.accountTF.borderStyle = UITextBorderStyleRoundedRect;
        self.accountTF.keyboardType = UIKeyboardTypeNumberPad;
        
        [self.view addSubview:self.accountTF];
        
        [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.shopCodeTF.mas_bottom).offset(cellSpaceOffset);
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
        
        RAC(self.sendCodeBT, enabled) = [RACSignal combineLatest:@[self.accountTF.rac_textSignal] reduce:^id{
            self.sendCodeBT.phoneNumber = self.accountTF.text;
            return @(CheckPhone(self.accountTF.text));
        }];
        
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
        self.codeTF.placeholder = @"短信验证码";
        
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
        self.confirmTF.keyboardType = UIKeyboardTypeNumberPad;
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
    
    if (nil == self.IDFrontBT) {
        
        self.IDFrontBT = [CPPhotoUploadBT new];
//        self.IDFrontBT.backgroundColor = UIColor.redColor;
        //        [self.IDFrontBT setImage:CPImage(@"header.jpg") forState:0];
        [self.IDFrontBT setBackgroundImage:CPImage(@"add_pic") forState:UIControlStateNormal];
        [self.IDFrontBT addTarget:self action:@selector(showImagePickVC:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.IDFrontBT];
        
        [self.IDFrontBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.confirmTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.size.mas_equalTo(CGSizeMake(2 * CELL_HEIGHT_F, 2 * CELL_HEIGHT_F));
        }];
        
        CPLabel *titleLB = [CPLabel new];
        titleLB.text = @"身份证正面";
        titleLB.textColor = [UIColor redColor];
        titleLB.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:titleLB];
        
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IDFrontBT.mas_bottom).offset(4);
            make.left.mas_equalTo(self.IDFrontBT.mas_left);
            make.right.mas_equalTo(self.IDFrontBT.mas_right);
        }];
    }
    
    if (nil == self.IDBackBT) {
        
        self.IDBackBT = [CPPhotoUploadBT new];
//        self.IDBackBT.backgroundColor = UIColor.redColor;
        //        [self.IDBackBT setImage:CPImage(@"header.jpg") forState:0];
        [self.IDBackBT setBackgroundImage:CPImage(@"add_pic") forState:UIControlStateNormal];
        [self.IDBackBT addTarget:self action:@selector(showImagePickVC:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.IDBackBT];
        
        [self.IDBackBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IDFrontBT.mas_top);
            make.left.mas_equalTo(self.IDFrontBT.mas_right).offset(cellSpaceOffset);
            make.size.mas_equalTo(CGSizeMake(2 * CELL_HEIGHT_F, 2 * CELL_HEIGHT_F));
        }];
        
        CPLabel *titleLB = [CPLabel new];
        titleLB.text = @"身份证背面";
        titleLB.textColor = [UIColor redColor];
        titleLB.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:titleLB];
        
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IDBackBT.mas_bottom).offset(4);
            make.left.mas_equalTo(self.IDBackBT.mas_left);
            make.right.mas_equalTo(self.IDBackBT.mas_right);
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
        
        
        __weak CPAssistantRegisterVC *weakSelf = self;
        
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
            make.top.mas_equalTo(self.IDFrontBT.mas_bottom).offset(50);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(20);
        }];
    }
    
    if(nil == self.nextBT){
        self.nextBT = [[CPButton alloc] initWithFrame:CGRectZero];
        [self.nextBT setTitle:@"立即注册" forState:0];
        [self.nextBT addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.nextBT];
        
        [self.nextBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.checkBox.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
        
        
        RAC(self.nextBT,enabled) = [RACSignal combineLatest:@[
                                                              self.shopCodeTF.rac_textSignal,
                                                              self.accountTF.rac_textSignal,
                                                              self.codeTF.rac_textSignal,
                                                              self.passwdTF.rac_textSignal,
                                                              self.confirmTF.rac_textSignal,
                                                              self.nameTF.rac_textSignal
                                                              ]
                                                     reduce:^id{
                                                         return @(
                                                         self.shopCodeTF.text.length > 0
                                                         && CheckPhone(self.accountTF.text)
                                                         && self.codeTF.text.length == 4
                                                         && self.passwdTF.text.length > 0
                                                         && self.confirmTF.text.length > 0
                                                         && ([self.confirmTF.text isEqualToString: self.passwdTF.text])
                                                         && self.agreeProtocol
                                                         && self.IDFrontBT.currentImage
                                                         && self.IDBackBT.currentImage
                                                         && self.nameTF.text.length > 0
                                                         );
                                                     }];
        
    }
}

- (void)handleAgreeProtocolBlock:(NSInteger )agrree {
    self.agreeProtocol = agrree;
    
    self.nextBT.enabled = self.shopCodeTF.text.length > 0
    && self.nameTF.text.length > 0
    && CheckPhone(self.accountTF.text)
    && self.agreeProtocol
    && self.IDBackBT.currentImage
    && self.IDFrontBT.currentImage
    && self.codeTF.text.length > 0
    && self.passwdTF.text.length > 0
    && self.confirmTF.text.length > 0
    && ([self.confirmTF.text isEqualToString:self.passwdTF.text]);
}

#pragma mark - private method

- (void)showImagePickVC:(CPPhotoUploadBT *)sender {
    
    __weak CPAssistantRegisterVC *weakSelf = self;
    
    TZImagePickerController *vc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    
    [vc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        dispatch_async(dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setImage:photos.firstObject forState:UIControlStateNormal];
                
                [[CPProgress Instance] showLoading:self.view message:@"图片上传中"];
                
                [CPBaseModel uploadImages:photos.firstObject block:^(NSString *filePath) {
                    DDLogError(@">>>>>>>>>>>>>>>>>>>>%@",filePath);
                    sender.imageUrl = filePath;
                    [[CPProgress Instance] hidden];
                }];
                
                [weakSelf handleImagePickImageBlock];
            });
        });
    }];
    
    
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav presentViewController:vc animated:YES completion:nil];
}

- (void)handleImagePickImageBlock {
    
    self.nextBT.enabled = self.accountTF.text.length > 0
    && self.nameTF.text.length > 0
    && self.agreeProtocol
    && self.IDBackBT.currentImage
    && self.IDFrontBT.currentImage
    && self.codeTF.text.length > 0
    && self.passwdTF.text.length > 0
    && self.confirmTF.text.length > 0
    && (self.confirmTF.text == self.accountTF.text);
}

- (void)nextAction:(UIButton *)sender {
    [CPAssistantRegisterParam shareInstance].linkname = self.nameTF.text;
    [CPAssistantRegisterParam shareInstance].code = self.shopCodeTF.text;
    [CPAssistantRegisterParam shareInstance].phone = self.accountTF.text;
    [CPAssistantRegisterParam shareInstance].sms = self.codeTF.text;
    [CPAssistantRegisterParam shareInstance].password = cp_md5(self.confirmTF.text);
    [CPAssistantRegisterParam shareInstance].idcard1url = self.IDFrontBT.imageUrl;
    [CPAssistantRegisterParam shareInstance].idcard2url = self.IDBackBT.imageUrl;
    
    __weak CPAssistantRegisterVC *weakSelf = self;
    
    NSDictionary *params = [[CPAssistantRegisterParam shareInstance] mj_keyValues];

//    [[CPProgress Instance] showLoading:self.view message:@"数据提交中"];
    [CPBaseModel modelRequestWith:CPURL_USER_ASSISTANT_REGISTER parameters:params block:^(CPBaseModel *result) {
        [weakSelf handleAssistanteRegisterSuccessBlock:result];
    } fail:^(CPError *error) {
        [weakSelf handleRegisterAssistanteFail:error];
    }];
}

- (void)handleAssistanteRegisterSuccessBlock:(CPBaseModel *)model {
    
    [[CPProgress Instance] showSuccess:self.view
                               message:@"注册成功"
                                finish:^(BOOL finished) {
                                    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                        
                                        if([NSStringFromClass(obj.class) isEqualToString:@"CPLoginVC"]) {
                                            [self.navigationController popToViewController:obj animated:YES];
                                            *stop = YES;
                                        }

                                    }];
                                }];
}

- (void)handleRegisterAssistanteFail:(CPError *)error {
    [self.view makeToast:error.cp_msg duration:1.0f position:CSToastPositionCenter];
}

@end
