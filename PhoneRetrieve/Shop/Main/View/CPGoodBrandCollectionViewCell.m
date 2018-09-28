//
//  CPGoodBrandCollectionViewCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/26.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPGoodBrandCollectionViewCell.h"

@implementation CPGoodBrandCollectionViewCell {
    UIImageView *brandIV;
    UILabel *nameLB;
}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }

    return self;
}

- (void)setupUI {
    
    


    if (nil == nameLB) {
        nameLB = [UILabel new];
        nameLB.font = CPFont_L;
        nameLB.textColor = C33;
        nameLB.text = @"苹果";
        nameLB.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:nameLB];
        
        [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
    }
   
    if (nil == brandIV) {
        brandIV = [UIImageView new];
        [brandIV sd_setImageWithURL:CPUrl(@"https://sr.aihuishou.com/cms/image/6365552268776683601261817837.png")];
//        brandIV.image = CPImage(@"apple");
//        brandIV.backgroundColor = UIColor.redColor;
//        brandIV.backgroundColor = UIColor.redColor;
        brandIV.contentMode = UIViewContentModeScaleAspectFit;
//        brandIV.contentMode = UIViewContentModeScaleAspectFill;

        [self.contentView addSubview:brandIV];

        [brandIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(nameLB.mas_centerX);
//            make.top.mas_equalTo(0);
//            make.left.mas_equalTo(0);
//            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(nameLB.mas_top).offset(cellSpaceOffset);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
    }

    UIView *selectedView = [UIView new];
    selectedView.backgroundColor = BgColor;
    
    self.selectedBackgroundView = selectedView;
    
    {
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5f);
        }];
    }
}

- (void)setModel:(CPBrandModel *)model {
    
    _model = model;
    
    NSURL *url = [NSURL URLWithString:model.iconurl];
    
    nameLB.text = _model.name;
//    [brandIV sd_setImageWithURL:url placeholderImage:nil];
    [brandIV sd_setImageWithURL:url];
//    [brandIV sd_setImageWithURL:CPUrl(@"https://sr.aihuishou.com/cms/image/6365552268776683601261817837.png")];
}

@end
