//
//  ZCBaseModel.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/28.
//  Copyright © 2018 Captain. All rights reserved.
//

#import "ZCBaseModel.h"

@implementation ZCBaseModel

MJExtensionCodingImplementation

+ (instancetype)shareInstance {
    
    static ZCBaseModel *obj;
    static dispatch_once_t once;
    
    if (nil == obj) {
        dispatch_once(&once, ^{
            obj = [[ZCBaseModel alloc] init];
        });
    }
    
    return obj;
}

+ (void)modelRequestWith:(NSString *)url
              parameters:(NSDictionary *)parameters
                   block:(void (^)(id result))successBlock
                    fail:(void (^)(CPError *error))failBlock {
    
    [[CPProgress Instance] showLoading:[UIApplication sharedApplication].keyWindow message:nil];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[CPProgress Instance] hidden];
        
        NSError *error = nil;
        
        if (error) {
            CPError *cp_error = [[CPError alloc] initWithError:error];
            !failBlock ? : failBlock(cp_error);
        } else {
            
            NSDictionary *dictObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            
            //            DDLogWarn(@"%@",dictObject);
            
            if (error) {
                CPError *cp_error = [[CPError alloc] initWithError:error];
                !failBlock ? : failBlock(cp_error);
            } else {
                
                NSInteger code = [dictObject[@"code"] integerValue];
                
                if (code != 200) {
                    
                    CPError *error = [[CPError alloc] init];
                    error.cp_msg = dictObject[@"msg"];
                    error.cp_code = [dictObject[@"code"] integerValue];
                    
                    [[CPProgress Instance] showToast:[UIApplication sharedApplication].keyWindow message:error.cp_msg];
                    !failBlock ? : failBlock(error);
                    
                    
                    return;
                }
                
//                if ([dictObject.allKeys containsObject:@"totalprice"] /*|| [dictObject.allKeys containsObject:@"total"]*/) {
//                    DDLogInfo(@"------------------------------需要结构体");
//                    !successBlock ? : successBlock([[self class] mj_objectWithKeyValues:dictObject]);
//                    return;
//                }
                
                id object = [dictObject valueForKey:@"data"];
                
                //  数组
                if ([object isKindOfClass:[NSArray class]]) {
                    
                    !successBlock ? : successBlock([[self class] mj_objectArrayWithKeyValuesArray:object]);
                    //  字典
                } else if([object isKindOfClass:[NSDictionary class]]) {
                    
                    !successBlock ? : successBlock([[self class] mj_objectWithKeyValues:object]);
                    
                    //  字符串
                } else if ([object isKindOfClass:[NSString class]]) {
                    
                    !successBlock ? : successBlock([[self class] mj_objectWithKeyValues:object]);
                    
                } else {
                    !successBlock ? : successBlock([CPBaseModel mj_objectWithKeyValues:dictObject]);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[CPProgress Instance] hidden];
        [[CPProgress Instance] showToast:[UIApplication sharedApplication].keyWindow message:[error localizedDescription]];
        !failBlock ? : failBlock([[CPError alloc] initWithError:error]);
    }];
    
}

+ (void)modelRequestPageWith:(NSString *)url
                  parameters:(NSDictionary *)parameters
                       block:(void (^)(id result))successBlock
                        fail:(void (^)(CPError *error))failBlock {
    
    [[CPProgress Instance] showLoading:[UIApplication sharedApplication].keyWindow message:nil];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[CPProgress Instance] hidden];
        
        NSError *error = nil;
        
        if (error) {
            CPError *cp_error = [[CPError alloc] initWithError:error];
            !failBlock ? : failBlock(cp_error);
        } else {
            
            NSDictionary *dictObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            
            DDLogWarn(@"%@",dictObject);
            
            if (error) {
                CPError *cp_error = [[CPError alloc] initWithError:error];
                !failBlock ? : failBlock(cp_error);
            } else {
                
                NSInteger code = [dictObject[@"code"] integerValue];
                
                if (code != 200) {
                    
                    CPError *error = [[CPError alloc] init];
                    error.cp_msg = dictObject[@"msg"];
                    error.cp_code = [dictObject[@"code"] integerValue];
                    
                    [[CPProgress Instance] showToast:[UIApplication sharedApplication].keyWindow message:error.cp_msg];
                    !failBlock ? : failBlock(error);
                    
                    
                    return;
                }
                
                id object = dictObject;//[dictObject valueForKey:@"data"];
                
                //  数组
                if ([object isKindOfClass:[NSArray class]]) {
                    
                    !successBlock ? : successBlock([[self class] mj_objectArrayWithKeyValuesArray:object]);
                    //  字典
                } else if([object isKindOfClass:[NSDictionary class]]) {
                    
                    !successBlock ? : successBlock([[self class] mj_objectWithKeyValues:object]);
                    
                    //  字符串
                } else if ([object isKindOfClass:[NSString class]]) {
                    
                    !successBlock ? : successBlock([[self class] mj_objectWithKeyValues:object]);
                    
                } else {
                    !successBlock ? : successBlock([CPBaseModel mj_objectWithKeyValues:dictObject]);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[CPProgress Instance] hidden];
        [[CPProgress Instance] showToast:[UIApplication sharedApplication].keyWindow message:[error localizedDescription]];
        !failBlock ? : failBlock([[CPError alloc] initWithError:error]);
    }];
    
}



@end
