//
//  CPMemberRegisterStep01VC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemberRegisterStep01VC.h"
#import "CPRegistStepView.h"
#import "CPSelectTextField.h"
#import "CPPhotoUploadBT.h"
#import "TZImagePickerController.h"
#import "CPCheckBox.h"
#import "CPWebVC.h"
#import "ZCAddMemberSuccessVC.h"
#import "ZCMemeberSearchVC.h"
#import "ZCSearchDelegateListModel.h"
#import "ZCAddMemeberResultModel.h"

@interface CPMemberRegisterStep01VC ()<CPSelectTextFieldDelegat>

@property (nonatomic, strong) CPSelectTextField *proviceTF, *cityTF, *areaTF;
@property (nonatomic, strong) CPProviceCityAreaModel *cityModel, *proviceModel, *areaModel;
@property (nonatomic, strong) CPTextField *memeberNameTF,*memeberPhoneTF,*addressTF;

@property (nonatomic, strong) CPPhotoUploadBT *businessLicenseBT, *IDFrontBT, *IDBackBT;
@property (nonatomic, strong) CPTextField *bankAccontNameTF, *bankAccountTF,*bankSelecteTF;

@property (nonatomic,strong) CPButton *nextAction;

@property (nonatomic,strong) CPTextField *subDelegateTF;

@property (nonatomic, strong) CPCheckBox *checkBox;

@property (nonatomic, assign) BOOL agreeProtocol;

@property (nonatomic, strong) DLData *subDelegateModel;

@end

@implementation CPMemberRegisterStep01VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataTableView.backgroundColor = UIColor.whiteColor;
    
    self.navigationItem.rightBarButtonItem = nil;
    
    [self setTitle:@"会员新增"];
    
    [self loadProvice];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {return 1;};
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {return 1;};
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {return 940;};
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {return 0.00000001;};
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {return 0.00000001;}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {return nil;};
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {return nil;};

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"CellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [self setupUIWithCell:cell];
    
    return cell;
}

