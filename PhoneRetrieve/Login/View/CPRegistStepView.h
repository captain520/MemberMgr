//
//  CPRegistStepView.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPView.h"

@interface CPRegistStepView : CPView


/**
 通过titles初始化对象

 @param frame 试图的Frame
 @param itemTitles 列表的标题
 @return 实例
 */
- (id)initWithFrame:(CGRect)frame itemTitles:(NSArray *)itemTitles;

@property (nonatomic, strong) NSArray <NSString *> *titles;

@property (nonatomic, assign) NSInteger currentStep;

@end
