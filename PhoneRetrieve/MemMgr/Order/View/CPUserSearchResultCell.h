//
//  CPUserSearchResultCell.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/15.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCTableViewCell.h"
#import "ZCSearchDelegateListModel.h"

@interface CPUserSearchResultCell : ZCTableViewCell

@property (nonatomic,assign) NSInteger sortNum;

@property (nonatomic, strong) DLData *model;

@end
