//
//  CPConsignFooter.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPHeaderFooter.h"
#import "CPPhotoUploadBT.h"

@interface CPConsignFooter : CPHeaderFooter<UIPickerViewDelegate,UITextFieldDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) CPPhotoUploadBT *IDFrontBT;
@property (nonatomic, strong) CPPhotoUploadBT *goodImageBT;

@property (nonatomic, copy) void (^actionBlock)(NSDictionary *dict);

@end
