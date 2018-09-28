//
//  CPShopRegistInfoTBVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopRegistInfoTBVC.h"
#import "CPRegistStepView.h"
#import <TZImagePickerController.h>
#import "CPPhotoUploadBT.h"
#import "CPProviceCityAreaModel.h"

@interface CPShopRegistInfoTBVC ()<CPSelectTextFieldDelegat>

@property (nonatomic, strong) CPTextField *shopCodeTF, *shopNameTF, *shopAddressTF, *shopOwnerTF, *shopPhoneTF, *shopEmailT;
@property (nonatomic, strong) CPSelectTextField *proviceTF, *cityTF, *areaTF;

@property (nonatomic, strong) CPPhotoUploadBT *businessLicenseBT, *IDFrontBT, *IDBackBT;

@property (nonatomic,strong) CPButton *nextAction;

@property (nonatomic, strong) NSArray  *proviceArray, *cityArray, *areaArray;
@property (nonatomic, strong) CPProviceCityAreaModel *cityModel, *proviceModel, *areaModel;

@end

@implementation CPShopRegistInfoTBVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = @[@[@""]];
    
    self.dataTableView.backgroundColor = UIColor.whiteColor;
    
//    [self loadData];
    self.navigationItem.rightBarButtonItem = nil;
    [self loadProvice];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 790.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"CellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    CPRegistStepView *stepView = [[CPRegistStepView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44.0f)];
    stepView.currentStep = 1;
    
    [cell.contentView addSubview:stepView];
    
    if (nil == self.shopCodeTF) {
        self.shopCodeTF = [CPTextField new];
        self.shopCodeTF.font = [UIFont systemFontOfSize:13.0f];
        self.shopCodeTF.placeholder = @"商家编码";
        self.shopCodeTF.borderStyle = UITextBorderStyleRoundedRect;
//        self.shopCodeTF.keyboardType = UIKeyboardTypeNumberPad;
        
        [cell.contentView addSubview:self.shopCodeTF];
        
        [self.shopCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(stepView.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    if (nil == self.shopNameTF) {
        self.shopNameTF = [CPTextField new];
        self.shopNameTF.font = [UIFont systemFontOfSize:13.0f];
        self.shopNameTF.placeholder = @"门店名称";
        self.shopNameTF.borderStyle = UITextBorderStyleRoundedRect;
//        self.shopNameTF.keyboardType = UIKeyboardTypeNumberPad;
        
        [cell.contentView addSubview:self.shopNameTF];
        
        [self.shopNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.shopCodeTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
    }
    
    CGFloat width = (SCREENWIDTH - 4 * cellSpaceOffset) / 3;
    
    if (nil == self.proviceTF) {
        
        self.proviceTF = [[CPSelectTextField alloc] initWithFrame:CGRectMake(0, 0, width, CELL_HEIGHT_F)];
        self.proviceTF.placeholder = @"选择省";
        self.proviceTF.cp_editDelegate = self;
        self.proviceTF.type = 0;
//        self.proviceTF.dataArray = @[@"1111",@"222",@"333"];

        [cell.contentView addSubview:self.proviceTF];
        
        [self.proviceTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.shopNameTF.mas_bottom).offset(cellSpaceOffset);
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
            make.top.mas_equalTo(self.shopNameTF.mas_bottom).offset(cellSpaceOffset);
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
            make.top.mas_equalTo(self.shopNameTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(self.cityTF.mas_right).offset(cellSpaceOffset);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    if (nil == self.shopAddressTF) {
        self.shopAddressTF = [CPTextField new];
        self.shopAddressTF.font = [UIFont systemFontOfSize:13.0f];
        self.shopAddressTF.placeholder = @"门店详细地址";
        self.shopAddressTF.borderStyle = UITextBorderStyleRoundedRect;
//        self.shopAddressTF.keyboardType = UIKeyboardTypeNumberPad;
        
        [cell.contentView addSubview:self.shopAddressTF];
        
        [self.shopAddressTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.proviceTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
    }
    
    if (nil == self.shopOwnerTF) {
        self.shopOwnerTF = [CPTextField new];
        self.shopOwnerTF.font = [UIFont systemFontOfSize:13.0f];
        self.shopOwnerTF.placeholder = @"门店负责人";
        self.shopOwnerTF.borderStyle = UITextBorderStyleRoundedRect;
//        self.shopOwnerTF.keyboardType = UIKeyboardTypeNumberPad;
        
        [cell.contentView addSubview:self.shopOwnerTF];
        
        [self.shopOwnerTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.shopAddressTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
    }
    
    if (nil == self.shopPhoneTF) {
        self.shopPhoneTF = [CPTextField new];
        self.shopPhoneTF.font = [UIFont systemFontOfSize:13.0f];
        self.shopPhoneTF.placeholder = @"负责人联系方式";
        self.shopPhoneTF.borderStyle = UITextBorderStyleRoundedRect;
        self.shopPhoneTF.keyboardType = UIKeyboardTypeNumberPad;
        
        [cell.contentView addSubview:self.shopPhoneTF];
        
        [self.shopPhoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.shopOwnerTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    if (nil == self.shopEmailT) {
        self.shopEmailT = [CPTextField new];
        self.shopEmailT.font = [UIFont systemFontOfSize:13.0f];
        self.shopEmailT.placeholder = @"邮箱";
        self.shopEmailT.borderStyle = UITextBorderStyleRoundedRect;
//        self.shopEmailT.keyboardType = UIKeyboardTypeNumberPad;
        
        [cell.contentView addSubview:self.shopEmailT];
        
        [self.shopEmailT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.shopPhoneTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    if (nil == self.businessLicenseBT) {
        
        self.businessLicenseBT = [CPPhotoUploadBT new];
//        self.businessLicenseBT.backgroundColor = UIColor.redColor;
//        [self.businessLicenseBT setImage:CPImage(@"header.jpg") forState:0];
        [self.businessLicenseBT setBackgroundImage:CPImage(@"add_pic") forState:UIControlStateNormal];
        [self.businessLicenseBT addTarget:self action:@selector(showImagePickVC:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:self.businessLicenseBT];
        
        [self.businessLicenseBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.shopEmailT.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.size.mas_equalTo(CGSizeMake(2 * CELL_HEIGHT_F, 2 * CELL_HEIGHT_F));
        }];
        
    }
    
    
    CPLabel *licenseTitleLB = [CPLabel new];
    licenseTitleLB.text = @"营业执照";
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
        titleLB.text = @"身份证正面";
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
        titleLB.text = @"身份证背面";
        titleLB.textAlignment = NSTextAlignmentCenter;
        titleLB.textColor = [UIColor redColor];
        
        [cell.contentView addSubview:titleLB];
        
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IDBackBT.mas_bottom).offset(4);
            make.left.mas_equalTo(self.IDBackBT.mas_left);
            make.right.mas_equalTo(self.IDBackBT.mas_right);
        }];
    }
    
    if (nil == self.nextAction) {
        
        self.nextAction = [[CPButton alloc] initWithFrame:CGRectZero];
        [self.nextAction setTitle:@"下一步" forState:0];
        [self.nextAction addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:self.nextAction];
        
        [self.nextAction mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IDBackBT.mas_bottom).mas_equalTo(CELL_HEIGHT_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
        RAC(self.nextAction,enabled) = [RACSignal combineLatest:@[
                                                                  self.shopCodeTF.rac_textSignal,
                                                                  self.shopNameTF.rac_textSignal,
                                                                  self.proviceTF.rac_textSignal,
                                                                  self.cityTF.rac_textSignal,
                                                                  self.areaTF.rac_textSignal,
                                                                  self.shopAddressTF.rac_textSignal,
                                                                  self.shopOwnerTF.rac_textSignal,
                                                                  self.shopPhoneTF.rac_textSignal,
                                                                  self.shopEmailT.rac_textSignal
                                                                  ] reduce:^id{
                                                                      return @(self.shopCodeTF.text.length > 0 &&
                                                                      self.shopNameTF.text.length > 0 &&
                                                                      self.proviceTF.text.length > 0 &&
                                                                      self.cityTF.text.length > 0 &&
                                                                      self.cityTF.text.length > 0 &&
                                                                      self.areaTF.text.length > 0 &&
                                                                      self.shopAddressTF.text.length > 0 &&
                                                                      self.shopOwnerTF.text.length > 0 &&
                                                                      self.shopPhoneTF.text.length > 0 &&
                                                                      self.shopEmailT.text.length > 0 &&
                                                                      self.businessLicenseBT.currentImage &&
                                                                      self.IDFrontBT.currentImage && self.IDBackBT.currentImage);
                                                                  }];
        
    }

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}


- (void)cp_textFieldDidBeginEditing:(UITextField *)textField model:(CPProviceCityAreaModel *)model {
    if (textField == self.proviceTF) {
        
    }
}

- (void)cp_textFieldDidEndEditing:(UITextField *)textField model:(CPProviceCityAreaModel *)model{
    
    if (model == nil) {
        return;
    }
    
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

#pragma mark - private method

- (void)showImagePickVC:(CPPhotoUploadBT *)sender {
    
    __weak CPShopRegistInfoTBVC *weakSelf = self;
    
    TZImagePickerController *vc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    
    [vc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        NSLog(@"------");
        dispatch_async(dispatch_get_main_queue(), ^{
            [sender setImage:photos.firstObject forState:UIControlStateNormal];
            
            [[CPProgress Instance] showLoading:self.view message:@"图片上传中"];
            
            [CPBaseModel uploadImages:photos.firstObject block:^(NSString *filePath) {
                DDLogError(@">>>>>>>>>>>>>>>>>>>>%@",filePath);
                sender.imageUrl = filePath;
                [[CPProgress Instance] hidden];
            }];

            [weakSelf handleImagePickImageBlock];
        });
    }];
    
    
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav presentViewController:vc animated:YES completion:nil];
}

- (void)handleImagePickImageBlock {
    
    self.nextAction.enabled = (self.shopCodeTF.text.length > 0
                               && self.shopNameTF.text.length > 0
                               && self.proviceTF.text.length > 0
                               && self.cityTF.text.length > 0
                               && self.cityTF.text.length > 0
                               && self.areaTF.text.length > 0
                               && self.shopAddressTF.text.length > 0
                               && self.shopOwnerTF.text.length > 0
                               && self.shopEmailT.text.length > 0
                               && self.shopPhoneTF.text.length > 0
                               && self.businessLicenseBT.currentImage
                               && self.IDFrontBT.currentImage
                               && self.IDBackBT.currentImage);
}

- (void)nextAction:(UIButton *)sender {
    
    [CPRegistParam shareInstance].code = self.shopCodeTF.text;
    [CPRegistParam shareInstance].companyname = self.shopNameTF.text;
    [CPRegistParam shareInstance].provinceid = self.proviceModel.Code;
    [CPRegistParam shareInstance].cityid = self.cityModel.Code;
    [CPRegistParam shareInstance].districtid = self.areaModel.Code;
    [CPRegistParam shareInstance].address = self.shopAddressTF.text;
    [CPRegistParam shareInstance].linkname = self.shopOwnerTF.text;
    [CPRegistParam shareInstance].email = self.shopEmailT.text;
    [CPRegistParam shareInstance].licenseurl = self.businessLicenseBT.imageUrl;
    [CPRegistParam shareInstance].idcard1url = self.IDFrontBT.imageUrl;
    [CPRegistParam shareInstance].idcard2url= self.IDBackBT.imageUrl;

    [self push2VCWith:@"CPRemittanceInfoTBVC" title:@"门店注册"];
}

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
    
    self.proviceArray = result;
    
    self.proviceTF.dataArray = self.proviceArray;
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
    
    self.cityArray = result;
    
    self.cityTF.dataArray = self.cityArray;
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
    
    self.areaArray = result;
    
    self.areaTF.dataArray = self.areaArray;
}


@end
