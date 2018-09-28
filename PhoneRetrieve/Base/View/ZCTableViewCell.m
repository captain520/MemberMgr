//
//  ZCTableViewCell.m
//  MemberManager
//
//  Created by 王璋传 on 2018/9/14.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCTableViewCell.h"

@implementation ZCTableViewCell

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
        
        [self setupSepLine];
        
        [self setupUI];
    }
    
    return  self;
}

- (void)setShouldShowBottomLine:(BOOL)shouldShowBottomLine {
    _shouldShowBottomLine = shouldShowBottomLine;
    
    {
        UIView *sepline = [self viewWithTag:9527];
        sepline.hidden = !shouldShowBottomLine;
    }
    
    {
        UIView *sepline = [self viewWithTag:9528];
        sepline.hidden = !shouldShowBottomLine;
    }
}

#pragma mark - Private method

- (void)setupSepLine {
    
//    UIView *bgView = [UIView new];
//    bgView.backgroundColor = MainColor;
//    self.selectedBackgroundView = bgView;
    
    self.clipsToBounds = YES;
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
    
    {
//        UIView *sepLine = UIView.new;
//        sepLine.tag             = 9528;
//        sepLine.backgroundColor = CPBoardColor;
//
//        [self addSubview:sepLine];
//
//        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(0);
//            make.top.mas_equalTo(0);
//            make.height.mas_equalTo(0.5);
//            make.right.mas_equalTo(0);
//        }];
    }
}

- (void)setupUI {
    
}

@end
