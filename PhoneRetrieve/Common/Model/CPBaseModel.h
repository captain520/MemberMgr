//
//  ZZBaseModel.h
//  ZhiZaiDemo
//
//  Created by wangzhangchuan on 2017/12/1.
//  Copyright © 2017年 wangzhangchuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "API.h"
#import "CPError.h"

@interface CPBaseModel : NSObject

@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSArray *data;
@property (nonatomic, assign) NSInteger code;

@property (nonatomic, assign) NSInteger currentpage;

@property (nonatomic, assign) NSInteger pagesize;

@property (nonatomic, assign) NSInteger total;

+ (instancetype)shareInstance;

+ (void)modelRequestWith:(NSString *)url
              parameters:(NSDictionary *)parameters
                   block:(void (^)(id result))successBlock
                    fail:(void (^)(CPError *error))failBlock;

+ (void)modelPostRequestWith:(NSString *)url
                  parameters:(NSDictionary *)parameters
                       block:(void (^)(id result))successBlock
                        fail:(void (^)(NSError *error))failBlock;

+ (void)uploadImages:(UIImage *)image block:(void (^)(NSString *filePath))block;


+ (void)orderModelRequestWith:(NSString *)url
                   parameters:(NSDictionary *)parameters
                        block:(void (^)(id result))successBlock
                         fail:(void (^)(CPError *error))failBlock ;

+ (void)modelRequestPageWith:(NSString *)url
                  parameters:(NSDictionary *)parameters
                       block:(void (^)(id result))successBlock
                        fail:(void (^)(CPError *error))failBlock;



@end
