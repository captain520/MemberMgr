//
//  CPRetrieveAppearanceCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/14.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRetrieveAppearanceCell.h"

@implementation CPRetrieveAppearanceCell {
    UIView *bgView;
    UIButton *actionBT;
    CPLabel *contentLB;
    CPLabel *touchHintLB;
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
    
    {
        bgView = [UIView new];
        bgView.layer.cornerRadius = 5.0f;
        bgView.backgroundColor = UIColor.whiteColor;
        
        [self.contentView addSubview:bgView];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(cellSpaceOffset / 2);
            make.left.mas_offset(cellSpaceOffset);
            make.right.mas_offset(-cellSpaceOffset);
            make.bottom.mas_offset(-cellSpaceOffset / 2);
        }];
    }
    
    {
        actionBT = [CPButton new];
        [bgView addSubview:actionBT];
        [actionBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(actionBT.mas_height);
        }];
        
        touchHintLB = [CPLabel new];
        touchHintLB.textColor = UIColor.whiteColor;
        touchHintLB.text = @"查看大图";
        touchHintLB.textAlignment = NSTextAlignmentCenter;
        touchHintLB.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        [actionBT addSubview:touchHintLB];
        [touchHintLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(cellSpaceOffset);
        }];
    }
    
    {
        contentLB = [CPLabel new];
        [bgView addSubview:contentLB];
        [contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(actionBT.mas_right).offset(cellSpaceOffset);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(-cellSpaceOffset);
        }];
    }
}

- (void)setModel:(Pricepropertyvalues *)model {
    _model = model;
    
    [actionBT sd_setImageWithURL:CPUrl(_model.imgs.firstObject) forState:0 placeholderImage:CPImage(@"apple")];
    contentLB.text = model.value;
}

- (void)setShouldHighted:(BOOL)shouldHighted {
    
    _shouldHighted = shouldHighted;
    
    if (_shouldHighted) {
        bgView.backgroundColor = UIColor.yellowColor;
    } else {
        bgView.backgroundColor = UIColor.whiteColor;
    }
}

@end
