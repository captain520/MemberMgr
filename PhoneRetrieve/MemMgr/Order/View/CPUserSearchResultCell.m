//
//  CPUserSearchResultCell.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/15.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPUserSearchResultCell.h"

@implementation CPUserSearchResultCell {
    ZCLabel *sortLB,*nameLB,*chargeNameLB;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupUI {
    
    sortLB = [ZCLabel new];
    sortLB.backgroundColor = MainColor;
    sortLB.textAlignment = NSTextAlignmentCenter;
    sortLB.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:sortLB];
    [sortLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(18, 16));
    }];
    
    nameLB = [ZCLabel new];
    nameLB.text = @"船长/15814099328";
    [self.contentView addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
//        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(sortLB.mas_right).offset(SPACE_OFFSET_F);
    }];
    
    chargeNameLB = [ZCLabel new];
    chargeNameLB.text = @"(负责人:厂长)";
    [self.contentView addSubview:chargeNameLB];
    [chargeNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
}

- (void)setSortNum:(NSInteger)sortNum {
    
    _sortNum = sortNum;
    sortLB.text = [NSString stringWithFormat:@"%02ld",(long)sortNum];
}

@end
