//
//  CPAssistantEditVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/8.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPAssistantEditVC.h"
#import <TZImagePickerController.h>
#import "CPPhotoUploadBT.h"
#import "CPAddMemberResultModel.h"
#import "CPUserDetailInfoModel.h"

@interface CPAssistantEditVC ()

@property (nonatomic, strong) CPTextField *accountTF, *codeTF, *passwdTF, *confirmTF;
@property (nonatomic, strong) CPButton *nextBT;
@property (nonatomic, strong) CPPhotoUploadBT *IDFrontBT, *IDBackBT;
//@property (nonatomic, strong) CPUserDetailInfoModel *model;
@property (nonatomic, strong) CPUserDetailInfoModel *model;

@end

@implementation CPAssistantEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    
    if (nil == self.accountTF) {
        self.accountTF = [CPTextField new];
        self.accountTF.font = [UIFont systemFontOfSize:13.0f];
        self.accountTF.placeholder = @"姓名";
        self.accountTF.borderStyle = UITextBorderStyleRoundedRect;
//        self.accountTF.keyboardType = UIKeyboardTypeNumberPad;
//        self.accountTF.text = self.model.linkname;
        
        [self.view addSubview:self.accountTF];
        
        [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(cellSpaceOffset + NAV_HEIGHT);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
    }

    if (nil == self.codeTF) {
        self.codeTF = [CPTextField new];
        self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
        self.codeTF.font = [UIFont systemFontOfSize:13.0];
        self.codeTF.borderStyle = UITextBorderStyleRoundedRect;
        self.codeTF.placeholder = @"手机号码";
//        self.codeTF.text = self.model.phone;
        
        [self.view addSubview:self.codeTF];
        
        [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.accountTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
            make.right.mas_equalTo(-cellSpaceOffset);
        }];
        
    }
    
    if (nil == self.passwdTF) {
        self.passwdTF = [CPTextField new];
        self.passwdTF.keyboardType = UIKeyboardTypeNumberPad;
        self.passwdTF.font = [UIFont systemFontOfSize:13.0];
        self.passwdTF.borderStyle = UITextBorderStyleRoundedRect;
        self.passwdTF.secureTextEntry = YES;
        self.passwdTF.placeholder = @"密码(6~20)";
//        self.passwdTF.text = @"暂无此字段";

        [self.view addSubview:self.passwdTF];
        
        [self.passwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.codeTF.mas_bottom).offset(cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            
        }];
    }
    
    if (nil == self.confirmTF) {
        self.confirmTF = [CPTextField new];
        self.confirmTF.keyboardType = UIKeyboardTypeNumberPad;
        self.confirmTF.font = [UIFont systemFontOfSize:13.0];
        self.confirmTF.borderStyle = UITextBorderStyleRoundedRect;
        self.confirmTF.placeholder = @"确认密码(6~20)";
        self.confirmTF.secureTextEntry = YES;
//        self.confirmTF.text = @"暂无此字段";
        
        [self.view addSubview:self.confirmTF];
        
        [self.confirmTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwdTF.mas_bottom).offset(cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
        }];
    }
    
    if (nil == self.IDFrontBT) {
        
        self.IDFrontBT = [CPPhotoUploadBT new];
        self.IDFrontBT.layer.cornerRadius = 5.0f;
        self.IDFrontBT.clipsToBounds = YES;
//        self.IDFrontBT.backgroundColor = UIColor.redColor;
        //        [self.IDFrontBT setImage:CPImage(@"header.jpg") forState:0];
        [self.IDFrontBT setBackgroundImage:CPImage(@"add_pic") forState:UIControlStateNormal];
        [self.IDFrontBT addTarget:self action:@selector(showImagePickVC:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.IDFrontBT];
        
        [self.IDFrontBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.confirmTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.size.mas_equalTo(CGSizeMake(2 * CELL_HEIGHT_F, 2 * CELL_HEIGHT_F));
        }];
        
        CPLabel *titleLB = [CPLabel new];
        titleLB.text = @"身份证正面";
        titleLB.textColor = [UIColor redColor];
        titleLB.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:titleLB];
        
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IDFrontBT.mas_bottom).offset(4);
            make.left.mas_equalTo(self.IDFrontBT.mas_left);
            make.right.mas_equalTo(self.IDFrontBT.mas_right);
        }];
    }
    
    if (nil == self.IDBackBT) {
        
        self.IDBackBT = [CPPhotoUploadBT new];
        self.IDBackBT.layer.cornerRadius = 5.0f;
        self.IDBackBT.clipsToBounds = YES;
//        self.IDBackBT.backgroundColor = UIColor.redColor;
        //        [self.IDBackBT setImage:CPImage(@"header.jpg") forState:0];
        [self.IDBackBT setBackgroundImage:CPImage(@"add_pic") forState:UIControlStateNormal];
        [self.IDBackBT addTarget:self action:@selector(showImagePickVC:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.IDBackBT];
        
        [self.IDBackBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IDFrontBT.mas_top);
            make.left.mas_equalTo(self.IDFrontBT.mas_right).offset(cellSpaceOffset);
            make.size.mas_equalTo(CGSizeMake(2 * CELL_HEIGHT_F, 2 * CELL_HEIGHT_F));
        }];
        
        CPLabel *titleLB = [CPLabel new];
        titleLB.text = @"身份证背面";
        titleLB.textColor = [UIColor redColor];
        titleLB.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:titleLB];
        
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IDBackBT.mas_bottom).offset(4);
            make.left.mas_equalTo(self.IDBackBT.mas_left);
            make.right.mas_equalTo(self.IDBackBT.mas_right);
        }];
    }

    if(nil == self.nextBT){
        self.nextBT = [[CPButton alloc] initWithFrame:CGRectZero];
        [self.nextBT setTitle:@"保  存" forState:0];
        [self.nextBT addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.nextBT];
        
        [self.nextBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IDFrontBT.mas_bottom).offset(CELL_HEIGHT_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
        RAC(self.nextBT,enabled) = [RACSignal combineLatest:@[
                                                              self.accountTF.rac_textSignal,
                                                              self.codeTF.rac_textSignal,
                                                              self.passwdTF.rac_textSignal,
                                                              self.confirmTF.rac_textSignal]
                                                     reduce:^id{
                                                         return @(
                                                         self.accountTF.text.length > 0
                                                         && self.codeTF.text.length > 0
                                                         && self.passwdTF.text.length > 6
                                                         && self.confirmTF.text.length > 6
                                                         && ([self.confirmTF.text isEqualToString: self.passwdTF.text])
                                                         && self.IDFrontBT.currentImage
                                                         && self.IDBackBT.currentImage);
                                                     }];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setType:(CPAssistantActionType)type {
    _type = type;
    
    [self setupUI];
    
    if (self.type == CPAssistantActionTypeEdit) {
        self.passwdTF.enabled = NO;
        self.confirmTF.enabled = NO;
//        self.accountTF.text = @"赵倩";
//        self.codeTF.text = @"15814099232";
//        self.passwdTF.text = @"123456";
//        self.confirmTF.text = @"123456";
//        [self.IDFrontBT setImage:CPImage(@"header.jpg") forState:0];
//        [self.IDBackBT setImage:CPImage(@"header.jpg") forState:0];
    }
}

- (void)setUserid:(NSString *)userid {
    _userid = userid;
    
    [self loadData];
}

//- (void)setModel:(CPMemeberListModel *)model {
//    _model = model;
//}

#pragma mark - private method

- (void)showImagePickVC:(CPPhotoUploadBT *)sender {
    
    __weak CPAssistantEditVC *weakSelf = self;
    
    TZImagePickerController *vc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    
    [vc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        NSLog(@"------");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [sender setImage:photos.firstObject forState:UIControlStateNormal];
//            [weakSelf handleImagePickImageBlock];
//        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [sender setImage:photos.firstObject forState:UIControlStateNormal];
        });
        
        [[CPProgress Instance] showLoading:[UIApplication sharedApplication].keyWindow message:@"图片上传中"];
        
        [CPBaseModel uploadImages:photos.firstObject block:^(NSString *filePath) {
            DDLogError(@">>>>>>>>>>>>>>>>>>>>%@",filePath);
            sender.imageUrl = filePath;
            [[CPProgress Instance] hidden];
            
            self.nextBT.enabled =  self.accountTF.text.length > 0
            && self.codeTF.text.length > 0
            && self.passwdTF.text.length > 0
            && self.confirmTF.text.length > 0
            && ([self.confirmTF.text isEqualToString: self.passwdTF.text])
            && self.IDFrontBT.imageUrl.length > 0
            && self.IDBackBT.imageUrl.length > 0;
        }];
    }];
    
    
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav presentViewController:vc animated:YES completion:nil];
}

