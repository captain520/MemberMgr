//
//  ZCBaseModel.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/28.
//  Copyright © 2018 Captain. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCBaseModel : NSObject

+ (instancetype)shareInstance;

+ (void)modelRequestWith:(NSString *)url
              parameters:(NSDictionary *)parameters
                   block:(void (^)(id result))successBlock
                    fail:(void (^)(CPError *error))failBlock;

+ (void)modelRequestPageWith:(NSString *)url
                  parameters:(NSDictionary *)parameters
                       block:(void (^)(id result))successBlock
                        fail:(void (^)(CPError *error))failBlock;

@end

NS_ASSUME_NONNULL_END
