//
//  ZCAddMemberVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/10/16.
//  Copyright © 2018 Captain. All rights reserved.
//

#import "ZCAddMemberVC.h"
#import "CPPhotoUploadBT.h"
#import "CPCheckBox.h"
#import "CPWebVC.h"
#import "TZImagePickerController.h"
#import "ZCBaseModel.h"

@interface ZCAddMemberVC ()<CPSelectTextFieldDelegat>

@property (nonatomic, strong) CPSelectTextField *proviceTF, *cityTF, *areaTF;
@property (nonatomic, strong) CPProviceCityAreaModel *cityModel, *proviceModel, *areaModel;
@property (nonatomic, strong) CPTextField *memeberNameTF,*memeberPhoneTF,*addressTF;

@property (nonatomic, strong) CPPhotoUploadBT *businessLicenseBT, *IDFrontBT, *IDBackBT;

@property (nonatomic,strong) CPButton *nextAction;

@property (nonatomic, strong) CPCheckBox *checkBox;

@property (nonatomic, assign) BOOL agreeProtocol;

@end

@implementation ZCAddMemberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setTitle:@"子账号新增/修改"];
    [self loadProvice];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initialized base properties
- (void)initializedBaseProperties {
    
}
#pragma mark - setup ui
- (void)setupUI {
    
    CGFloat width = (SCREENWIDTH - 4 * cellSpaceOffset) / 3;
    
    if (nil == self.memeberNameTF) {
        self.memeberNameTF = [CPTextField new];
        self.memeberNameTF.placeholder = @"会员名称";
        
        [self.view addSubview:self.memeberNameTF];
        [self.memeberNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SPACE_OFFSET_F);
            make.right.mas_equalTo(-SPACE_OFFSET_F);
            make.height.mas_equalTo(CELL_HEIGHT_F);
            make.top.mas_equalTo(SPACE_OFFSET_F);
        }];
    }
    
    if (nil == self.memeberPhoneTF) {
        self.memeberPhoneTF = [CPTextField new];
        self.memeberPhoneTF.placeholder = @"会员电话";
        self.memeberPhoneTF.borderStyle = UITextBorderStyleRoundedRect;
        self.memeberPhoneTF.keyboardType = UIKeyboardTypePhonePad;
        
        [self.view addSubview:self.memeberPhoneTF];
        [self.memeberPhoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.memeberNameTF.mas_bottom).offset(SPACE_OFFSET_F);
            make.left.mas_equalTo(self.memeberNameTF.mas_left);
            make.right.mas_equalTo(self.memeberNameTF.mas_right);
            make.height.mas_equalTo(self.memeberNameTF.mas_height);
        }];
    }
    
    
    if (nil == self.proviceTF) {
        
        self.proviceTF = [[CPSelectTextField alloc] initWithFrame:CGRectMake(0, 0, width, CELL_HEIGHT_F)];
        self.proviceTF.placeholder = @"选择省";
        self.proviceTF.cp_editDelegate = self;
        self.proviceTF.type = 0;
        //        self.proviceTF.dataArray = @[@"1111",@"222",@"333"];
        
        [self.view addSubview:self.proviceTF];
        
        [self.proviceTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.memeberPhoneTF.mas_bottom).offset(SPACE_OFFSET_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    if (nil == self.cityTF) {
        
        self.cityTF = [[CPSelectTextField alloc] initWithFrame:CGRectMake(0, 0, width, CELL_HEIGHT_F)];
        self.cityTF.placeholder = @"选择市";
        //        self.cityTF.dataArray = @[@"aaa",@"bbb",@"ccc"];
        self.cityTF.cp_editDelegate = self;
        self.cityTF.type = 1;
        
        [self.view addSubview:self.cityTF];
        
        [self.cityTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.proviceTF.mas_top);
            make.left.mas_equalTo(self.proviceTF.mas_right).offset(cellSpaceOffset);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    if (nil == self.areaTF) {
        
        self.areaTF = [[CPSelectTextField alloc] initWithFrame:CGRectMake(0, 0, width, CELL_HEIGHT_F)];
        self.areaTF.placeholder = @"选择区";
        //        self.areaTF.dataArray = @[@"----",@"xxxx",@">>>>>>"];
        self.areaTF.cp_editDelegate = self;
        self.areaTF.type = 2;
        
        [self.view addSubview:self.areaTF];
        
        [self.areaTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.proviceTF.mas_top);
            make.left.mas_equalTo(self.cityTF.mas_right).offset(cellSpaceOffset);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    //  收货地址栏
    {
        self.addressTF = [CPTextField new];
        self.addressTF.placeholder = @"收货地址";
        
        [self.view addSubview:self.addressTF];
        [self.addressTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.proviceTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    //  图片上传
    if (nil == self.businessLicenseBT) {
        
        self.businessLicenseBT = [CPPhotoUploadBT new];
        [self.businessLicenseBT setBackgroundImage:CPImage(@"add_pic") forState:UIControlStateNormal];
        [self.businessLicenseBT addTarget:self action:@selector(showImagePickVC:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.businessLicenseBT];
        
        [self.businessLicenseBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.addressTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.size.mas_equalTo(CGSizeMake(2 * CELL_HEIGHT_F, 2 * CELL_HEIGHT_F));
        }];
        
    }
    
    
    CPLabel *licenseTitleLB = [CPLabel new];
    licenseTitleLB.text = @"营业执照(可选)";
    licenseTitleLB.textColor = [UIColor redColor];
    licenseTitleLB.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:licenseTitleLB];
    
    [licenseTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.businessLicenseBT.mas_bottom).offset(4);
        make.left.mas_equalTo(self.businessLicenseBT.mas_left);
        make.right.mas_equalTo(self.businessLicenseBT.mas_right);
    }];
    
    
    if (nil == self.IDFrontBT) {
        
        self.IDFrontBT = [CPPhotoUploadBT new];
        //        self.IDFrontBT.backgroundColor = UIColor.redColor;
        //        [self.IDFrontBT setImage:CPImage(@"header.jpg") forState:0];
        [self.IDFrontBT setBackgroundImage:CPImage(@"add_pic") forState:UIControlStateNormal];
        [self.IDFrontBT addTarget:self action:@selector(showImagePickVC:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.IDFrontBT];
        
        [self.IDFrontBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(licenseTitleLB.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.size.mas_equalTo(CGSizeMake(2 * CELL_HEIGHT_F, 2 * CELL_HEIGHT_F));
        }];
        
        CPLabel *titleLB = [CPLabel new];
        titleLB.text = @"身份证正面（必填）";
        titleLB.textAlignment = NSTextAlignmentCenter;
        titleLB.textColor = [UIColor redColor];
        
        [self.view addSubview:titleLB];
        
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IDFrontBT.mas_bottom).offset(4);
            make.left.mas_equalTo(self.IDFrontBT.mas_left);
            make.right.mas_equalTo(self.IDFrontBT.mas_right);
        }];
    }
    
    if (nil == self.IDBackBT) {
        
        self.IDBackBT = [CPPhotoUploadBT new];
        //        self.IDBackBT.backgroundColor = UIColor.redColor;
        //        [self.IDBackBT setImage:CPImage(@"header.jpg") forState:0];
        [self.IDBackBT setBackgroundImage:CPImage(@"add_pic") forState:UIControlStateNormal];
        [self.IDBackBT addTarget:self action:@selector(showImagePickVC:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.IDBackBT];
        
        [self.IDBackBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(licenseTitleLB.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(self.IDFrontBT.mas_right).offset(cellSpaceOffset);
            make.size.mas_equalTo(CGSizeMake(2 * CELL_HEIGHT_F, 2 * CELL_HEIGHT_F));
        }];
        
        CPLabel *titleLB = [CPLabel new];
        titleLB.text = @"身份证背面(必填)";
        titleLB.textAlignment = NSTextAlignmentCenter;
        titleLB.textColor = [UIColor redColor];
        
        [self.view addSubview:titleLB];
        
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IDBackBT.mas_bottom).offset(4);
            make.left.mas_equalTo(self.IDBackBT.mas_left);
            make.right.mas_equalTo(self.IDBackBT.mas_right);
        }];
    }
    
    if (nil == self.checkBox) {
        
        NSDictionary *option0 = @{
                                  NSFontAttributeName : [UIFont systemFontOfSize:13.0f],
                                  NSForegroundColorAttributeName : C33
                                  };
        NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:@" 同意"
                                                                                  attributes:option0];
        NSDictionary *option1 = @{
                                  NSFontAttributeName : [UIFont systemFontOfSize:13.0f],
                                  NSForegroundColorAttributeName : C33,
                                  NSUnderlineStyleAttributeName : @1
                                  };
        NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:@"《乐收栈注册协议》" attributes:option1];
        
        [attr0 appendAttributedString:attr1];
        
        __weak typeof(self) weakSelf = self;
        
        self.checkBox = [[CPCheckBox alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.checkBox.content = attr0;
        self.checkBox.actionBlock = ^(BOOL aggree) {
            [weakSelf handleAgreeProtocolBlock:aggree];
        };
        
        self.checkBox.showHintBlock = ^{
            [weakSelf getConfigUrl:@"200" block:^(NSString *url, NSString *title) {
                CPWebVC *webVC = [[CPWebVC alloc] init];
                //        webVC.urlStr = @"https://www.baidu.com";
                webVC.contentStr = url;
                webVC.title = title;
                webVC.hidesBottomBarWhenPushed = YES;
                
                [weakSelf.navigationController pushViewController:webVC animated:YES];
            }];
        };
        
        [self.view addSubview:self.checkBox];
        
        [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IDFrontBT.mas_bottom).offset(cellSpaceOffset * 4);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(20);
        }];
    }

    if (nil == self.nextAction) {
        self.nextAction = [CPButton new];
        [self.view addSubview:self.nextAction];
        [self.nextAction setTitle:@"提 交" forState:0];
        [self.nextAction addTarget:self action:@selector(nextAction:) forControlEvents:64];
        [self.nextAction mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.checkBox.mas_bottom).offset(CELL_HEIGHT_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
        RAC(self.nextAction,enabled) = [RACSignal combineLatest:@[
                                                                  self.memeberNameTF.rac_textSignal,
                                                                  self.memeberPhoneTF.rac_textSignal,
                                                                  self.proviceTF.rac_textSignal,
                                                                  self.cityTF.rac_textSignal,
                                                                  self.areaTF.rac_textSignal,
                                                                  self.addressTF.rac_textSignal,
                                                                  ]
                                                         reduce:^id{
                                                             return @(
                                                             self.memeberNameTF.text.length > 0 &&
                                                             self.memeberPhoneTF.text.length > 0 &&
//                                                             self.proviceTF.text.length > 0 &&
//                                                             self.cityTF.text.length > 0 &&
//                                                             self.areaTF.text.length > 0 &&
                                                             self.addressTF.text.length > 0 &&
                                                             //                                                                 self.bankBranchTF.text.length > 0 &&
                                                             self.IDFrontBT.imageUrl.length > 0 &&
                                                             self.IDBackBT.imageUrl.length > 0 &&
                                                             self.agreeProtocol == YES
                                                             );
                                                         }];
    }
}
#pragma mark - setter && getter method
#pragma mark - Delegate && Datasource method implement
#pragma mark - PrivateMethod

