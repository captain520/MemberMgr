//
//  CPConsignFooter.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPConsignFooter.h"
#import "TZImagePickerController.h"

@implementation CPConsignFooter {
    CPButton *actionBT;

    CPTextField *companyTF, *consignNoLB;
    
    UIPickerView *consignCompanyPicker;
    
    NSArray *consignCompanys;
}

- (void)setupUI {
    
    consignCompanys = @[@"顺丰快递"/*,@"圆通快递"*/];
    
    consignCompanyPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 220)];
    consignCompanyPicker.delegate = self;
    consignCompanyPicker.dataSource = self;

    companyTF = [CPTextField new];
    companyTF.text = @"顺丰快递";
    companyTF.delegate = self;
    companyTF.userInteractionEnabled = NO;
    companyTF.actionType = CPTextFieldActionTypeRightAction;
    companyTF.rightActionImageName = @"home_down";
    companyTF.tintColor = [UIColor clearColor];
    companyTF.borderStyle = UITextBorderStyleRoundedRect;
    companyTF.font = CPFont_M;
    companyTF.inputView = consignCompanyPicker;
    [self.contentView addSubview:companyTF];
    
    [companyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cellSpaceOffset);
        make.left.mas_equalTo(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];
    
    consignNoLB = [CPTextField new];
//    consignNoLB.text = @"物流单号";
    consignNoLB.placeholder = @"物流单号（12位）";
    consignNoLB.font = CPFont_M;
    consignNoLB.borderStyle = UITextBorderStyleRoundedRect;
    consignNoLB.tintColor = [UIColor clearColor];
    consignNoLB.keyboardType = UIKeyboardTypeNumberPad;
    [self.contentView addSubview:consignNoLB];
    
    [consignNoLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(companyTF.mas_bottom).offset(cellSpaceOffset);
        make.left.mas_equalTo(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];

    self.IDFrontBT = [CPPhotoUploadBT new];
    self.IDFrontBT.hidden = IS_MEMBER_ACCOUNT;
    if (IS_MEMBER_ACCOUNT) {
        self.IDFrontBT.imageUrl = @"null";
    }
    self.IDFrontBT.backgroundColor = UIColor.clearColor;
    [self.IDFrontBT setBackgroundImage:CPImage(@"camera") forState:UIControlStateNormal];
    [self.IDFrontBT addTarget:self action:@selector(showImagePickVC:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.IDFrontBT];
    
    [self.IDFrontBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(consignNoLB.mas_bottom).offset(cellSpaceOffset);
        make.left.mas_equalTo(cellSpaceOffset);
        make.size.mas_equalTo(CGSizeMake(2 * CELL_HEIGHT_F, 2 * CELL_HEIGHT_F));
    }];
    
    UILabel *titleLB = [UILabel new];
    titleLB.hidden = IS_MEMBER_ACCOUNT;
    titleLB.text = @"拍照上传快递单";
    titleLB.textColor = [UIColor redColor];
    titleLB.textAlignment = NSTextAlignmentLeft;
    titleLB.font = CPFont_M;
    
    [self.contentView addSubview:titleLB];
    
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.IDFrontBT.mas_bottom).offset(cellSpaceOffset/2);
        make.left.mas_equalTo(self.IDFrontBT.mas_left);
    }];
    
    
    {
        self.goodImageBT = [CPPhotoUploadBT new];
        self.goodImageBT.hidden = IS_MEMBER_ACCOUNT;
        if (IS_MEMBER_ACCOUNT) {
            self.goodImageBT.imageUrl = @"null";
        }
        self.goodImageBT.backgroundColor = UIColor.clearColor;
        [self.goodImageBT setBackgroundImage:CPImage(@"camera") forState:UIControlStateNormal];
        [self.goodImageBT addTarget:self action:@selector(showImagePickVC:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:self.goodImageBT];
        
        [self.goodImageBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IDFrontBT.mas_top);
            make.left.mas_equalTo(self.IDFrontBT.mas_right).offset(cellSpaceOffset);
            make.size.mas_equalTo(CGSizeMake(2 * CELL_HEIGHT_F, 2 * CELL_HEIGHT_F));
        }];
        
        UILabel *titleLB = [UILabel new];
        titleLB.hidden = IS_MEMBER_ACCOUNT;
        titleLB.text = @"货品拍照";
        titleLB.textColor = [UIColor redColor];
        titleLB.textAlignment = NSTextAlignmentCenter;
        titleLB.font = CPFont_M;
        
        [self.contentView addSubview:titleLB];
        
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IDFrontBT.mas_bottom).offset(cellSpaceOffset/2);
            make.left.mas_equalTo(self.goodImageBT.mas_left);
            make.right.mas_equalTo(self.goodImageBT.mas_right);
        }];
    }

    actionBT = [CPButton new];
    [actionBT setTitle:@"确定发货" forState:0];
    [actionBT addTarget:self action:@selector(buttonAction:) forControlEvents:64];
    [self.contentView addSubview:actionBT];
    
    [actionBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(cellSpaceOffset);
        make.right.mas_offset(-cellSpaceOffset);
        make.bottom.mas_offset(-cellSpaceOffset);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];
    
    RAC(actionBT,enabled) = [RACSignal combineLatest:@[consignNoLB.rac_textSignal] reduce:^id{
        return @(consignNoLB.text.length == 12
        && self.IDFrontBT.imageUrl.length > 0);
    }];
}

