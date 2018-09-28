//
//  ZCOrderListHeaderView.m
//  MemberManager
//
//  Created by 王璋传 on 2018/9/13.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCServiceListHeaderView.h"

@implementation ZCServiceListHeaderView {
    ZCLabel *dateLB, *serviceFeeLB, *orderCountLB, *amountCountLB;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    dateLB = [ZCLabel new];
    dateLB.text = @"2018/09/01";
    
    [self.contentView addSubview:dateLB];
    [dateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(SPACE_OFFSET_F);
    }];
    
    serviceFeeLB = [ZCLabel new];
    serviceFeeLB.text = @"统计服务费:¥60";
    
    [self.contentView addSubview:serviceFeeLB];
    [serviceFeeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->dateLB.mas_top);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
        make.height.mas_equalTo(self->dateLB.mas_height);
    }];
    
    UIView *sepLine = [UIView new];
    sepLine.backgroundColor = BorderColor;;

    [self.contentView addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->dateLB.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(.5);
    }];
    
    orderCountLB = [ZCLabel new];
    orderCountLB.text = @"交易机器数量:20";
    
    [self.contentView addSubview:orderCountLB];
    [orderCountLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->dateLB.mas_bottom);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.height.mas_equalTo(self->dateLB.mas_height);
        make.bottom.mas_equalTo(0);
    }];
    
    amountCountLB = [ZCLabel new];
    amountCountLB.text = @"交易机器数量:20";
    
    [self.contentView addSubview:amountCountLB];
    [amountCountLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->orderCountLB.mas_top);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
        make.bottom.mas_equalTo(self->orderCountLB.mas_bottom);
        make.height.mas_equalTo(self->dateLB.mas_height);
    }];
    
    
    UIView *sepLine1 = [UIView new];
    sepLine1.backgroundColor = BorderColor;;

    [self.contentView addSubview:sepLine1];
    [sepLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(.5);
    }];
    

}


@end
