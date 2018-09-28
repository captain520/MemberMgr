//
//  CPQuestionHintView.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/14.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPQuestionHintView.h"
#import <SDCycleScrollView.h>

@implementation CPQuestionHintView {
    UIView *bgView;
    CPCommonButtn *deleteBT;
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
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(SCREENHEIGHT / 3 * 1.5);
        }];
    }
    
    {
        deleteBT = [CPCommonButtn new];
        [deleteBT setImage:CPImage(@"wrong") forState:0];
        [deleteBT addTarget:self action:@selector(deleteViewAction:) forControlEvents:64];
        [bgView addSubview:deleteBT];
        [deleteBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bgView.mas_top);
            make.right.mas_equalTo(bgView.mas_right);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    }
    
    {
        webView = [UIWebView new];
        webView.backgroundColor = [UIColor whiteColor];
        [bgView addSubview:webView];
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.bottom.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(80);
        }];
    }
    
    {
        sv = [SDCycleScrollView new];
//        sv.backgroundColor = UIColor.redColor;
        sv.placeholderImage = CPImage(@"apple");
        sv.currentPageDotColor = MainColor;
        [bgView addSubview:sv];
        [sv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(deleteBT.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.bottom.mas_equalTo(webView.mas_top).offset(-cellSpaceOffset);
        }];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

- (void)deleteViewAction:(id)sender {
    [self removeFromSuperview];
}

//- (void)setModel:(Pricepropertyvalues *)model {
//    _model = model;
//
//    sv.imageURLStringsGroup = [model valueForKeyPath:@"imgs"];
//
//    [webView loadHTMLString:htmlEntityDecode(_model.content) baseURL:nil];
//}

- (void)setModel:(CPItemData *)model {
    _model = model;
    
    sv.imageURLStringsGroup = _model.images;
    
    [webView loadHTMLString:htmlEntityDecode(_model.Description) baseURL:nil];
}


@end
