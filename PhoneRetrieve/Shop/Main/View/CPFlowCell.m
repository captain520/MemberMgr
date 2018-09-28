//
//  CPFlowCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/16.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPFlowCell.h"
#import "CPQuestionHintView.h"

#define TOP_OFFSET_F        (4)

@implementation CPFlowCell {
    UIView *bgView;
    UIButton *iconBT;
    CPLabel *titlelLB, *detailLB;
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
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(TOP_OFFSET_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.bottom.mas_equalTo(-TOP_OFFSET_F);
        }];
    }
    
    {
        iconBT = [UIButton new];
        [iconBT setImage:CPImage(@"question_mark") forState:0];
        [iconBT addTarget:self action:@selector(showQuestionAction:) forControlEvents:64];
        [bgView addSubview:iconBT];
        [iconBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(iconBT.mas_height);
        }];
    }
    
    {
        titlelLB = [CPLabel new];
        titlelLB.numberOfLines = 0;
        titlelLB.text = @"title";
        [bgView addSubview:titlelLB];
        [titlelLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_equalTo(iconBT.mas_right).offset(TOP_OFFSET_F);
            make.right.mas_equalTo(-cellSpaceOffset);
        }];
    }

}

- (void)cp_updateContent:(NSString *)titleValue detail:(NSString *)detailValue {
    
    NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",titleValue]
                                                                              attributes:@{
                                                                                           NSFontAttributeName : CPFont_L,
                                                                                           NSForegroundColorAttributeName : C33
                                                                                           }];
    
    NSAttributedString *attr2 = [[NSAttributedString alloc] initWithString:@"\n" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:6]}];
    NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:detailValue
                                                                attributes:@{
                                                                             NSFontAttributeName : CPFont_M,
                                                                             NSForegroundColorAttributeName : C66
                                                                             }];
    
    [attr0 appendAttributedString:attr2];
    [attr0 appendAttributedString:attr1];
    
    titlelLB.attributedText = attr0;
}

- (void)cp_updateContent:(NSString *)titleValue {

    NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:titleValue
                                                                              attributes:@{
                                                                                           NSFontAttributeName : CPFont_L,
                                                                                           NSForegroundColorAttributeName : C33
                                                                                           }];

    titlelLB.attributedText = attr0;
}

- (void)setModel:(CPItemData *)model {
    _model = model;
    
    if (model.tips) {
        [self cp_updateContent:_model.name detail:_model.tips];
    } else {
        [self cp_updateContent:_model.name];
    }
    
    iconBT.hidden = model.typecfg == 0;
    if (_model.typecfg == 1) {
        [iconBT setImage:CPImage(@"question_mark") forState:0];
    } else if (_model.typecfg == 2) {
        [iconBT sd_setImageWithURL:CPUrl(_model.iconurl) forState:0];
    }

}

- (void)showQuestionAction:(CPCommonButtn *)sender {
    DDLogInfo(@"------------------------------");
    
    CPQuestionHintView *questionView = [CPQuestionHintView new];
    questionView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    questionView.model = self.model;
    [[UIApplication sharedApplication].keyWindow addSubview:questionView];
}

- (void)setShouldHighted:(BOOL)shouldHighted {
    
    _shouldHighted = shouldHighted;
    
    if (_shouldHighted) {
        bgView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.5];
    } else {
        bgView.backgroundColor = UIColor.whiteColor;
    }
}

@end
