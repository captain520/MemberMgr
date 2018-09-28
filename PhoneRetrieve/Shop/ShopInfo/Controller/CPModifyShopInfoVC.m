//
//  CPModifyShopInfoVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPModifyShopInfoVC.h"

@interface CPModifyShopInfoVC ()

@property (nonatomic, strong) CPTextField *accountTF, *codeTF, *passwdTF;
@property (nonatomic, strong) CPButton *nextBT;
@property (nonatomic, strong) NSArray *placeHolds;

@end

@implementation CPModifyShopInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setType:(CPModifyShopInfoType)type {
    
    _type = type;
    
    switch (type) {
        case CPModifyShopInfoTypeModifyShopInfo:
            self.placeHolds = @[
                                @"门店负责人",
                                @"手机号码",
                                @"邮箱"
                                ];
            
            break;
        case CPModifyShopInfoTypeModifyBankAccount:
            self.placeHolds = @[
                                @"持卡人名称",
                                @"银行卡号",
                                @"开户支行"
                                ];
            
            break;
        case CPModifyShopInfoTypeModifyAlipayAccount:
            self.placeHolds = @[
                                @"支付宝名称",
                                @"支付宝账号",
                                @""
                                ];
            break;
        case CPModifyShopInfoTypeModifyWechatAccount:
            self.placeHolds = @[
                                @"微信名称",
                                @"微信账号",
                                @""
                                ];
            
            break;
            
        default:
            break;
    }

    [self setupUI];
}

- (void)setupUI {
    
    if (nil == self.accountTF) {
        self.accountTF = [CPTextField new];
        self.accountTF.font = [UIFont systemFontOfSize:13.0f];
        self.accountTF.placeholder = self.placeHolds[0];
        self.accountTF.borderStyle = UITextBorderStyleRoundedRect;
        self.accountTF.keyboardType = UIKeyboardTypeNumberPad;
        
        [self.view addSubview:self.accountTF];
        
        [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0).offset(NAV_HEIGHT + cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
    }

    if (nil == self.codeTF) {
        self.codeTF = [CPTextField new];
        self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
        self.codeTF.font = [UIFont systemFontOfSize:13.0];
        self.codeTF.borderStyle = UITextBorderStyleRoundedRect;
        self.codeTF.placeholder = self.placeHolds[1];
        
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
        self.passwdTF.placeholder = self.placeHolds[2];

        [self.view addSubview:self.passwdTF];
        
        [self.passwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.codeTF.mas_bottom).offset(cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
        }];
        
        if (self.type == CPModifyShopInfoTypeModifyAlipayAccount || self.type == CPModifyShopInfoTypeModifyWechatAccount) {
            self.passwdTF.hidden = YES;
        }
    }

    if(nil == self.nextBT){
        self.nextBT = [[CPButton alloc] initWithFrame:CGRectZero];
        [self.nextBT setTitle:@"确认修改" forState:0];
        [self.nextBT addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.nextBT];
        
        [self.nextBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwdTF.mas_bottom).offset(1 * CELL_HEIGHT_F);
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
                                                         && self.passwdTF.text.length > 0);
                                                     }];
        
    }
}

#pragma mark - private method

- (void)nextAction:(UIButton *)sender {
    NSLog(@"------------------------------");
    [self.view endEditing:YES];
}
                                                         
                                                         

@end
