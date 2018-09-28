//
//  CPEvaluatedTypeHeader.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPEvaluatedTypeHeader.h"

@implementation CPEvaluatedTypeHeader {
    UILabel *titleLB;
    UIView *bottomSepLine;
}

- (void)setupUI {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    
    titleLB = [CPLabel new];
    titleLB.font = [UIFont boldSystemFontOfSize:13.0f];
    
    [self.contentView addSubview:titleLB];
    
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.bottom.mas_equalTo(0);
    }];
    
    
    bottomSepLine = [UIView new];
    bottomSepLine.backgroundColor = CPBoardColor;
    
    [self.contentView addSubview:bottomSepLine];
    
    [bottomSepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(cellSpaceOffset);
        make.right.mas_offset(-cellSpaceOffset);
        make.height.mas_equalTo(.5f);
        make.bottom.mas_equalTo(0);
    }];

}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    titleLB.text = _title;
}

- (void)setShouldShowSepLine:(BOOL)shouldShowSepLine {
    
    _shouldShowSepLine = shouldShowSepLine;
    
    bottomSepLine.hidden = !_shouldShowSepLine;
}

@end
