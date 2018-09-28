//
//  CPShopMainActionView.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/6.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopMainActionView.h"
#import "CPMainActionButton.h"

@implementation CPShopMainActionView

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    CGFloat width = SCREENWIDTH / 2;
    CGFloat height = self.bounds.size.height / (2.0f + [CPUserInfoModel shareInstance].isShop);

    /**********************************************************************/
    UIView *sepline = [UIView new];
    sepline.backgroundColor = CPBoardColor;
    
    [self addSubview:sepline];
    
    [sepline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(CPBoardWidth);
    }];

    
#pragma mark - 手机回收 (门店)
    CPMainActionButton *phoneRetrieveBT = [CPMainActionButton new];
    phoneRetrieveBT.tag = CPMainActionTypePhoneRetrieve;
    phoneRetrieveBT.type = CPMainActionButtonTypeRetrivePhone;
//    [phoneRetrieveBT setTitle:@"手机回收" forState:UIControlStateNormal];
//    [phoneRetrieveBT setTitleColor:C33 forState:UIControlStateNormal];
    [phoneRetrieveBT addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:phoneRetrieveBT];
    
    [phoneRetrieveBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];

#pragma mark - 回收车 (门店)
    CPMainActionButton *padRetrieveBT = [CPMainActionButton new];
    if ([CPUserInfoModel shareInstance].loginModel.Typeid == 3) {
        padRetrieveBT.tag = CPMainActionTypeRetrieveCart;
        padRetrieveBT.type = CPMainActionButtonTypeCart;
#pragma mark - iPad回收 (店员)
    } else if ([CPUserInfoModel shareInstance].loginModel.Typeid == 4) {
        padRetrieveBT.tag = CPMainActionTypePadRetrieve;
        padRetrieveBT.type = CPMainActionButtonTypeRetrivePad;
    }
//    padRetrieveBT.tag = CPMainActionTypePadRetrieve;
//    padRetrieveBT.type = CPMainActionButtonTypeRetrivePad;
//    [padRetrieveBT setTitle:@"平板回收" forState:UIControlStateNormal];
//    [padRetrieveBT setTitleColor:C33 forState:UIControlStateNormal];
    [padRetrieveBT addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:padRetrieveBT];
    
    [padRetrieveBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneRetrieveBT.mas_top);
        make.left.mas_equalTo(phoneRetrieveBT.mas_right);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(phoneRetrieveBT.mas_bottom);
    }];
    
    
   /**********************************************************************/
    UIView *sepline0 = [UIView new];
    sepline0.backgroundColor = CPBoardColor;
    
    [self addSubview:sepline0];
    
    [sepline0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(phoneRetrieveBT.mas_bottom);
        make.height.mas_equalTo(0.5f);
    }];
    

#pragma mark - iPad回收 (门店)
    CPMainActionButton *retrieveCartBT = [CPMainActionButton new];
    retrieveCartBT.tag = CPMainActionTypePadRetrieve;
    retrieveCartBT.type = CPMainActionButtonTypeRetrivePad;
//    retrieveCartBT.tag = CPMainActionTypeRetrieveCart;
//    retrieveCartBT.type = CPMainActionButtonTypeCart;
    retrieveCartBT.hidden = [CPUserInfoModel shareInstance].isShop == NO;
//    [retrieveCartBT setTitle:@"回收车" forState:UIControlStateNormal];
//    [retrieveCartBT setTitleColor:C33 forState:UIControlStateNormal];
    [retrieveCartBT addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:retrieveCartBT];
    
    [retrieveCartBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneRetrieveBT.mas_bottom);
        make.left.mas_equalTo(phoneRetrieveBT.mas_left);
        make.right.mas_equalTo(phoneRetrieveBT.mas_right);
        make.height.mas_equalTo(height);
    }];
    
    
