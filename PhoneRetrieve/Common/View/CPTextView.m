//
//  CPTextView.m
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/9.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "CPTextView.h"

@implementation CPTextView {
    UILabel *placeholderLB;
}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.delegate = self;

        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    self.maxContentLength = INTMAX_MAX;

    if (nil == placeholderLB) {
        
        placeholderLB = UILabel.new;
        placeholderLB.textColor = C66;
        placeholderLB.text = @"选填";
        placeholderLB.font = [UIFont systemFontOfSize:15.0f];

        [self addSubview:placeholderLB];
        
        [placeholderLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.top.mas_equalTo(8);
        }];
    }
    
    self.layer.borderColor  = CPBoardColor.CGColor;
    self.layer.borderWidth  = 0.5f;
    self.layer.cornerRadius = 5.0f;
    
//    self.contentInset = UIEdgeInsetsMake(8, 8, 8, 8);
    self.font = [UIFont systemFontOfSize:15.0f];
    self.textColor = C33;
}

- (void)setContent:(NSString *)content {
    
    _content = content;
    
    self.text = _content;
    placeholderLB.hidden = content.length > 0;
}

#pragma mark - Delegate method

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    placeholderLB.hidden = textView.text.length > 0;
    
    if (self.cpdelegate && [self.cpdelegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.cpdelegate performSelector:@selector(textViewDidBeginEditing:) withObject:self];
    }
}

- (void)textViewDidEndEditing:(CPTextView *)textView {
    
    if (self.cpdelegate && [self.cpdelegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.cpdelegate performSelector:@selector(textViewDidEndEditing:) withObject:self];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@""]) {
        return YES;
    }

    if (textView.text.length >= self.maxContentLength) {
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    
    placeholderLB.hidden = textView.text.length > 0;
    
    if (self.cpdelegate && [self.cpdelegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.cpdelegate performSelector:@selector(textViewDidChange:) withObject:self];
    }
}
@end
