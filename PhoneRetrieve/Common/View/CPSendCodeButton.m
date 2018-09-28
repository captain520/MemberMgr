//
//  ZZSendCodeButton.m
//  chelian
//
//  Created by wangzhangchuan on 2017/11/2.
//  Copyright © 2017年 zhizai. All rights reserved.
//

#import "CPSendCodeButton.h"

#define MAXSECOND           (30)

@interface CPSendCodeButton()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSUInteger count;

@end

@implementation CPSendCodeButton

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedBaseProperties];
        
        [self addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)initializedBaseProperties {
    
    self.count = MAXSECOND;
    
    self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    
    [self setTitle:@"发送验证码" forState:UIControlStateNormal];
}

- (void)sendCode:(UIButton *)sender {
    
    NSDictionary *params = @{
                             @"phone" : self.phoneNumber
                             };
    
    [CPBaseModel modelRequestWith:CPURL_UTIL_SEND_MESSAGE_CODE
                       parameters:params
                            block:^(CPBaseModel *result) {
                                if (_timer == nil) {
                                    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown) userInfo:nil repeats:YES];
                                }
                            } fail:^(CPError *error) {
                                [[UIApplication sharedApplication].keyWindow makeToast:error.cp_msg duration:1.0f position:CSToastPositionCenter];
                            }];
    
}

- (void)countDown {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.enabled = NO;
        
        self.count--;
        
        NSString *intStr = [NSString stringWithFormat:@"%@秒",@(self.count)];
        [self setTitle:intStr forState:UIControlStateNormal];
        
        if (self.count == 0) {
            [self stopCountDown];
        }
    });
}

- (void)stopCountDown {
    
    [self.timer invalidate];
    self.timer = nil;
    
    [self setTitle:@"发送验证码" forState:UIControlStateNormal];
    self.enabled = YES;
    self.count = MAXSECOND;
}

@end
