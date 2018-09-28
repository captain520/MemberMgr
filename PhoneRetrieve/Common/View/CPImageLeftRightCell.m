//
//  CPImageLeftRightCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/7.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPImageLeftRightCell.h"

@implementation CPImageLeftRightCell {
    UIImageView *logoIV;
    
    UILabel *leftLB, *rightLB;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    if (nil == logoIV) {
        logoIV = [UIImageView new];
        logoIV.image = CPImage(@"Apple");
        
        [UIFont systemFontOfSize:15.0f];

        [self.contentView addSubview:logoIV];
        
        [logoIV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(cellSpaceOffset / 2);
            make.left.mas_equalTo(cellSpaceOffset);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(20, 20));
//            make.bottom.mas_equalTo(-cellSpaceOffset / 2);
//            make.width.mas_equalTo(CELL_HEIGHT_F - cellSpaceOffset);
        }];
    }
    
    if (nil == leftLB) {
        leftLB = [UILabel new];
        leftLB.font = CPFont_M;
        leftLB.textColor = C33;

        [self.contentView addSubview:leftLB];
        
        [leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(logoIV.mas_right).offset(cellSpaceOffset / 2);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_greaterThanOrEqualTo(50);
        }];
    }
    
    if (nil == rightLB) {
        rightLB = [UILabel new];
        rightLB.font = CPFont_M;
        rightLB.textColor = C33;
        rightLB.numberOfLines = 0;

        [self.contentView addSubview:rightLB];
        
        [rightLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-cellSpaceOffset);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_greaterThanOrEqualTo(leftLB.mas_right).offset(20);
        }];
    }
}

- (void)setImage:(NSString *)image {
    _image = image;
    
    logoIV.image = CPImage(image);
}

- (void)setLeftValue:(NSString *)leftValue {
    _leftValue = leftValue;
    
    leftLB.text = _leftValue;
}

- (void)setRightValue:(NSString *)rightValue {
    _rightValue = rightValue;
    
    rightLB.text = _rightValue;
}

- (void)alignRightLabel {
    [rightLB mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_greaterThanOrEqualTo(leftLB.mas_right).offset(20);
    }];
}

@end
