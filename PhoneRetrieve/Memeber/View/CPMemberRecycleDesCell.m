//
//  CPMemberRecycleDesCell.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/4.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemberRecycleDesCell.h"

@implementation CPMemberRecycleDesCell {
    CPLabel *titleLB;
    UIImageView *iconIV;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    NSLog(@"--------");
}

- (void)setupUI {
    
    //    左边标题
    titleLB = [CPLabel new];
    titleLB.text = @"回收说明";
    [self.contentView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cellSpaceOffset);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    
    iconIV = [UIImageView new];
    iconIV.contentMode = UIViewContentModeScaleAspectFit;
    iconIV.image = [UIImage imageNamed:@"home_down"];
    [self.contentView addSubview:iconIV];
    [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-cellSpaceOffset);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
}

- (void)setIsUpDirection:(BOOL)isUpDirection {
    [UIView animateWithDuration:.5 animations:^{
        iconIV.transform = CGAffineTransformMakeRotation(M_PI * isUpDirection);
    }];
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    
    iconIV.image = [UIImage imageNamed:imageName];
}

- (void)updateTitle:(NSString *)title {
    titleLB.text = title;
}

- (void)setLevel:(NSInteger)level {
    _level = level;
    
    [titleLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cellSpaceOffset * level);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    if (_level == 1) {
        titleLB.font = [UIFont boldSystemFontOfSize:15];
    } else {
        titleLB.font = [UIFont systemFontOfSize:15];
    }
}

@end
