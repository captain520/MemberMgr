//
//  YXFProgress.m
//  gif
//
//  Created by yinxiufeng on 15/11/23.
//  Copyright © 2015年 fs. All rights reserved.
//

#import "CPProgress.h"
#import "AppDelegate.h"
#import "UIImage+GIF.h"

/**
 *  屏幕高度
 */
#define _screenHeight [UIScreen mainScreen].bounds.size.height
/**
 *  屏幕宽度
 */
#define _screenWidth [UIScreen mainScreen].bounds.size.width
/**
 *  间隙
 */
#define _Margin5 5.0f
#define _Margin10 10.0f
#define _Margin15 15.0f

/**
 *  字体大小
 */
#define _Font14 [UIFont systemFontOfSize:14]
/**
 *  颜色
 */
#define _whiteColor  [UIColor whiteColor]

/**
 *  颜色定义
 */
#define _Color(R, G, B, A) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:(A)]

@implementation CPProgress
{
    UIView *_view;
    
    UIView *_view1;
    
    UIView *_view2;
    
    UIWebView *webView;
}


+(CPProgress *)Instance
{
    __strong static CPProgress *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[CPProgress alloc] init];
    });
    return _instance;
}



/**
 *  文字提示
 */
-(void)showToast:(UIView *)view message:(NSString *)message
{
    if (view==nil) {
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        view = appDelegate.window;
    }
    if (_view2) {
        [_view2 removeFromSuperview];
        _view2 = nil;
    }
    
    
    if(_view2 ==  nil)
    {
        /**
         *  提示背景
         */
        CGFloat viewWidth = _screenWidth * 0.7;
        CGFloat viewHeight = 40;
        CGFloat maxY = _screenHeight * 0.5 - 154;
        CGFloat maxX = (_screenWidth - viewWidth) * 0.5;
        CGRect frame = CGRectMake(maxX,maxY,viewWidth,viewHeight);
        _view2 = [[UIImageView alloc]initWithFrame:frame];
        _view2.backgroundColor = _Color(0,0,0,0.75f);
        _view2.layer.cornerRadius = 5.0f;
        _view2.layer.masksToBounds = YES;
        [view addSubview:_view2];
        
        
        /**
         *  提示文字
         */
        CGFloat textWidth = viewWidth - 2 * _Margin10;
        CGFloat textHeight = viewHeight;
        
        CGSize textSize = [self sizeWithString:message textWidth:textWidth];
        
        maxY = 0;
        if(textSize.height > 30) //多行显示高度
        {
            maxY = _Margin10;
            textHeight = textSize.height;
            viewHeight = textHeight + 2 * _Margin10;
            _view2.frame = CGRectMake(_view2.frame.origin.x, _view2.frame.origin.y, _view2.frame.size.width, viewHeight);
        }
        
        frame= CGRectMake(_Margin10, maxY, textWidth, textHeight);
        UILabel *_label = [[UILabel alloc]initWithFrame:frame];
        _label.text =  message;
        _label.textColor = _whiteColor;
        _label.font = _Font14;
        _label.numberOfLines = 0;
        _label.textAlignment = NSTextAlignmentCenter;
        [_view2 addSubview:_label];
        
        /**
         动画处理
         */
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
            _view2.layer.position = CGPointMake(_view2.layer.position.x, _view2.layer.position.y + 40);
        } completion:^(BOOL finished) {
            // 完成处理
            [self performSelector:@selector(hiddenToast) withObject:nil afterDelay:2.0];
        }];
        
        
    }
}
/**
 *  隐藏提示
 */
-(void)hiddenToast
{
    if(_view2)
    {
        [UIView animateWithDuration:0.2 animations:^{
           // _view2.layer.position = CGPointMake(_view.layer.position.x, _view.layer.position.y - 40);
        } completion:^(BOOL finished) {
            [_view2 removeFromSuperview];
            _view2 = nil;
           
        }];
        
    }
}


/**
 *  获取字符串长度和高度
 */
-(CGSize)sizeWithString:(NSString *)message textWidth:(CGFloat)textWidth
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:_Font14,NSFontAttributeName, nil];
    return [message boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}


/**
 *  加载中提示或者提交中提示
 */
