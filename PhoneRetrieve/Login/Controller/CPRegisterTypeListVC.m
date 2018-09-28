//
//  CPRegisterVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRegisterTypeListVC.h"
#import "CPButton.h"
#import "CPLoginVC.h"
#import "CPShopRegistLoginVC.h"

@interface CPRegisterTypeListVC ()

@property (nonatomic, strong) UIImageView *logoIV;
@property (nonatomic, strong) CPButton *shopRegisterBt, *assistantRegisterBt;
@property (nonatomic, strong) CPButton *memberRegisterBT;

@end

@implementation CPRegisterTypeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    self.navigationItem.rightBarButtonItem = nil;
    
    [self setTitle:@"注册类型"];
}

- (void)setupUI {
    
    self.view.backgroundColor = UIColor.whiteColor;

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
    
    //  门店注册
    if (nil == self.shopRegisterBt) {
        self.shopRegisterBt = [[CPButton alloc] initWithFrame:CGRectZero];
        [self.shopRegisterBt setTitle:@"门店注册" forState:0];
        [self.shopRegisterBt addTarget:self action:@selector(pus2ShopRegistVC) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.shopRegisterBt];
        
        [self.shopRegisterBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.logoIV.mas_bottom).offset(CELL_HEIGHT_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    //  店员注册
    if (nil == self.assistantRegisterBt) {
        self.assistantRegisterBt = [[CPButton alloc] initWithFrame:CGRectZero];
        [self.assistantRegisterBt setTitle:@"店员注册" forState:0];
//        UIImage *image = [UIImage imageWithColor:UIColor.blueColor];
        UIColor *blueColor = [UIColor colorWithRed:80./255 green:170./255 blue:250./255 alpha:1];
        [self.assistantRegisterBt setBackgroundImage:[UIImage imageWithColor:blueColor] forState:UIControlStateNormal];
        [self.assistantRegisterBt addTarget:self action:@selector(pus2AssistantRegistVC) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.assistantRegisterBt];
        
        [self.assistantRegisterBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.shopRegisterBt.mas_bottom).offset(CELL_HEIGHT_F / 2);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    {
        self.memberRegisterBT = [[CPButton alloc] initWithFrame:CGRectZero];
        [self.memberRegisterBT setTitle:@"会员注册" forState:0];
        //        UIImage *image = [UIImage imageWithColor:UIColor.blueColor];
        UIColor *blueColor = UIColor.blueColor;
        [self.memberRegisterBT setBackgroundImage:[UIImage imageWithColor:blueColor] forState:UIControlStateNormal];
        [self.memberRegisterBT addTarget:self action:@selector(pus2MemberRegistVC) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.memberRegisterBT];
        
        [self.memberRegisterBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.assistantRegisterBt.mas_bottom).offset(CELL_HEIGHT_F / 2);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
    }
    
    {
        UIButton *loginBt = [UIButton new];
        [loginBt setTitleColor:C33 forState:0];
        [loginBt setAttributedTitle:[self getAttributedText:@"我已有账号， " strokText:@"立即登录"] forState:0];
        [loginBt addTarget:self action:@selector(push2LoginVC) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:loginBt];
        
        [loginBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.memberRegisterBT.mas_bottom).offset(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
        }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
- (NSAttributedString *)getAttributedText:(NSString *)text strokText:(NSString *)strokeValue {
    

    NSDictionary *option0 = @{
                             NSForegroundColorAttributeName : C33,
                             NSFontAttributeName : [UIFont systemFontOfSize:12.0f]
                             };
    NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:text attributes:option0];
    
    NSDictionary *option = @{
                             NSForegroundColorAttributeName : C33,
                             NSFontAttributeName : [UIFont systemFontOfSize:12.0f],
                             NSUnderlineStyleAttributeName : @1
                             };
    NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:strokeValue attributes:option];
    
    [attr0 appendAttributedString:attr1];

    
    return attr0;
}

- (void)push2LoginVC {  [self.navigationController popViewControllerAnimated:YES]; }

- (void)pus2ShopRegistVC { [self push2VCWith:@"CPShopRegistLoginVC" title:@"门店注册"];}
- (void)pus2AssistantRegistVC { [self push2VCWith:@"CPAssistantRegisterVC" title:@"店员注册"];}
- (void)pus2MemberRegistVC {
    CPShopRegistLoginVC *vc = [[CPShopRegistLoginVC alloc] init];
    vc.title = @"会员注册";
    vc.registType = CPRegistTypeMember;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