- (void)handleImagePickImageBlock {
    
    self.nextBT.enabled = self.accountTF.text.length > 0
    && self.IDBackBT.currentImage
    && self.IDFrontBT.currentImage
    && self.codeTF.text.length > 0
    && self.passwdTF.text.length > 0
    && self.confirmTF.text.length > 0
    && (self.confirmTF.text == self.accountTF.text);
}

- (void)nextAction:(UIButton *)sender {
    NSLog(@"------------------------------");
    
//    [self updateMemeberInfo];
    if (self.type == CPAssistantActionTypeEdit) {
        [self updateMemeberInfo];
    } else {
        [self addMemeberAction];
    }
}

- (void)addMemeberAction {
    
    __weak typeof(self) weakSelf = self;

    NSDictionary *params = @{
                             @"phone" : self.codeTF.text,
                             @"linkname" : self.accountTF.text,
                             @"code" : [CPUserInfoModel shareInstance].loginModel.cp_code,
                             @"idcard1url" : self.IDFrontBT.imageUrl,
                             @"idcard2url" : self.IDBackBT.imageUrl,
                             @"password" :cp_md5(self.confirmTF.text),
                             @"code" : @([CPUserInfoModel shareInstance].loginModel.ID)
                             };
    
    [CPAddMemberResultModel modelRequestWith:DOMAIN_ADDRESS@"/api/user/shopCreateDY"
                                  parameters:params
                                       block:^(CPAddMemberResultModel *result) {
                                           [weakSelf handleAction:result];
                                       } fail:^(CPError *error) {
                                           
                                       }];
}

