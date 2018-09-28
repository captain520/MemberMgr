//
//  ZCRefreshTableVC.h
//  MemberManager
//
//  Created by 王璋传 on 2018/9/13.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCBaseVC.h"

@interface ZCRefreshTableVC : ZCBaseVC <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *dataTableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger currentIndex;

- (void)loadData;

@end
