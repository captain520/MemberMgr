//
//  YXFProgress.h
//  gif
//
//  Created by yinxiufeng on 15/11/23.
//  Copyright © 2015年 fs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  定义 block 方法
 */
typedef void (^FinishBlock) (BOOL finished);

@interface CPProgress : NSObject



+(CPProgress *)Instance;

/**
 * 完成后操作
 */
@property(nonatomic,copy)FinishBlock finishBlock;

/**
 *  文字提示
 */
-(void)showToast:(UIView *)view message:(NSString *)message;

/**
 *  加载中提示或者提交中提示
 */
-(void)showLoading:(UIView *)view message:(NSString *)message;


/**
 *  成功提示
 */
-(void)showSuccess:(UIView *)view message:(NSString *)message finish:(FinishBlock)finish;

/**
 *  失败提示
 */
-(void)showError:(UIView *)view message:(NSString *)message finish:(FinishBlock)finish;

/**
 *  关闭提示
 */
-(void)hidden;

@end
