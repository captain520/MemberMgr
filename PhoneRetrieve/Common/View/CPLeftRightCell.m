//
//  CPLeftRightCell.m
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/8.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "CPLeftRightCell.h"

@implementation CPLeftRightCell {
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.font            = [UIFont systemFontOfSize:13];
        self.textLabel.textColor       = C33;

        self.detailTextLabel.font      = [UIFont systemFontOfSize:13];
        self.detailTextLabel.textColor = C33;
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

#pragma mark - Private method

- (void)setupUI {

}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    self.textLabel.text = title;
}

- (void)setSubTitle:(NSString *)subTitle {
    
    _subTitle = subTitle;
    
    self.detailTextLabel.textColor = UIColor.redColor;
    self.detailTextLabel.text = subTitle;
}

- (void)setContentColor:(UIColor *)contentColor {
    _contentColor = contentColor;
    self.textLabel.textColor = _contentColor;
}
@end
