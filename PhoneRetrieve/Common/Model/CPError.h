//
//  CPError.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPError : NSError

@property (nonatomic, copy) NSString *cp_msg;

@property (nonatomic, assign) NSInteger cp_code;

- (id)initWithError:(NSError *)error;

@end