#pragma mark - 物流信息 (门店)
    CPMainActionButton *assistantManagerBT = [CPMainActionButton new];
    
    assistantManagerBT.tag = CPMainActionTypeAssistantManger;
    assistantManagerBT.type = CPMainActionButtonTypeAssisManager;
    assistantManagerBT.hidden = [CPUserInfoModel shareInstance].isShop == NO;
//    [assistantManagerBT setTitle:@"店员管理" forState:UIControlStateNormal];
//    [assistantManagerBT setTitleColor:C33 forState:UIControlStateNormal];
    [assistantManagerBT addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:assistantManagerBT];
    
    [assistantManagerBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(retrieveCartBT.mas_top);
        make.left.mas_equalTo(retrieveCartBT.mas_right);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(retrieveCartBT.mas_bottom);
    }];
    
   /**********************************************************************/
    UIView *sepline1 = [UIView new];
    sepline1.backgroundColor = CPBoardColor;
    
    [self addSubview:sepline1];
    
    [sepline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(retrieveCartBT.mas_bottom);
        make.height.mas_equalTo(0.5f);
    }];

    
#pragma mark - 故障机快速评估 (门店)
    CPMainActionButton *retrieveFlowBT = [CPMainActionButton new];
    retrieveFlowBT.tag = CPMainActionTypeRetrieveFlow;
    retrieveFlowBT.type = CPMainActionButtonTypeRetriveFlow;
//    [retrieveFlowBT setTitle:@"回收流程" forState:UIControlStateNormal];
//    [retrieveFlowBT setTitleColor:C33 forState:UIControlStateNormal];
    [retrieveFlowBT addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:retrieveFlowBT];
    
    [retrieveFlowBT mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([CPUserInfoModel shareInstance].isShop) {
            make.top.mas_equalTo(retrieveCartBT.mas_bottom);
            make.left.mas_equalTo(retrieveCartBT.mas_left);
            make.right.mas_equalTo(retrieveCartBT.mas_right);
            make.height.mas_equalTo(height);
        } else {
            make.top.mas_equalTo(phoneRetrieveBT.mas_bottom);
            make.left.mas_equalTo(phoneRetrieveBT.mas_left);
            make.right.mas_equalTo(phoneRetrieveBT.mas_right);
            make.height.mas_equalTo(height);
        }
    }];

#pragma mark - 订单中心(门店)
    CPMainActionButton *retrieveAboutBT = [CPMainActionButton new];
    if ([CPUserInfoModel shareInstance].loginModel.Typeid == 3) {
        retrieveAboutBT.tag = CPMainActionTypeRetrieveAbout;
        retrieveAboutBT.type = CPMainActionButtonTypeRetriveDes;
    } else if ([CPUserInfoModel shareInstance].loginModel.Typeid == 4) {
        retrieveAboutBT.tag = CPMainActionTypeOther;
        retrieveAboutBT.type = CPMainActionButtonTypeOther;
    }
//    [retrieveAboutBT setTitle:@"回收说明" forState:UIControlStateNormal];
//    [retrieveAboutBT setTitleColor:C33 forState:UIControlStateNormal];
    [retrieveAboutBT addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:retrieveAboutBT];
    
    [retrieveAboutBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(retrieveFlowBT.mas_top);
        make.left.mas_equalTo(retrieveFlowBT.mas_right);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(retrieveFlowBT.mas_bottom);
    }];
    
    /**********************************************************************/
    UIView *sepline2 = [UIView new];
    sepline2.backgroundColor = CPBoardColor;
    
    [self addSubview:sepline2];
    
    [sepline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(0.5f);
    }];
    
    /**********************************************************************/
    UIView *sepline3 = [UIView new];
    sepline3.backgroundColor = CPBoardColor;
    
    [self addSubview:sepline3];
    
    [sepline3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(CPBoardWidth);
    }];
}

- (void)buttonAction:(UIButton *)sender {
    !self.actionBlock ? : self.actionBlock(sender.tag);
}


@end
