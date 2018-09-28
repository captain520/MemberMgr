//
//  CPTopBottomCell.m
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/9.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "CPTopBottomCell.h"

@implementation CPTopBottomCell {
    UILabel *topLB, *bottomLB;
}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {

    UIView *sepline = UIView.new;
    sepline.backgroundColor = UIColor.clearColor;
    
    [self.contentView addSubview:sepline];
    
    [sepline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    

    if (nil == topLB) {
        
        topLB = UILabel.new;
        topLB.text      = @"Title";
        topLB.font      = [UIFont systemFontOfSize:15.0f];
        topLB.textColor = C33;
        
        [self.contentView addSubview:topLB];
        
        [topLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cellSpaceOffset);
            make.bottom.mas_equalTo(sepline.mas_top).offset(-2);
        }];
    }
    
    if (nil == bottomLB) {
        
        bottomLB = UILabel.new;
        bottomLB.text      = @"SubTitle";
        bottomLB.font      = [UIFont systemFontOfSize:12.0f];
        bottomLB.textColor = C99;

        [self.contentView addSubview:bottomLB];
        
        [bottomLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cellSpaceOffset);
            make.top.mas_equalTo(sepline.mas_bottom).offset(2);
        }];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    topLB.text = title;
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    
    bottomLB.text = subTitle;
}

@end
