//
//  CPMainActionButton.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/1.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMainActionButton.h"

@implementation CPMainActionButton {
    CPLabel *titleLB;
    UIImageView *imageIV;
}

- (void)setupUI {
    
    titleLB = [CPLabel new];
    titleLB.font = CPFont_L;
    titleLB.text = @"手机回收";
    [self addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cellSpaceOffset);
        make.left.mas_equalTo(cellSpaceOffset);
        make.width.mas_equalTo(100);
    }];
    
    imageIV = [UIImageView new];
    imageIV.image = CPImage(@"hme_iphone");
    imageIV.contentMode = UIViewContentModeScaleAspectFit;//UIViewContentModeScaleToFill;
    [self addSubview:imageIV];
    [imageIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.bottom.mas_equalTo(-cellSpaceOffset);
        make.width.mas_equalTo(imageIV.mas_height);
    }];

}

- (void)setType:(CPMainActionButtonType)type {
    
    _type = type;

    NSString *title = @"手机回收";
    NSString *logoName = @"hme_iphone";
    
    switch (type) {
        case CPMainActionButtonTypeRetrivePhone:
        {
            title = @"手机回收";
            logoName = @"hme_iphone";
        }
            break;
            
        case CPMainActionButtonTypeRetrivePad:
        {
            title = @"iPad回收";
            logoName = @"hme_ipad";
        }
            break;
        case CPMainActionButtonTypeCart:
        {
            title = @"回收车";
            logoName = @"home_car";
//            logoName = @"logo";
        }
            break;
        case CPMainActionButtonTypeAssisManager:
        {
//            title = @"店员管理";
            title = @"物流信息";
//            logoName = @"home_peple";
            logoName = @"logistics";
        }
            break;
        case CPMainActionButtonTypeRetriveFlow:
        {
            title = @"故障机快速评估";
            logoName = @"home_Process";
        }
            break;
        case CPMainActionButtonTypeRetriveDes:
        {
            title = @"订单中心";
            logoName = @"home_Description";
        }
            break;
            
        default:
        {
            title = @"帮助中心";
            logoName = @"helpCenter";
            
        }
            break;
    }
    
    titleLB.text = title;
    imageIV.image = CPImage(logoName);
}

@end
