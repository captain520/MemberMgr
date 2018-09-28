//
//  ZCAddMemberSuccessVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/18.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCAddMemberSuccessVC.h"

@interface ZCAddMemberSuccessVC ()

@property (nonatomic,strong) UIImageView *successIV;
@property (nonatomic,strong) CPLabel *memberCodeLB, *membPasswdLB,*hintLB;

@end

@implementation ZCAddMemberSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

#pragma mark - setter && getter method implement
#pragma mark - setupUI
- (void)setupUI {
    
    self.title = @"新增完成/审核通过";
    
    self.successIV = [UIImageView new];
    self.successIV.image = [UIImage imageNamed:@"complete"];
    
    [self.view addSubview:self.successIV];
    [self.successIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CELL_HEIGHT_F);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    self.memberCodeLB = [CPLabel new];
    self.memberCodeLB.text = @"会员编号：HY1231230";
//    self.memberCodeLB.attributedText = [self attrFromStr:@"会员编号:" dest:@"HY12344523" color:MainColor];
    
    [self.view addSubview:self.memberCodeLB];
    [self.memberCodeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.successIV.mas_bottom).offset(CELL_HEIGHT_F);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(150);
    }];
    
    self.membPasswdLB = [CPLabel new];
    self.membPasswdLB.text = @"初始密码：1231230";
//    self.membPasswdLB.attributedText = [self attrFromStr:@"初始密码:" dest:@"1231230" color:UIColor.redColor];
    
    
    [self.view addSubview:self.membPasswdLB];
    [self.membPasswdLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.memberCodeLB.mas_bottom).offset(SPACE_OFFSET_F/2);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(150);
    }];
    
    self.hintLB = [CPLabel new];
    self.hintLB.text = @"会员新增成功，信息已发送到会员手机中";
    self.hintLB.textColor = UIColor.redColor;
    
    [self.view addSubview:self.hintLB];
    [self.hintLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.membPasswdLB.mas_bottom).offset(SPACE_OFFSET_F);
        make.centerX.mas_equalTo(0);
    }];
}
#pragma mark - delete method implement
#pragma mark - private method
- (NSAttributedString *)attrFromStr:(NSString *)from dest:(NSString *)dest color:(UIColor *)color {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:from attributes:nil];
    NSAttributedString *attr1 = [[NSMutableAttributedString alloc] initWithString:dest attributes:@{NSForegroundColorAttributeName : color}];
    
    [attr appendAttributedString:attr1];
    
    return attr;
}

@end