- (void)handleAgreeProtocolBlock:(NSInteger )agrree {
    self.agreeProtocol = agrree;
    
    self.nextAction.enabled = (
                               self.memeberNameTF.text.length > 0 &&
                               self.memeberPhoneTF.text.length > 0 &&
//                               self.proviceTF.text.length > 0 &&
//                               self.cityTF.text.length > 0 &&
//                               self.areaTF.text.length > 0 &&
                               self.addressTF.text.length > 0 &&
                               self.IDFrontBT.imageUrl.length > 0 &&
                               self.IDBackBT.imageUrl.length > 0 &&
                               self.agreeProtocol == YES
                               );
}

- (void)showImagePickVC:(CPPhotoUploadBT *)sender {
    
    __weak typeof(self) weakSelf = self;
    
    TZImagePickerController *vc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    vc.allowPickingVideo = NO;
    vc.allowPickingGif = NO;
    
    [vc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        NSLog(@"------");
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[CPProgress Instance] showLoading:self.view message:@"图片上传中"];
            
            [CPBaseModel uploadImages:photos.firstObject block:^(NSString *filePath) {
                DDLogError(@">>>>>>>>>>>>>>>>>>>>%@",filePath);
                [[CPProgress Instance] hidden];
                
                if ([filePath isKindOfClass:[NSString class]] && filePath.length > 0) {
                    sender.imageUrl = filePath;
                    [weakSelf handleImagePickImageBlock];
                    
                    [sender setImage:photos.firstObject forState:UIControlStateNormal];
                } else {
                    [weakSelf.view makeToast:@"图片上传失败" duration:2.f position:CSToastPositionCenter];
                }
            }];
            
        });
    }];
    
    
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav presentViewController:vc animated:YES completion:nil];
}

