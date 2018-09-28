//
//  CPBaseCell.m
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/8.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "CPBaseCell.h"

@implementation CPBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSepLine];
        
        [self setupUI];
    }
    
    return  self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setShouldShowBottomLine:(BOOL)shouldShowBottomLine {
    _shouldShowBottomLine = shouldShowBottomLine;
    
    UIView *sepline = [self viewWithTag:9527];
    sepline.hidden = !shouldShowBottomLine;
}

#pragma mark - Private method

- (void)setupSepLine {
    
    //  分割线
    {
        UIView *sepLine = UIView.new;
        sepLine.tag             = 9527;
        sepLine.backgroundColor = CPBoardColor;

        [self addSubview:sepLine];
        
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
            make.right.mas_equalTo(0);
        }];
    }
}

- (void)setupUI {
    
}

@end
