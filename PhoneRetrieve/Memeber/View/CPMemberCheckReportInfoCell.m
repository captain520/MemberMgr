//
//  CPMemberCheckReportInfoCell.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/11.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemberCheckReportInfoCell.h"

@implementation CPMemberCheckReportInfoCell {
    CPLabel *nameLB, *checkStatusLB, *imeiLB;
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
    
    nameLB = [CPLabel new];
    nameLB.text = @"sldflaslkdlf";
    [self.contentView addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cellSpaceOffset);
        make.bottom.mas_equalTo(self.contentView.mas_centerY).offset(-4);
    }];
    
    checkStatusLB  = [CPLabel new];
    checkStatusLB.text = @"验货完成";
    [self.contentView addSubview:checkStatusLB];
    [checkStatusLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-cellSpaceOffset);
        make.centerY.mas_equalTo(nameLB.mas_centerY);
    }];
    
    imeiLB = [CPLabel new];
    imeiLB.text = @"wofkjalsdjfl";
    [self.contentView addSubview:imeiLB];
    [imeiLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_centerY).offset(4);
        make.left.mas_equalTo(cellSpaceOffset);
    }];
}

- (void)setModel:(CPMemberReportResultModel *)model {
    _model = model;
    
    nameLB.text = model.goodsname;
    imeiLB.text = [NSString stringWithFormat:@"IMEI：%@",model.customimei];
    checkStatusLB.text = model.checkcfg ? @"验货完成" : @"验货中";
    checkStatusLB.textColor = model.checkcfg ? FONT_GREEN: UIColor.redColor;
    
}

@end