-(void)showLoading:(UIView *)view message:(NSString *)message
{
    if (view==nil) {
        return;
    }
    if (_view1) {
        [_view1 removeFromSuperview];
        _view1 = nil;
    }
    
    
    CGFloat viewWidth = 100;
    CGFloat viewHeight = viewWidth;
    CGFloat maxY = (SCREENHEIGHT- viewHeight) * 0.5;
    CGFloat maxX = (SCREENWIDTH- viewWidth) * 0.5;
    CGRect frame = CGRectZero;
    
    if(message == nil || [message isEqualToString:@""])
    {
        message = @"加载中…";
    }
    
    if(_view1 == nil)
    {
        /**
         *  提示背景
         */
        frame = CGRectMake(maxX,maxY,viewWidth,viewHeight);
        _view1 = [[UIView alloc]initWithFrame:frame];
        _view1.backgroundColor = _Color(0,0,0,0.75f);
        _view1.layer.cornerRadius = 8.0f;
        _view1.layer.masksToBounds = YES;
        [view addSubview:_view1];
    }
    
    
    
    /**
     *  加载图片显示
     */
    NSArray *array = [NSArray arrayWithObjects:
                      [UIImage imageNamed:@"loading_46x46_00"],
                      [UIImage imageNamed:@"loading_46x46_01"],
                      [UIImage imageNamed:@"loading_46x46_02"],
                      [UIImage imageNamed:@"loading_46x46_03"],
                      [UIImage imageNamed:@"loading_46x46_04"],
                      [UIImage imageNamed:@"loading_46x46_05"],
                      [UIImage imageNamed:@"loading_46x46_06"],
                      [UIImage imageNamed:@"loading_46x46_07"],
                      [UIImage imageNamed:@"loading_46x46_08"],
                      [UIImage imageNamed:@"loading_46x46_09"],
                      [UIImage imageNamed:@"loading_46x46_10"],nil];
    UIImageView * _imageView = [[UIImageView alloc]init];
    CGFloat imageViewWidth = 46;
    CGFloat imageViewHeight =imageViewWidth;
    maxY = _Margin15;
    maxX = (viewWidth-imageViewWidth) * 0.5;
    _imageView.frame = CGRectMake(maxX,maxY, imageViewWidth, imageViewHeight);
    _imageView.animationImages = array;
    _imageView.animationDuration = array.count * 0.1;
    [_imageView startAnimating];
    [_view1 addSubview:_imageView];
    
    
    /**
     *  文字提示
     */
    maxY = CGRectGetMaxY(_imageView.frame) + _Margin10;
    frame= CGRectMake(0, maxY, viewWidth, 2 * _Margin10);
    UILabel * _label = [[UILabel alloc]initWithFrame:frame];
    if (!message&&message.length==0) {
        message = @"加载中";
    }
    
    _label.text =  message;
    _label.textColor = _whiteColor;
    _label.font = _Font14;
    _label.textAlignment = NSTextAlignmentCenter;
    [_view1 addSubview:_label];

//    CGSize size = [UIImage imageNamed:@"loading.gif"].size;
//    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"loading.gif" ofType:nil];
//    
//    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
//    
//    if (_view==nil) {
//        _view = [[UIView alloc] initWithFrame:view.frame];
//        _view.backgroundColor = Color(0, 0, 0, 0.75);
//        [view addSubview:_view];
//        
//        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.5*(_screenWidth-size.width/2.0), 0.5*(_screenHeight-size.height/2.0), size.width/2.0, size.height/2.0)];
//        _imageView.backgroundColor = [UIColor clearColor];
//        _imageView.image = [UIImage sd_animatedGIFWithData:imageData];
//        [_view addSubview:_imageView];
//    }
    
    //    imgView.image = [UIImage animatedImageWithAnimatedGIFData:imageData];
    
  
}

-(void)showWith:(UIView *)view
{
    
    // 读取gif图片数据
//    CGRect frame = CGRectMake(0.5*(_screenWidth-size.width),0.5*(_screenHeight-size.height),size.width,size.height);
//    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"]];
//    // view生成
//    webView = [[UIWebView alloc] initWithFrame:frame];
//    webView.userInteractionEnabled = NO;//用户不可交互
//    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:@"UTF-8" baseURL:nil];
//    [view addSubview:webView];
}

/**
 *  成功提示
 */
