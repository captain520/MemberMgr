//
//  CPMemberQuotePriceFooter.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/14.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemberQuotePriceFooter.h"

@implementation CPMemberQuotePriceFooter {
    UIButton *actionBT;
    CPLabel *priceLB;
    
    UIImageView *iconIV;
    
    BOOL isUpDirection;
}


- (void)setupUI {
    actionBT = [UIButton new];
    [actionBT setTitle:@"平台回收价" forState:0];
    actionBT.titleLabel.font = CPFont_M;
    actionBT.backgroundColor = UIColor.whiteColor;
    actionBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [actionBT setTitleEdgeInsets:UIEdgeInsetsMake(0, cellSpaceOffset, 0, 0)];
    [actionBT setTitleColor:C33 forState:0];
    [self.contentView addSubview:actionBT];
    [actionBT addTarget:self action:@selector(buttonAction:) forControlEvents:64];
    [actionBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];
    
    iconIV = [UIImageView new];
    iconIV.contentMode = UIViewContentModeScaleAspectFit;
//    iconIV.transform = CGAffineTransformMakeRotation(M_PI);
    iconIV.image = [UIImage imageNamed:@"home_down"];
    [self.contentView addSubview:iconIV];
    [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-cellSpaceOffset);
        make.centerY.mas_equalTo(actionBT.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];

    UIView *sepLine = [UIView new];
    sepLine.backgroundColor = CPBoardColor;
    
    [self.contentView addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(actionBT.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(.5);
    }];
    
    priceLB = [CPLabel new];
    priceLB.backgroundColor = UIColor.whiteColor;
//    priceLB.hidden = YES;
    priceLB.clipsToBounds = YES;
//    priceLB.text = @"平台回收价";
    NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:@"___" attributes:@{NSForegroundColorAttributeName : UIColor.whiteColor}];
    NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:@"平台回收价" attributes:nil];
    [attr0 appendAttributedString:attr1];
    priceLB.attributedText = attr0;
    [self.contentView addSubview:priceLB];
    [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sepLine.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0);
    }];
}

- (void)buttonAction:(id)sender {
    isUpDirection = !isUpDirection;
    
    [UIView animateWithDuration:.5 animations:^{
        iconIV.transform = CGAffineTransformMakeRotation(M_PI * isUpDirection);
        
        CGRect tempFrame = priceLB.frame;
        tempFrame.size.height = CELL_HEIGHT_F * isUpDirection;
        priceLB.frame = tempFrame;

    } completion:^(BOOL finished) {
//        priceLB.hidden = !isUpDirection;
        !self.actionBlock ? :self.actionBlock(isUpDirection);
    }];
}

- (void)setPrice:(NSString *)price {
    NSString *priceStr = [NSString stringWithFormat:@"平台回收价:¥%@",price];
    NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:@"___" attributes:@{NSForegroundColorAttributeName : UIColor.whiteColor}];
    NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:priceStr attributes:nil];
    [attr0 appendAttributedString:attr1];
    
    priceLB.attributedText = attr0;
}

@end
