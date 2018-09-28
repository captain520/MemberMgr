//
//  CPDeviceProblemCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/26.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPDeviceProblemCell.h"
#import <SDCycleScrollView.h>
#import "CPQuestionHintView.h"

@implementation CPDeviceProblemCell {
    UIView *bgView;
    CPCommonButtn *imageBT;
    UILabel *titleLB;
}

- (void)setModel:(Pricepropertyvalues *)model {
    _model = model;
    
    imageBT.hidden = _model.imgs.count == 0;
    titleLB.text = _model.value;
    
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

    if (nil == bgView) {
        bgView = [UIView new];
        bgView.layer.cornerRadius = 5.0f;
        bgView.backgroundColor = UIColor.whiteColor;
        
        [self.contentView addSubview:bgView];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(cellSpaceOffset / 2);
            make.left.mas_offset(cellSpaceOffset);
            make.right.mas_offset(-cellSpaceOffset);
            make.bottom.mas_offset(-cellSpaceOffset / 2);
        }];
    }

    if (nil == imageBT) {
        imageBT = [CPCommonButtn new];
        [imageBT setImage:CPImage(@"question_mark") forState:0];
        [imageBT addTarget:self action:@selector(showQuestionAction:) forControlEvents:64];

        [bgView addSubview:imageBT];
        
        [imageBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cellSpaceOffset);
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.centerY.mas_equalTo(bgView.mas_centerY);
        }];
    }
    
    if (nil == titleLB) {
        titleLB = [UILabel new];
        titleLB.font = CPFont_M;
        titleLB.textColor = C33;
        
        [bgView addSubview:titleLB];
        
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(imageBT.mas_right).offset(cellSpaceOffset/2);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.bottom.mas_equalTo(0);
        }];
    }
}

- (void)setImageName:(NSString *)imageName {
    
    _imageName = imageName;
    
//    imageView.image = CPImage(_imageName);
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    titleLB.text = _title;
}

- (void)setShouldHighted:(BOOL)shouldHighted {
    
    _shouldHighted = shouldHighted;
    
    if (_shouldHighted) {
        bgView.backgroundColor = UIColor.yellowColor;
    } else {
        bgView.backgroundColor = UIColor.whiteColor;
    }
}

- (void)showQuestionAction:(CPCommonButtn *)sender {
    DDLogInfo(@"------------------------------");
    
//    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    CPQuestionHintView *questionView = [CPQuestionHintView new];
    questionView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    questionView.model = self.model;
    [[UIApplication sharedApplication].keyWindow addSubview:questionView];
}


@end