-(void)showSuccess:(UIView *)view message:(NSString *)message  finish:(FinishBlock)finish;
{
    if (view==nil) {
        return;
    }
    
    if (_view) {
        [_view removeFromSuperview];
        _view = nil;
    }
    
   
    view.userInteractionEnabled = NO;
    self.finishBlock = finish;
    
    
    CGFloat viewWidth = 100;
    CGFloat viewHeight = viewWidth;
    CGFloat maxY = (view.frame.size.height - viewHeight) * 0.5;
    CGFloat maxX = (_screenWidth - viewWidth) * 0.5;
    CGRect frame = CGRectZero;
    if(_view == nil)
    {
        /**
         *  提示背景
         */
        frame = CGRectMake(maxX,maxY,viewWidth,viewHeight);
        _view = [[UIImageView alloc]initWithFrame:frame];
        _view.backgroundColor = _Color(0,0,0,0.75f);
        _view.layer.cornerRadius = 8.0f;
        _view.layer.masksToBounds = YES;
        [view addSubview:_view];
    }
    
    
    /**
     *  加载图片显示
     */
    NSArray *array = [NSArray arrayWithObjects:
                      [UIImage imageNamed:@"success_46x46_00"],
                      [UIImage imageNamed:@"success_46x46_01"],
                      [UIImage imageNamed:@"success_46x46_02"],
                      [UIImage imageNamed:@"success_46x46_03"],
                      [UIImage imageNamed:@"success_46x46_04"],
                      [UIImage imageNamed:@"success_46x46_05"],
                      [UIImage imageNamed:@"success_46x46_06"],
                      [UIImage imageNamed:@"success_46x46_07"],
                      [UIImage imageNamed:@"success_46x46_08"],
                      [UIImage imageNamed:@"success_46x46_09"],
                      [UIImage imageNamed:@"success_46x46_10"],
                      [UIImage imageNamed:@"success_46x46_11"],
                      [UIImage imageNamed:@"success_46x46_12"],
                      [UIImage imageNamed:@"success_46x46_13"],
                      [UIImage imageNamed:@"success_46x46_14"],
                      [UIImage imageNamed:@"success_46x46_15"],
                      [UIImage imageNamed:@"success_46x46_16"],
                      [UIImage imageNamed:@"success_46x46_16"],
                      [UIImage imageNamed:@"success_46x46_16"],
                      [UIImage imageNamed:@"success_46x46_16"],
                      [UIImage imageNamed:@"success_46x46_16"],
                      [UIImage imageNamed:@"success_46x46_16"],
                      [UIImage imageNamed:@"success_46x46_16"],
                      [UIImage imageNamed:@"success_46x46_16"],
                      [UIImage imageNamed:@"success_46x46_16"],
                      [UIImage imageNamed:@"success_46x46_16"],nil];
    UIImageView * _imageView = [[UIImageView alloc]init];
    CGFloat imageViewWidth = 46;
    CGFloat imageViewHeight =imageViewWidth;
    maxY = _Margin15;
    maxX = (viewWidth-imageViewWidth) * 0.5;
    _imageView.frame = CGRectMake(maxX,maxY, imageViewWidth, imageViewHeight);
    _imageView.animationImages = array;
    _imageView.animationDuration = array.count * 0.05;
    [_imageView startAnimating];
    [_view addSubview:_imageView];
    
    
    /**
     *  文字提示
     */
    maxY = CGRectGetMaxY(_imageView.frame) + _Margin10;
    frame= CGRectMake(0, maxY, viewWidth, 2 * _Margin10);
    UILabel * _label = [[UILabel alloc]initWithFrame:frame];
    _label.text =  message;
    _label.textColor = _whiteColor;
    _label.font = _Font14;
    _label.textAlignment = NSTextAlignmentCenter;
    [_view addSubview:_label];
    
    
    [self performSelector:@selector(delayHidden:) withObject:view afterDelay:_imageView.animationDuration];
    
    
}

/**
 *  失败提示
 */