#pragma mark - setup view
- (void)setupUIWithCell:(UITableViewCell *)cell {
   // 注册进度视图
    //  省市区选择
    CGFloat width = (SCREENWIDTH - 4 * cellSpaceOffset) / 3;
    
    if (nil == self.memeberNameTF) {
        self.memeberNameTF = [CPTextField new];
        self.memeberNameTF.placeholder = @"会员名称";
        
        [cell.contentView addSubview:self.memeberNameTF];
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

        [cell.contentView addSubview:self.memeberPhoneTF];
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
        
        [cell.contentView addSubview:self.proviceTF];
        
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
        
        [cell.contentView addSubview:self.cityTF];
        
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
        
        [cell.contentView addSubview:self.areaTF];
        
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
        
        [cell.contentView addSubview:self.addressTF];
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
        
        [cell.contentView addSubview:self.businessLicenseBT];
        
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
    
    [cell.contentView addSubview:licenseTitleLB];
    
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
        
        [cell.contentView addSubview:self.IDFrontBT];
        
        [self.IDFrontBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(licenseTitleLB.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.size.mas_equalTo(CGSizeMake(2 * CELL_HEIGHT_F, 2 * CELL_HEIGHT_F));
        }];
        
        CPLabel *titleLB = [CPLabel new];
        titleLB.text = @"身份证正面（必填）";
        titleLB.textAlignment = NSTextAlignmentCenter;
        titleLB.textColor = [UIColor redColor];
        
        [cell.contentView addSubview:titleLB];
        
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
        
        [cell.contentView addSubview:self.IDBackBT];
        
        [self.IDBackBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(licenseTitleLB.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(self.IDFrontBT.mas_right).offset(cellSpaceOffset);
            make.size.mas_equalTo(CGSizeMake(2 * CELL_HEIGHT_F, 2 * CELL_HEIGHT_F));
        }];
        
        CPLabel *titleLB = [CPLabel new];
        titleLB.text = @"身份证背面(必填)";
        titleLB.textAlignment = NSTextAlignmentCenter;
        titleLB.textColor = [UIColor redColor];
        
        [cell.contentView addSubview:titleLB];
        
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IDBackBT.mas_bottom).offset(4);
            make.left.mas_equalTo(self.IDBackBT.mas_left);
            make.right.mas_equalTo(self.IDBackBT.mas_right);
        }];
    }
    
    //  账号信息相关
    {
        CPLabel *headerLB = [CPLabel new];
        headerLB.text = @"银行信息";
        [cell.contentView addSubview:headerLB];
        [headerLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IDBackBT.mas_bottom).offset(60);
            make.left.mas_equalTo(cellSpaceOffset);
        }];
        
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;
        
        [cell.contentView addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(headerLB.mas_bottom).offset(4);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(.5);
        }];
        
        if (nil == self.bankAccontNameTF) {
            self.bankAccontNameTF = [CPTextField new];
            self.bankAccontNameTF.placeholder = @"收款人名称";
            [cell.contentView addSubview:self.bankAccontNameTF];
            [self.bankAccontNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(sepLine.mas_bottom).offset(cellSpaceOffset);
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
        }
        
        if (nil == self.bankSelecteTF) {
            self.bankSelecteTF = [[CPTextField alloc] initWithFrame:CGRectMake(cellSpaceOffset, 0, SCREENWIDTH - 2 * cellSpaceOffset, CELL_HEIGHT_F)];
            self.bankSelecteTF.placeholder = @"银行名称";
            
            [cell.contentView addSubview:self.bankSelecteTF];
            [self.bankSelecteTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.bankAccontNameTF.mas_bottom).offset(cellSpaceOffset);
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
        }

        if (nil == self.bankAccountTF) {
            self.bankAccountTF = [CPTextField new];
            self.bankAccountTF.placeholder = @"银行账号";
            [cell.contentView addSubview:self.bankAccountTF];
            [self.bankAccountTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.bankSelecteTF.mas_bottom).offset(cellSpaceOffset);
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
        }
        
        
//        CPLabel *allotBT = [CPLabel new];
//        allotBT.text = @"分配";
//        allotBT.textAlignment = NSTextAlignmentCenter;
//        [cell.contentView addSubview:allotBT];
//        [allotBT mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.bankAccountTF.mas_bottom).offset(SPACE_OFFSET_F);
//            make.left.mas_equalTo(SPACE_OFFSET_F);
////            make.right.mas_equalTo(-SPACE_OFFSET_F);
//            make.width.mas_equalTo(30);
//            make.height.mas_equalTo(CELL_HEIGHT_F);
//        }];
        
        CPButton *allotBT = [CPButton new];

        [cell.contentView addSubview:allotBT];
        [allotBT addTarget:self action:@selector(alloctAction:) forControlEvents:64];
        [allotBT setTitle:@"分配" forState:0];
        [allotBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bankAccountTF.mas_bottom).offset(SPACE_OFFSET_F);
            make.left.mas_equalTo(SPACE_OFFSET_F);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
        if (nil == self.subDelegateTF) {
            self.subDelegateTF = [CPTextField new];
            self.subDelegateTF.placeholder = @"子代理";
            
            [cell.contentView addSubview:self.subDelegateTF];
            [self.subDelegateTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(allotBT.mas_top);
                make.left.mas_equalTo(allotBT.mas_right).offset(SPACE_OFFSET_F/2);
                make.right.mas_equalTo(-SPACE_OFFSET_F);
                make.height.mas_equalTo(CELL_HEIGHT_F);
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
            
            [cell.contentView addSubview:self.checkBox];
            
            [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.subDelegateTF.mas_bottom).offset(cellSpaceOffset);
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.height.mas_equalTo(20);
            }];
        }

    }
    
    //  提交按钮
    {
        if (nil == self.nextAction) {
            self.nextAction = [CPButton new];
            [cell.contentView addSubview:self.nextAction];
            [self.nextAction setTitle:@"提交注册信息" forState:0];
            [self.nextAction addTarget:self action:@selector(nextAction:) forControlEvents:64];
            [self.nextAction mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.checkBox.mas_bottom).offset(CELL_HEIGHT_F);
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
            
#if 0
            RAC(self.nextAction,enabled) = [RACSignal combineLatest:@[
                                                                      self.memeberNameTF.rac_textSignal,
                                                                      self.memeberPhoneTF.rac_textSignal,
                                                                      self.proviceTF.rac_textSignal,
                                                                      self.cityTF.rac_textSignal,
                                                                      self.areaTF.rac_textSignal,
                                                                      self.addressTF.rac_textSignal,
                                                                      self.bankAccontNameTF.rac_textSignal,
                                                                      self.bankSelecteTF.rac_textSignal,
                                                                      self.bankAccountTF.rac_textSignal,
                                                                      ]
                                                             reduce:^id{
                                                                 return @(
                                                                 self.memeberNameTF.text.length > 0 &&
                                                                 self.memeberPhoneTF.text.length > 0 &&
                                                                 self.proviceTF.text.length > 0 &&
                                                                 self.cityTF.text.length > 0 &&
                                                                 self.areaTF.text.length > 0 &&
                                                                 self.addressTF.text.length > 0 &&
//                                                                 self.bankBranchTF.text.length > 0 &&
                                                                 self.bankAccontNameTF.text.length > 0 &&
                                                                 self.bankSelecteTF.text.length > 0 &&
                                                                 self.bankAccountTF.text.length > 0 &&
                                                                 self.IDFrontBT.imageUrl.length > 0 &&
                                                                 self.IDBackBT.imageUrl.length > 0 &&
                                                                 self.agreeProtocol == YES
                                                                 );
                                                             }];
#endif
        }
    }
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
    } else if (textField == self.bankSelecteTF) {
//        textField.text = @"00000";
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

#pragma mark - private method

- (void)showImagePickVC:(CPPhotoUploadBT *)sender {
    
    __weak CPMemberRegisterStep01VC *weakSelf = self;
    
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
                               self.proviceTF.text.length > 0 &&
                               self.cityTF.text.length > 0 &&
                               self.areaTF.text.length > 0 &&
                               self.addressTF.text.length > 0 &&
                               self.bankAccontNameTF.text.length > 0 &&
                               self.bankSelecteTF.text.length > 0 &&
                               self.bankAccountTF.text.length > 0 &&
                               self.IDFrontBT.imageUrl.length > 0 &&
                               self.IDBackBT.imageUrl.length > 0 &&
                               self.agreeProtocol == YES
                               );
}