- (void)handleImagePickImageBlock {
    self.nextAction.enabled = (
                               self.memeberNameTF.text.length > 0 &&
                               self.memeberPhoneTF.text.length > 0 &&
//                               self.proviceTF.text.length > 0 &&
//                               self.cityTF.text.length > 0 &&
//                               self.areaTF.text.length > 0 &&
                               self.addressTF.text.length > 0 &&
                               self.IDFrontBT.imageUrl.length > 0 &&
                               self.IDBackBT.imageUrl.length > 0 &&
                               self.agreeProtocol == YES
                               );
}

#pragma mark - CPSelectTextFieldDelegat
- (void)cp_textFieldDidBeginEditing:(UITextField *)textField model:(CPProviceCityAreaModel *)model{};
- (void)cp_textFieldDidEndEditing:(UITextField *)textField model:(CPProviceCityAreaModel *)model{
    
    if (textField == self.proviceTF) {
        [self loadCity:model.Code];
        self.proviceModel = model;
    } else if (textField == self.cityTF) {
        [self loadArea:model.Code];
        self.cityModel = model;
    } else if (textField == self.areaTF) {
        self.areaModel = model;
    }
}


#pragma mark - private method implement
#pragma mark - load data

- (void)loadProvice {
    
    __weak typeof(self) weakSelf = self;
    
    [CPProviceCityAreaModel modelRequestWith:DOMAIN_ADDRESS@"/api/area/findData?parentcode=0"
                                  parameters:nil
                                       block:^(id result) {
                                           [weakSelf handleLoadProviceBlock:result];
                                       } fail:^(CPError *error) {
                                           
                                       }];
}