-(void)showError:(UIView *)view message:(NSString *)message  finish:(FinishBlock)finish;
{
    if (view==nil) {
        return;
    }
    if (_view) {
        [_view removeFromSuperview];
        _view = nil;
    }
    
   
    view.userInteractionEnabled = NO;
    self.finishBlock = finish;
    
    CGFloat viewWidth = 100;
    CGFloat viewHeight = viewWidth;
    CGFloat maxY = (view.frame.size.height - viewHeight) * 0.5;
    CGFloat maxX = (_screenWidth - viewWidth) * 0.5;
    CGRect frame = CGRectZero;
    if(_view == nil)
    {
        /**
         *  提示背景
         */
        frame = CGRectMake(maxX,maxY,viewWidth,viewHeight);
        _view = [[UIImageView alloc]initWithFrame:frame];
        _view.backgroundColor = _Color(0,0,0,0.75f);
        _view.layer.cornerRadius = 8.0f;
        _view.layer.masksToBounds = YES;
        [view addSubview:_view];
    }
    
    
    
    /**
     *  加载图片显示
     */
    NSArray *array = [NSArray arrayWithObjects:
                      [UIImage imageNamed:@"error_46x46_00"],
                      [UIImage imageNamed:@"error_46x46_01"],
                      [UIImage imageNamed:@"error_46x46_02"],
                      [UIImage imageNamed:@"error_46x46_03"],
                      [UIImage imageNamed:@"error_46x46_04"],
                      [UIImage imageNamed:@"error_46x46_05"],
                      [UIImage imageNamed:@"error_46x46_06"],
                      [UIImage imageNamed:@"error_46x46_07"],
                      [UIImage imageNamed:@"error_46x46_08"],
                      [UIImage imageNamed:@"error_46x46_09"],
                      [UIImage imageNamed:@"error_46x46_10"],
                      [UIImage imageNamed:@"error_46x46_11"],
                      [UIImage imageNamed:@"error_46x46_12"],
                      [UIImage imageNamed:@"error_46x46_13"],
                      [UIImage imageNamed:@"error_46x46_14"],
                      [UIImage imageNamed:@"error_46x46_15"],
                      [UIImage imageNamed:@"error_46x46_16"],
                      [UIImage imageNamed:@"error_46x46_16"],
                      [UIImage imageNamed:@"error_46x46_16"],
                      [UIImage imageNamed:@"error_46x46_16"],
                      [UIImage imageNamed:@"error_46x46_16"],
                      [UIImage imageNamed:@"error_46x46_16"],
                      [UIImage imageNamed:@"error_46x46_16"],
                      [UIImage imageNamed:@"error_46x46_16"],
                      [UIImage imageNamed:@"error_46x46_16"],
                      [UIImage imageNamed:@"error_46x46_16"],nil];
    UIImageView * _imageView = [[UIImageView alloc]init];
    CGFloat imageViewWidth = 46;
    CGFloat imageViewHeight =imageViewWidth;
    maxY = _Margin15;
    maxX = (viewWidth-imageViewWidth) * 0.5;
    _imageView.frame = CGRectMake(maxX,maxY, imageViewWidth, imageViewHeight);
    _imageView.animationImages = array;
    _imageView.animationDuration = array.count * 0.05;
    [_imageView startAnimating];
    [_view addSubview:_imageView];
    
    /**
     *  文字提示
     */
    maxY = CGRectGetMaxY(_imageView.frame) + _Margin10;
    frame= CGRectMake(0, maxY, viewWidth, 2 * _Margin10);
    UILabel * _label = [[UILabel alloc]initWithFrame:frame];
    _label.text =  message;
    _label.textColor = _whiteColor;
    _label.font = _Font14;
    _label.textAlignment = NSTextAlignmentCenter;
    [_view addSubview:_label];
    
    [self performSelector:@selector(delayHidden:) withObject:view afterDelay:_imageView.animationDuration];
    
}


/**
 *  延时关闭提示
 */
-(void)delayHidden:(UIView *)view
{
    view.userInteractionEnabled = YES;
    [self hidden1];
    if(self.finishBlock){
        self.finishBlock(YES);
        self.finishBlock = nil;
    }
    
}

/**
 *  关闭提示
 */
-(void)hidden
{
    if(_view1 )
    {
        
        
        [_view1 removeFromSuperview];
        _view1 = nil;
        
    }
    
}


/**
 *  关闭提示
 */
-(void)hidden1
{
    if(_view )
    {
        
       
        [_view removeFromSuperview];
        _view = nil;

    }
    
}

@end
