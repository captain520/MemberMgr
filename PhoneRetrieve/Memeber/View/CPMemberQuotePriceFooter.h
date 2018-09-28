//
//  CPMemberQuotePriceFooter.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/14.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPHeaderFooter.h"

@interface CPMemberQuotePriceFooter : CPHeaderFooter

@property (nonatomic, strong) void (^actionBlock)(BOOL isUpDirection);

@property (nonatomic, copy) NSString *price;

@end