- (void)handleAction:(CPAddMemberResultModel *)result {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateMemeberInfo {
    
    __weak typeof(self) weakSelf = self;
    
    NSDictionary *params = @{
                             @"userid" : self.userid,
                             @"linkname" : self.accountTF.text,
                             @"idcard1url" : self.IDFrontBT.imageUrl,
                             @"ophone" : self.IDBackBT.imageUrl,
                             @"idcard2url" : self.IDBackBT.imageUrl,
                             @"password" : cp_md5(self.confirmTF.text),
                             @"code" : @(self.model.ID)
                             };
    
    [CPBaseModel modelRequestWith:DOMAIN_ADDRESS@"/api/user/update4"
                       parameters:params
                            block:^(id result) {
                                [weakSelf handleUpdateActionNBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
}

- (void)handleUpdateActionNBlock:(CPBaseModel *)result {
    
}

- (void)handleButtonActionNBlock:(CPBaseModel *)result {
    
}

//- (void)setModel:(CPMemeberListModel *)model {
//    _model = model;
//
//    self.accountTF.text = _model.linkname;
//    self.codeTF.text = _model.phone;
//    self.passwdTF.text = @"缺少必要的字段";
//    self.confirmTF.text = @"缺少必要的字段";
//
//}

- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    
    [CPUserDetailInfoModel modelRequestWith:CPURL_USER_GET_USER_DETAIL_INFOMATION
                       parameters:@{@"userid" : self.userid}
                            block:^(CPUserDetailInfoModel *result) {
                                [weakSelf handleLoadDataSuccessBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
}

- (void)handleLoadDataSuccessBlock:(CPUserDetailInfoModel *)result {
    self.model = result;
    
//    [self setupUI];
    
    self.accountTF.text = result.linkname;
    self.codeTF.text =  result.phone;
    self.passwdTF.text = @"123456";
    self.confirmTF.text = @"123456";
    [self.IDBackBT sd_setImageWithURL:CPUrl(result.idcard2url) forState:0];
    [self.IDFrontBT sd_setImageWithURL:CPUrl(result.idcard1url) forState:0];
//    [self.IDFrontBT setImage:CPImage(@"header.jpg") forState:0];
//    [self.IDBackBT setImage:CPImage(@"header.jpg") forState:0];
}

@end
