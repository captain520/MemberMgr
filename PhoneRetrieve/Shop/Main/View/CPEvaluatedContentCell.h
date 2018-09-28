//
//  CPEvaluatedContentCell.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseCell.h"

@interface CPEvaluatedContentCell : CPBaseCell

@property (nonatomic, strong) NSDictionary <NSString *,id> *itemDict;

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *itemContent;

@end