- (void)handleLoadProviceBlock:(NSArray <CPProviceCityAreaModel *> *)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        return;
    }
    
    self.proviceTF.dataArray = result;
}

- (void)loadCity:(NSString *)paramCode {
    
    __weak typeof(self) weakSelf = self;
    
    [CPProviceCityAreaModel modelRequestWith:DOMAIN_ADDRESS@"/api/area/findData"
                                  parameters:@{@"parentcode" : paramCode}
                                       block:^(id result) {
                                           [weakSelf handleLoadCityBlock:result];
                                       } fail:^(CPError *error) {
                                           
                                       }];
}

- (void)handleLoadCityBlock:(NSArray <CPProviceCityAreaModel *> *)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        return;
    }
    
    self.cityTF.dataArray = result;
}

- (void)loadArea:(NSString *)paramCode {
    
    __weak typeof(self) weakSelf = self;
    
    [CPProviceCityAreaModel modelRequestWith:DOMAIN_ADDRESS@"/api/area/findData"
                                  parameters:@{@"parentcode" : paramCode}
                                       block:^(id result) {
                                           [weakSelf handleLoadAreaBlock:result];
                                       } fail:^(CPError *error) {
                                           
                                       }];
}

- (void)handleLoadAreaBlock:(NSArray <CPProviceCityAreaModel *> *)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        return;
    }
    
    self.areaTF.dataArray = result;
}

-(void)nextAction:(id)sender {
    
    NSMutableDictionary *params = @{
                                    @"currentuserid" : @([CPUserInfoModel shareInstance].userDetaiInfoModel.ID),
                                    @"linkname" : self.memeberNameTF.text,
                                    @"phone" : self.memeberPhoneTF.text,
//                                    @"provinceid" : self.proviceModel.Code,
//                                    @"cityid" : self.cityModel.Code,
//                                    @"districtid" : self.areaModel.Code,
                                    @"address" : self.addressTF.text,
                                    @"currentuserid" : USER_ID,
                                    @"idcard1url" : self.IDFrontBT.imageUrl,
                                    @"idcard2url" : self.IDBackBT.imageUrl,
                                    }.mutableCopy;
    if (self.businessLicenseBT.imageUrl) {
//        [params setObject:self.businessLicenseBT.imageUrl forKey:@"licenseurl"];
    }
    
    __weak typeof(self) weakSelf = self;
    
    [ZCBaseModel modelRequestPageWith:DOMAIN_ADDRESS@"/api/user/createChildAgent"
                           parameters:params
                                block:^(id result) {
                                    [weakSelf handleNexgtActionBlock:result];
                                } fail:^(CPError *error) {
                                    
                                }];
}

- (void)handleNexgtActionBlock:(id)result {
    [self.view makeToast:@"新增成功" duration:2 position:CSToastPositionCenter];
}

@end

