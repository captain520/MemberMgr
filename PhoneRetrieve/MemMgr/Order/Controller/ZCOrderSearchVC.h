//
//  ZCOrderSearchVC.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/14.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCRefreshTableVC.h"
#import "ZCDatePickerTF.h"

@interface ZCOrderSearchVC : ZCRefreshTableVC

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) ZCDatePickerTF *beginDateTF, *endDateTF;

- (void)searchAction;

@end
