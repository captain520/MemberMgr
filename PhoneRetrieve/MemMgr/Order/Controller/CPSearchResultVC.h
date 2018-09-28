//
//  CPSearchResultVC.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/15.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCRefreshTableVC.h"

@interface CPSearchResultVC : ZCRefreshTableVC

@property (nonatomic, copy) void (^didSelecRow)(NSInteger row);

- (void)refreshTableViewWithDataArray:(NSArray *)dataArray;

@end
