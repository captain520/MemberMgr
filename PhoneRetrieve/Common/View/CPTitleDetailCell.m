//
//  CPTitleDetailCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPTitleDetailCell.h"

@implementation CPTitleDetailCell {
    CPLabel *titleLB;
    CPLabel *contentLB;
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
        titleLB = [CPLabel new];
//        titleLB.backgroundColor = [UIColor orangeColor];
        
        [self.contentView addSubview:titleLB];
        
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_offset(cellSpaceOffset);
            make.bottom.mas_equalTo(0);
        }];

    }
    
    {
        contentLB = [CPLabel new];
//        contentLB.backgroundColor = [UIColor redColor];
        
        [self.contentView addSubview:contentLB];
        
        [contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(titleLB.mas_right).offset(cellSpaceOffset / 2);
            make.bottom.mas_equalTo(0);
        }];
    }
    
    {
        _actionBT = [CPCommonButtn new];
        _actionBT.titleLabel.font = CPFont_M;
        _actionBT.layer.borderColor = CPBoardColor.CGColor;
        _actionBT.layer.borderWidth = CPBoardWidth;
        _actionBT.layer.cornerRadius = 3.0f;
        _actionBT.hidden = YES;
        [_actionBT setTitle:@"查看物流" forState:0];
        [self.contentView addSubview:_actionBT];
        
        [_actionBT mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(8);
            make.centerY.mas_equalTo(contentLB.mas_centerY);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.size.mas_equalTo(CGSizeMake(CELL_HEIGHT_F * 3 / 2, CELL_HEIGHT_F / 2));
//            make.bottom.mas_equalTo(-8);
//            make.width.mas_equalTo(70);
        }];
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    titleLB.text = _title;
}

- (void)setContent:(NSString *)content {
    
    _content = content;
    
    contentLB.text = _content;
}

- (void)setContentColor:(UIColor *)contentColor {
    _contentColor = contentColor;
    
    contentLB.textColor = _contentColor;
    titleLB.textColor = _contentColor;
}

@end
