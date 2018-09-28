//
//  CPSKUFooter.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/14.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPHeaderFooter.h"
#import "CPRetrieveFlowModel.h"
#import "CPFlowModel.h"

@interface CPSKUFooter : CPHeaderFooter<UIWebViewDelegate>

//@property (nonatomic, strong) Skuproperties *model;
@property (nonatomic, strong) CPFlowModel *model;

@property (nonatomic, copy) void (^actionBlock)(CGFloat height);

@end
