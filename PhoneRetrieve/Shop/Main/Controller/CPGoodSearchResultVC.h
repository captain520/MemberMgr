//
//  CPGoodSearchResultVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/21.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseTableVC.h"

@interface CPGoodSearchResultVC : CPBaseTableVC

@property (nonatomic, assign) NSInteger deviceTypeid;

- (void)push2QuoteFlow:(BOOL)animated;

@end
