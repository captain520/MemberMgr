//
//  CPEvaluatePriceHeader.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPEvaluatePriceHeader.h"

@implementation CPEvaluatePriceHeader {
    UIImageView *bgIV;
    UILabel *priceLB;
    UILabel *titleLB;
    
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    bgIV = [UIImageView new];
    bgIV.image = CPImage(@"Evaluation_bg");
    bgIV.contentMode = UIViewContentModeScaleToFill;
    bgIV.userInteractionEnabled = YES;
    
    [self.contentView addSubview:bgIV];
    
    [bgIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(cellSpaceOffset/2);
        make.left.mas_offset(cellSpaceOffset - 5);
        make.right.mas_offset(-cellSpaceOffset + 5);
        make.bottom.mas_offset(0);
    }];
    
    {
        priceLB = [UILabel new];
        priceLB.textColor = [UIColor whiteColor];
        priceLB.font = [UIFont boldSystemFontOfSize:40.0f];;
//        priceLB.text = @"¥221.00";
        priceLB.textAlignment = NSTextAlignmentCenter;
        
        [bgIV addSubview:priceLB];

//        NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:@"¥ " attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
//        NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:@"238.00"];
//        [attr0 appendAttributedString:attr1];
//        
//        [priceLB setAttributedText:attr0];
    }

    [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(83);
    }];
    
    titleLB = [UILabel new];
    titleLB.textColor = MainColor;
    titleLB.text = @"评估价格";
    titleLB.textAlignment = NSTextAlignmentCenter;
//    titleLB.backgroundColor = UIColor.purpleColor;
    
    [bgIV addSubview:titleLB];
    
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(priceLB.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];
    

    UIColor *btColor = [UIColor colorWithRed:149./255 green:241./255 blue:249./255 alpha:1.0f];
    
    _reevaluedButton = [CPButton new];
    _reevaluedButton.layer.borderWidth = 0;
    _reevaluedButton.backgroundColor = UIColor.clearColor;
    [_reevaluedButton setTitle:@"重新评估" forState:0];
    [_reevaluedButton setBackgroundImage:CPImageWithColr(btColor) forState:0];

    [bgIV addSubview:_reevaluedButton];
    
    [_reevaluedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.centerX.mas_equalTo(bgIV.mas_centerX);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];

}

- (void)setCp_content:(NSString *)cp_content
{
    _cp_content = cp_content;
    
    NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:@"¥ " attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:_cp_content];
    [attr0 appendAttributedString:attr1];
    
    [priceLB setAttributedText:attr0];
}

@end
