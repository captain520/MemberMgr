//
//  CPEvaluatedContentCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPEvaluatedContentCell.h"

@implementation CPEvaluatedContentCell {
    CPLabel *areaLB, *sizeLB, *guaranteeConditionLB, *colorLB;
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
    
    self.shouldShowBottomLine = NO;

    areaLB = [CPLabel new];
//    areaLB.backgroundColor = [UIColor greenColor];
    areaLB.text = @"大陆国行";
//    areaLB.numberOfLines = 0;
    [self.contentView addSubview:areaLB];
    
//    sizeLB = [CPLabel new];
////    sizeLB.backgroundColor = [UIColor purpleColor];
//    sizeLB.text = @"32G";
//    [self.contentView addSubview:sizeLB];
//
//    guaranteeConditionLB = [CPLabel new];
////    guaranteeConditionLB.backgroundColor = [UIColor grayColor];
//    guaranteeConditionLB.text = @"保修一个月以上";
//    [self.contentView addSubview:guaranteeConditionLB];
//
//
    colorLB = [CPLabel new];
//    colorLB.backgroundColor = [UIColor orangeColor];
    colorLB.text = @"玫瑰金";
//    colorLB.numberOfLines = 0;
    [self.contentView addSubview:colorLB];
    
    [areaLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(cellSpaceOffset);
        make.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(sizeLB.mas_width).multipliedBy(2);
    }];
    
//    [sizeLB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.mas_equalTo(areaLB.mas_right);
//        make.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(areaLB.mas_width).multipliedBy(0.5);
//    }];
//
//    [guaranteeConditionLB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.mas_equalTo(sizeLB.mas_right);
//        make.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(areaLB.mas_width);
//    }];
    
    [colorLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(areaLB.mas_right).offset(cellSpaceOffset);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(areaLB.mas_width);//.multipliedBy(0.5f);
        make.right.mas_equalTo(-cellSpaceOffset);
    }];
}

//- (void)setItemName:(NSString *)itemName {
//    _itemName = itemName;
//
//    areaLB.text = _itemName;
//}
//
//- (void)setItemContent:(NSString *)itemContent {
//    _itemContent = itemContent;
//
//    colorLB.text = _itemContent;
//}

- (void)setItemDict:(NSDictionary<NSString *,id> *)itemDict {
    _itemDict = itemDict;

    areaLB.text = _itemDict.allKeys.firstObject;
    colorLB.text = _itemDict.allValues.firstObject;
//    areaLB.text = [_itemDict valueForKey:@"name"];
//    colorLB.text = [_itemDict[@"data"] valueForKey:@"name"];

//    NSDictionary *dataDict = [_itemDict valueForKey:@"data"];



}

@end
