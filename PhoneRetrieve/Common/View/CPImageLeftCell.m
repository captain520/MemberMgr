//
//  CPImageLeftCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/26.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPImageLeftCell.h"

@implementation CPImageLeftCell {
    UIImageView *imageView;
    UILabel *titleLB;
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
   
    if (nil == imageView) {
        imageView = [UIImageView new];
        imageView.image = CPImage(@"logo");
        
        [self.contentView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cellSpaceOffset);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
    }
    
    if (nil == titleLB) {
        titleLB = [UILabel new];
        titleLB.font = CPFont_M;
        titleLB.textColor = C33;

        [self.contentView addSubview:titleLB];
        
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(imageView.mas_right).offset(cellSpaceOffset/2);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.bottom.mas_equalTo(0);
        }];
    }
}

- (void)setImageName:(NSString *)imageName {
    
    _imageName = imageName;
    
    imageView.image = CPImage(_imageName);
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    titleLB.text = _title;
}

@end