#pragma mark - PickView delegate and datasource

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return consignCompanys.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    
    return consignCompanys[row];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    NSString *content = consignCompanys[[consignCompanyPicker selectedRowInComponent:0]];
    companyTF.text = content;
}


- (void)showImagePickVC:(CPPhotoUploadBT *)sender {
    
    __weak CPConsignFooter *weakSelf = self;
    
    TZImagePickerController *vc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    
    [vc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        NSLog(@"------");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [sender setImage:photos.firstObject forState:UIControlStateNormal];
        });
        
        [[CPProgress Instance] showLoading:[UIApplication sharedApplication].keyWindow message:@"图片上传中"];
        
        [CPBaseModel uploadImages:photos.firstObject block:^(NSString *filePath) {
            DDLogError(@">>>>>>>>>>>>>>>>>>>>%@",filePath);
            sender.imageUrl = filePath;
            [[CPProgress Instance] hidden];
            actionBT.enabled = consignNoLB.text.length == 12;
        }];
    }];

    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav presentViewController:vc animated:YES completion:nil];
}

- (void)buttonAction:(UIButton *)sender {

    NSMutableDictionary *params = @{
//                             @"userid" : @([CPUserInfoModel shareInstance].loginModel.ID),
//                             @"username" : [CPUserInfoModel shareInstance].loginModel.linkname,
                             @"logisticsno" : consignNoLB.text,
                             @"logisticsimageurls" : self.IDFrontBT.imageUrl,
                             @"deviceurls" : self.goodImageBT.imageUrl,
                             @"doorid" : @([CPUserInfoModel shareInstance].loginModel.ID),
                             @"doorname" : [CPUserInfoModel shareInstance].loginModel.linkname,
                             }.mutableCopy;
    
    NSUInteger userType = [CPUserInfoModel shareInstance].loginModel.Typeid;
    NSUInteger userID = [CPUserInfoModel shareInstance].loginModel.ID;
    NSString *userCode = [CPUserInfoModel shareInstance].loginModel.cp_code;
    NSInteger typeID = [CPUserInfoModel shareInstance].loginModel.Typeid;
    if (userType == 6 || userType == 7) {
        [params setObject:@(userID) forKey:@"currentuserid"];
        [params setObject:userCode forKey:@"code"];
        [params setObject:@(typeID) forKey:@"typeid"];
    }


    !self.actionBlock ? : self.actionBlock(params);
}

@end