//-(void)nextAction:(id)sender {
//
//    ZCAddMemberSuccessVC *vc = [ZCAddMemberSuccessVC new];
//    [self.navigationController pushViewController:vc animated:YES];
//
//    NSMutableDictionary *params = @{
//                                   @"phone" : [CPRegistParam shareInstance].phone,
//                                   @"sms" : [CPRegistParam shareInstance].sms,
//                                   @"password" : [CPRegistParam shareInstance].password,
//                                   @"provinceid" : self.proviceModel.Code,
//                                   @"cityid" : self.cityModel.Code,
//                                   @"districtid" : self.areaModel.Code,
//                                   @"address" : self.addressTF.text,
//                                   @"idcard1url" : self.IDFrontBT.imageUrl,
//                                   @"idcard2url" : self.IDBackBT.imageUrl,
//                                   @"bankname" : self.bankSelecteTF.text,
//                                   @"banknum" : self.bankAccountTF.text,
//                                   @"bname" : self.bankAccontNameTF.text
//                                   }.mutableCopy;
//
//    //  可选的营业执照
//    if (self.businessLicenseBT.imageUrl.length > 0) {
//        [params setObject:self.businessLicenseBT.imageUrl forKey:@"licenseurl"];
//    }
//
//
//    __weak typeof(self) weakSelf = self;
//
//    [CPBaseModel modelRequestWith:DOMAIN_ADDRESS@"/api/user/register6"
//                       parameters:params
//                            block:^(id result) {
//                                [weakSelf handleRegistActionBlock:result];
//                            } fail:^(CPError *error) {
//
//                            }];
//}

