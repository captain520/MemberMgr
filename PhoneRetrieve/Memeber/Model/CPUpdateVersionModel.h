//
//  CPUpdateVersionModel.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/8/3.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@interface CPUpdateVersionModel : CPBaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, copy) NSString *clientcfg;

@end
