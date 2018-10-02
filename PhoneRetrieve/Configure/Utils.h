//
//  Utils.h
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/13.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+(NSString *)formatDateTime:(NSString *)tiemSpan dateFormart:(NSString *)formatString;

//  对象转化为json字符串
NSString *cp_jsonString(id object);

//  JSON字符串转化为字典
id cp_dictionaryWithJsonString(NSString *jsonString);

NSString *cp_date2String(NSDate *date, NSString *format);

//  检测手机号码是否合法
BOOL CheckPhone(NSString *phone);

//  提示和红色后半部分字体
NSAttributedString *cp_commonRedAttr(NSString *head, NSString *tail);


//将 &lt 等类似的字符转化为HTML中的“<”等
NSString *htmlEntityDecode(NSString *string);


//将HTML字符串转化为NSAttributedString富文本字符串
NSAttributedString *attributedStringWithHTMLString(NSString *htmlString);

//  获取HTMLString字符串的Size
CGSize cp_getHtmlStringSize(NSString *htmlString);

//  获取富文本的Frame
CGRect cp_getTextFrame(NSString *text ,CGFloat width, NSDictionary <NSString *, id> *options) ;


//  获取富文本的Size
CGSize cp_getTextSize(NSString *text ,CGFloat width, NSDictionary <NSString *, id> *options) ;


//  获取富文本的高度
CGFloat cp_getTextHeight(NSString *text ,CGFloat width, NSDictionary <NSString *, id> *options) ;


//  获取流程富文本
NSAttributedString *cp_flowAttributeContent0(NSString *titleValue, NSString *detailValue);
NSAttributedString *cp_flowAttributeContent1(NSString *titleValue);


//  数字转字符能串
NSString *cp_int2String(NSInteger value) ;


////  将对象转为jsonstring
//NSString *cp_jsonString(id object) ;
NSString * cp_md5(NSString *input);

//  获取沙盒路径
NSString  *cp_documentFilePath(NSString *fileName);


BOOL cp_isNumber(NSString *strValue);


@end
