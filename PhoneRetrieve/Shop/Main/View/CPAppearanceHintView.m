//
//  CPAppearanceHintView.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/14.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPAppearanceHintView.h"
#import <SDCycleScrollView.h>

@implementation CPAppearanceHintView {
    UIView *bgView;
    
    CPLabel *titleLB;
    SDCycleScrollView *sv;
    UIWebView *webView;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    
    {
        bgView = [UIView new];
        bgView.backgroundColor = UIColor.whiteColor;
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(SCREENHEIGHT / 3);
        }];
    }
    
    
    {
        titleLB = [CPLabel new];
        [bgView addSubview:titleLB];
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
        }];
    }
    
    {
        webView = [UIWebView new];
        webView.backgroundColor = [UIColor whiteColor];
        [bgView addSubview:webView];
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLB).offset(2 * cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(80);
        }];
    }
    
    {
        sv = [SDCycleScrollView new];
        sv.placeholderImage = CPImage(@"apple");
        sv.currentPageDotColor = MainColor;
        [bgView addSubview:sv];
        [sv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(webView.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(100.0f);
//            make.bottom.mas_equalTo(webView.mas_top).offset(-cellSpaceOffset);
        }];
    }
    
    {
        
    }
}


- (void)setModel:(Appearanceproperties *)model {
    _model = model;
    
    Pricepropertyvalues *pModel = model.pricePropertyValues.firstObject;
    
    titleLB.text = pModel.value;
    sv.imageURLStringsGroup = [model.pricePropertyValues.firstObject valueForKeyPath:@"imgs"];
    [webView loadHTMLString:htmlEntityDecode(pModel.content) baseURL:nil];
    
    [self setupUI];
}

- (void)setupButton {
    
    NSUInteger count = self.model.pricePropertyValues.count;
    CGFloat width = (SCREENWIDTH - (count + 1) * cellSpaceOffset) / count;
    
    [self.model.pricePropertyValues enumerateObjectsUsingBlock:^(Pricepropertyvalues * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *indexStr = [NSString stringWithFormat:@"%lu",(unsigned long)idx];
        CPCommonButtn *actionButton = [CPCommonButtn new];
        [actionButton addTarget:self action:@selector(buttonAction:) forControlEvents:64];
        actionButton.tag = idx + CPBASETAG;
        [actionButton setTitle:indexStr forState:0];
        [self addSubview:actionButton];
        [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cellSpaceOffset + (cellSpaceOffset + width) * idx);
            make.width.mas_equalTo(width);
            make.bottom.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(cellSpaceOffset * 2);
        }];
    }];

}

- (void)buttonAction:(CPCommonButtn *)sender {
    DDLogInfo(@"-------------------tage: %ld",sender.tag);
    
    [self.model.pricePropertyValues enumerateObjectsUsingBlock:^(Pricepropertyvalues * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CPCommonButtn *bt = [self viewWithTag:idx + CPBASETAG];
        if (idx + CPBASETAG == sender.tag) {
            bt.backgroundColor = [UIColor yellowColor];
        } else {
            bt.backgroundColor = [UIColor grayColor];
        }
    }];
    
}

@end
