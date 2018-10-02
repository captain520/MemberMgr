//
//  ZCBaseSearchVC.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/17.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCRefreshTableVC.h"
#import "CPSearchResultVC.h"

@interface ZCBaseSearchVC : ZCRefreshTableVC

@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic, strong) CPSearchResultVC *resultVC;
@property (nonatomic, copy) void (^selectedIndex)(NSInteger index);

@end
