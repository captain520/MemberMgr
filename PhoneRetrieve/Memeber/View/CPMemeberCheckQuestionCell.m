//
//  CPMemeberCheckQuestionCell.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/11.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemeberCheckQuestionCell.h"

@implementation CPMemeberCheckQuestionCell {
    CPLabel *itemNameLB, *resultLB, *quoteLB, *reduceLB;
    
    UIImageView *iconIV;
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
    
    UIView *dotView = [UIView new];
    dotView.backgroundColor = [UIColor redColor];
    dotView.clipsToBounds = YES;
    dotView.layer.cornerRadius = 5.0f;
    [self.contentView addSubview:dotView];
    [dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cellSpaceOffset);
        make.top.mas_equalTo(cellSpaceOffset);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    
    
    itemNameLB = [CPLabel new];
    itemNameLB.text = @"颜色";
    [self.contentView addSubview:itemNameLB];
    [itemNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dotView.mas_right).offset(8);
        make.centerY.mas_equalTo(dotView.mas_centerY);
    }];
    
    resultLB = [CPLabel new];
    resultLB.text = @"检验结果：";
    [self.contentView addSubview:resultLB];
    [resultLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(itemNameLB.mas_bottom).offset(4);
        make.left.mas_equalTo(itemNameLB.mas_left);
    }];

    quoteLB = [CPLabel new];
    quoteLB.text = @"评估状况：";
    [self.contentView addSubview:quoteLB];
    [quoteLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(resultLB.mas_bottom).offset(4);
        make.left.mas_equalTo(itemNameLB.mas_left);
    }];
    
    reduceLB = [CPLabel new];
    reduceLB.textColor = UIColor.redColor;
    reduceLB.text = @"余额扣除：¥50";
    [self.contentView addSubview:reduceLB];
    [reduceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(quoteLB.mas_bottom).offset(4);
        make.left.mas_equalTo(itemNameLB.mas_left);
    }];
    
    iconIV = [UIImageView new];
    iconIV.image = CPImage(@"logo");

    [self.contentView addSubview:iconIV];
    [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-cellSpaceOffset);
        make.top.mas_equalTo(cellSpaceOffset);
        make.bottom.mas_equalTo(-cellSpaceOffset);
        make.width.mas_equalTo(iconIV.mas_height);
    }];
}

- (void)setModel:(CPMemberReportResultJsonData *)model {
    _model = model;
    
    itemNameLB.text = model.name;
    resultLB.text = [NSString stringWithFormat:@"检验结果：%@",model.Description];
    quoteLB.text = [NSString stringWithFormat:@"评估状况：%@",model.name];
    reduceLB.text = [NSString stringWithFormat:@"余额扣除：¥%@",model.price];
    
    [iconIV sd_setImageWithURL:CPUrl(model.imageurl) placeholderImage:CPImage(@"placeHolderImage")];
}

@end
