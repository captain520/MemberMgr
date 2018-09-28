//
//  ZZBaseModel.m
//  ZhiZaiDemo
//
//  Created by wangzhangchuan on 2017/12/1.
//  Copyright © 2017年 wangzhangchuan. All rights reserved.
//

#import "CPBaseModel.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>

@implementation CPBaseModel

+ (instancetype)shareInstance {
    static CPBaseModel *obj;
    static dispatch_once_t once;
    
    if (nil == obj) {
        dispatch_once(&once, ^{
            obj = [[CPBaseModel alloc] init];
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

                if ([dictObject.allKeys containsObject:@"totalprice"] /*|| [dictObject.allKeys containsObject:@"total"]*/) {
                    DDLogInfo(@"------------------------------需要结构体");
                    !successBlock ? : successBlock([[self class] mj_objectWithKeyValues:dictObject]);
                    return;
                }
                
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
                
                if ([dictObject.allKeys containsObject:@"totalprice"] || [dictObject.allKeys containsObject:@"total"]) {
                    DDLogInfo(@"------------------------------需要结构体");
                    !successBlock ? : successBlock([[self class] mj_objectWithKeyValues:dictObject]);
                    return;
                }
                
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

+ (void)modelPostRequestWith:(NSString *)urlString
              parameters:(NSDictionary *)parameter
                   block:(void (^)(id result))successBlock
                    fail:(void (^)(NSError *error))failBlock {

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameter options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    [manager setSecurityPolicy:[self customSecurityPolicy]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:nil error:nil];
    
    req.timeoutInterval= 30;
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error == nil) {
            id dictObject = responseObject;//[responseObject valueForKey:@"content"];//[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            
            if (error) {
                !failBlock ? : failBlock(error);
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
//                !successBlock ? : successBlock([CPBaseModel mj_objectWithKeyValues:dictObject]);
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
        } else {
            [[CPProgress Instance] hidden];
            [[CPProgress Instance] showToast:[UIApplication sharedApplication].keyWindow message:[error localizedDescription]];
            !failBlock ? : failBlock(error);
        }
    }] resume];

}


+ (void)uploadImages:(UIImage *)image
               block:(void (^)(NSString *filePath))block {

//    NSString *url = @"http://test.iviov.com:8088/app/sns/v1/uploadResource";
//    NSString *url = @"http://maintenance.piaoliusan.com:81/app/upload/image";
    NSString *url = DOMAIN_ADDRESS@"/api/Upload/uploadImage";
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]
                                    multipartFormRequestWithMethod:@"POST"
                                    URLString:url
                                    parameters:nil
                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                        
//                                        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                                            //                                            NSString *name = [NSString stringWithFormat:@"file%lu",(unsigned long)idx];
//                                            NSData *data = UIImageJPEGRepresentation(obj, 1.0f);
//                                            NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//                                            NSData *tempData = [encodedImageStr dataUsingEncoding:NSUTF8StringEncoding];
//
//                                            NSString *name = [NSString stringWithFormat:@"file"];
//                                            NSString *filename = [NSString stringWithFormat:@"filename%lu.jpg",(unsigned long)idx];
//                                            [formData appendPartWithFileData:tempda
//                                                                        name:name
//                                                                    fileName:filename
//                                                                    mimeType:@"image/jpeg"];
//                                        }];
                                        
//                                        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                                            NSString *name = [NSString stringWithFormat:@"file%lu",(unsigned long)idx];
                                        NSString *name = [NSString stringWithFormat:@"file"];
                                        NSString *filename = @"temp.jpg";
                                        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 1)
                                                                    name:name
                                                                fileName:filename
                                                                mimeType:@"image/jpeg"];
//                                        }];
                                    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      NSLog(@"--------------------%f",uploadProgress.fractionCompleted);
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                      } else {
                          !block ? : block([responseObject[@"data"] valueForKeyPath:@"result"]);
                      }
                  }];
    
    [uploadTask resume];
}

+ (void)modelRequest:(NSString *)url
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
                
                if ([dictObject.allKeys containsObject:@"totalprice"]) {
                    DDLogInfo(@"------------------------------需要结构体");
                }
                
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

+ (void)orderModelRequestWith:(NSString *)url
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
                
                if ([dictObject.allKeys containsObject:@"totalprice"]) {
                    DDLogInfo(@"------------------------------需要结构体");
                    id data = dictObject[@"data"];
                    if (data) {
                        if ([data isKindOfClass:[NSArray class]]) {
                            !successBlock ? : successBlock([[self class] mj_objectArrayWithKeyValuesArray:data]);
                        } else {
                            !successBlock ? : successBlock([[self class] mj_objectWithKeyValues:data]);
                        }
                        
                    }
//                    else {
//
//                        !successBlock ? : successBlock([[self class] mj_objectWithKeyValues:dictObject]);
//                    }
                    return;
                }
                
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
@end
