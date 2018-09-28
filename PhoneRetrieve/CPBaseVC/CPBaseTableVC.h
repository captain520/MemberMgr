//
//  CPBaseTableVC.h
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/8.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "CPBaseVC.h"

@interface CPBaseTableVC : CPBaseVC<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *dataTableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

- (void)loadData;

@end
