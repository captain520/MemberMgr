//
//  CPProviceCityAreaModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/25.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@interface CPProviceCityAreaModel : CPBaseModel


@property (nonatomic, copy) NSString *district;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *Code;

@property (nonatomic, copy) NSString *areacode;

@property (nonatomic, copy) NSString *zipcode;

@property (nonatomic, assign) NSInteger parentcode;

@property (nonatomic, copy) NSString *province;

@end