- (void)handleRegistActionBlock:(id)result {
    [self.view makeToast:@"注册已完成，请静待审核！！！" duration:2.0f position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
        
        [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([NSStringFromClass(obj.class) isEqualToString:@"CPLoginVC"]) {
                [self.navigationController popToViewController:obj animated:YES];
                *stop = YES;
            }
        }];
        
    }];
}

- (void)handleAgreeProtocolBlock:(NSInteger )agrree {
    self.agreeProtocol = agrree;
    
    self.nextAction.enabled = (
                               self.memeberNameTF.text.length > 0 &&
                               self.memeberPhoneTF.text.length > 0 &&
                               self.proviceTF.text.length > 0 &&
                               self.cityTF.text.length > 0 &&
                               self.areaTF.text.length > 0 &&
                               self.addressTF.text.length > 0 &&
                               self.bankAccontNameTF.text.length > 0 &&
                               self.bankSelecteTF.text.length > 0 &&
                               self.bankAccountTF.text.length > 0 &&
                               self.IDFrontBT.imageUrl.length > 0 &&
                               self.IDBackBT.imageUrl.length > 0 &&
                               self.agreeProtocol == YES
                               );
}


-(void)nextAction:(id)sender {
    DDLogInfo(@"%s",__FUNCTION__);
    NSMutableDictionary *params = @{
                                    @"currentuserid" : @([CPUserInfoModel shareInstance].userDetaiInfoModel.ID),
                                    @"linkname" : self.memeberNameTF.text,
                                    @"phone" : self.memeberPhoneTF.text,
                                    @"provinceid" : self.proviceModel.Code,
                                    @"cityid" : self.cityModel.Code,
                                    @"districtid" : self.areaModel.Code,
                                    @"address" : self.addressTF.text,
                                    @"idcard1url" : self.IDFrontBT.imageUrl,
                                    @"idcard2url" : self.IDBackBT.imageUrl,
                                    @"bname" : self.bankAccontNameTF.text,
                                    @"bankname" : self.bankSelecteTF.text,
                                    @"banknum" : self.bankAccountTF.text,
                                    @"belonguserid" : @(self.subDelegateModel.ID),
                                    }.mutableCopy;
    if (self.businessLicenseBT.imageUrl) {
        [params setObject:self.businessLicenseBT.imageUrl forKey:@"licenseurl"];
    }
    
    __weak typeof(self) weakSelf = self;
    
    [ZCAddMemeberResultModel modelRequestWith:DOMAIN_ADDRESS@"/api/user/createHY"
                       parameters:params
                            block:^(ZCAddMemeberResultModel *result) {
                                [weakSelf handldNextActionSuccessBlock:result];
                            } fail:^(CPError * _Nonnull error) {
                                
                            }];
}

- (void)handldNextActionSuccessBlock:(ZCAddMemeberResultModel *)result {
    
    ZCAddMemberSuccessVC *vc = [ZCAddMemberSuccessVC new];
    vc.model = result;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)alloctAction:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    
    ZCMemeberSearchVC *vc = [ZCMemeberSearchVC new];
    vc.selectModel = ^(DLData *model) {
        [weakSelf handleAllocActionBlock:model];
    };

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleAllocActionBlock:(DLData *)result {
    self.subDelegateModel = result;
    self.subDelegateTF.text = result.linkname ? result.linkname : result.companyname;
}

@end
