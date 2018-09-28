//
//  CPBaseVC.h
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/8.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPBaseVC : UIViewController

- (void)push2VCWith:(NSString *)className title:(NSString *)title;

- (void)getConfigUrl:(NSString *)code block:(void (^)(NSString *url,NSString *title))block;


/**
 获取网页详情

 @param detailID ID
 @param block 详情回调
 */
- (void)getHelpDetail:(NSString *)detailID block:(void (^)(NSString *url,NSString *title))block;


/**
 * 返回操作
 */
- (void)back;

@end
