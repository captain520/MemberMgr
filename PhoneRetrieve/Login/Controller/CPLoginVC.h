//
//  CPLoginVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseVC.h"

@interface CPLoginVC : CPBaseVC
@property (nonatomic, copy) void (^loginBlock)(void);

@end
