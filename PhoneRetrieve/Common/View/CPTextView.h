//
//  CPTextView.h
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/9.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPTextView;

@protocol CPTextViewDelegate<NSObject>

@optional
- (void)textViewDidBeginEditing:(CPTextView *)textView;
- (void)textViewDidEndEditing:(CPTextView *)textView;
- (void)textViewDidChange:(CPTextView *)textView;

@end

@interface CPTextView : UITextView<UITextViewDelegate>

@property (nonatomic, copy) NSString *placehodler;

@property (nonatomic, weak) id <CPTextViewDelegate> cpdelegate;

@property (nonatomic, assign) NSUInteger maxContentLength;

@property (nonatomic, copy) NSString *content;

@end
