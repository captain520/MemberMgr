//
//  CPError.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPError.h"

@implementation CPError

- (id)initWithError:(NSError *)error {
    
    if (self = [super init]) {
        self.cp_msg = [error localizedDescription];
        self.cp_code = error.code;
    }
    
    return self;
}

@end
