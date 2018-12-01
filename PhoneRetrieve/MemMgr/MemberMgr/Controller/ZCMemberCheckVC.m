//
//  ZCMemberCheckVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/17.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCMemberCheckVC.h"
#import "ZCImageHintView.h"
#import "CPCheckBox.h"
#import "CPWebVC.h"
#import "ZCMemeberSearchVC.h"
#import "ZCAddMemberSuccessVC.h"
#import "ZCUserDetailModel.h"

@interface ZCMemberCheckVC ()

@property (nonatomic, strong) ZCUserDetailModel *model;
@property (nonatomic, strong) DLData *dlModel;

@property (nonatomic, strong) CPLabel *nameLB, *addressLB, *phoneLB;
@property (nonatomic, strong) CPLabel *bankOwnerLB, *bankNumberLB, *bankNameLB;

@property (nonatomic, strong) UIImageView *licenseIV, *IDFrontIV, *IDBackIV;
@property (nonatomic, strong) CPTextField *subMemberTF;
@property (nonatomic, strong) CPButton *actionButton;

@property (nonatomic, strong) CPCheckBox *checkBox;

@property (nonatomic, assign) BOOL agreeProtocol;


@end

@implementation ZCMemberCheckVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"会员审核";
    
    self.dataArray = @[@[@""]].mutableCopy;
    self.dataTableView.mj_header = nil;
    self.dataTableView.mj_footer = nil;
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter && getter method implement

#pragma mark - setupUI
- (void)setupUI:(UITableViewCell *)cell {
    
    CPLabel *memberTitleLB = [CPLabel new];
    memberTitleLB.text = @"会员信息";
    memberTitleLB.font = [UIFont boldSystemFontOfSize:15];
    
    [cell.contentView addSubview:memberTitleLB];
    [memberTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SPACE_OFFSET_F);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.right.mas_equalTo(SPACE_OFFSET_F);
    }];
    
    UIView *sepLine = [UIView new];
    sepLine.backgroundColor = CPBoardColor;
    
    [cell.contentView addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(memberTitleLB.mas_bottom).offset(SPACE_OFFSET_F/2);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.right.mas_equalTo(cell.contentView.mas_right).offset(200);
        make.height.mas_equalTo(.5);
    }];

    {
        self.nameLB = [CPLabel new];
        self.nameLB.text = [NSString stringWithFormat:@"会员名称:%@",self.model.linkname];
        
        [cell.contentView addSubview:self.nameLB];
        [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(memberTitleLB.mas_left).offset(SPACE_OFFSET_F);
            make.top.mas_equalTo(sepLine.mas_bottom).offset(SPACE_OFFSET_F/2);
        }];
        
        self.addressLB = [CPLabel new];
        self.addressLB.text = [NSString stringWithFormat:@"会员地址:%@",self.model.address];
        
        [cell.contentView addSubview:self.addressLB];
        [self.addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(memberTitleLB.mas_left).offset(SPACE_OFFSET_F);
            make.top.mas_equalTo(self.nameLB.mas_bottom).offset(SPACE_OFFSET_F/2);
        }];
        
        self.phoneLB = [CPLabel new];
        self.phoneLB.text = [NSString stringWithFormat:@"会员电话:%@",self.model.phone];
        
        [cell.contentView addSubview:self.phoneLB];
        [self.phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(memberTitleLB.mas_left).offset(SPACE_OFFSET_F);
            make.top.mas_equalTo(self.addressLB.mas_bottom).offset(SPACE_OFFSET_F/2);
        }];

    }
    
    CPLabel *licenseHintLB = [CPLabel new];
    licenseHintLB.text = @"营业执照";
    
    [cell.contentView addSubview:licenseHintLB];
    [licenseHintLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(memberTitleLB.mas_left).offset(SPACE_OFFSET_F);
        make.top.mas_equalTo(self.phoneLB.mas_bottom).offset(SPACE_OFFSET_F/2);
    }];
    
    {
        self.licenseIV = [UIImageView new];
        self.licenseIV.layer.cornerRadius = 5;
        self.licenseIV.layer.borderWidth = 1.0f;
        self.licenseIV.layer.borderColor = CPBoardColor.CGColor;
        self.licenseIV.image = [UIImage imageNamed:@"placeHolderImage"];
        
        if (self.model.licenseurl && self.model.licenseurl.length > 10) {
            [self.licenseIV sd_setImageWithURL:CPUrl(self.model.licenseurl) placeholderImage:nil];
        }
        
        [cell.contentView addSubview:self.licenseIV];
        [self.licenseIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(licenseHintLB.mas_bottom);
            make.left.mas_equalTo(licenseHintLB.mas_right).offset(SPACE_OFFSET_F/2);
            make.size.mas_equalTo(CGSizeMake(80, 60));
        }];
    }
    
    CPLabel *IDHintLB = [CPLabel new];
    IDHintLB.text = @"营业执照";
    
    [cell.contentView addSubview:IDHintLB];
    [IDHintLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(memberTitleLB.mas_left).offset(SPACE_OFFSET_F);
        make.top.mas_equalTo(self.licenseIV.mas_bottom).offset(SPACE_OFFSET_F/2);
    }];
    
    {
        self.IDFrontIV = [UIImageView new];
        self.IDFrontIV.layer.cornerRadius = 5;
        self.IDFrontIV.layer.borderWidth = 1.0f;
        self.IDFrontIV.layer.borderColor = CPBoardColor.CGColor;
        self.IDFrontIV.image = [UIImage imageNamed:@"placeHolderImage"];
        
        if (self.model.idcard1url && self.model.idcard1url.length > 10) {
            [self.IDFrontIV sd_setImageWithURL:CPUrl(self.model.idcard1url)];
        }
        
        
        [cell.contentView addSubview:self.IDFrontIV];
        [self.IDFrontIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(IDHintLB.mas_bottom);
            make.left.mas_equalTo(IDHintLB.mas_right).offset(SPACE_OFFSET_F/2);
            make.size.mas_equalTo(CGSizeMake(80, 60));
        }];
        
        self.IDBackIV = [UIImageView new];
        self.IDBackIV.layer.cornerRadius = 5;
        self.IDBackIV.layer.borderWidth = 1.0f;
        self.IDBackIV.layer.borderColor = CPBoardColor.CGColor;
        self.IDBackIV.image = [UIImage imageNamed:@"placeHolderImage"];
        if (self.model.idcard2url && self.model.idcard2url.length > 10) {
            [self.IDBackIV sd_setImageWithURL:CPUrl(self.model.idcard2url)];
        }
        
        [cell.contentView addSubview:self.IDBackIV];
        [self.IDBackIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(IDHintLB.mas_bottom);
            make.left.mas_equalTo(self.IDFrontIV.mas_right).offset(SPACE_OFFSET_F/2);
            make.size.mas_equalTo(CGSizeMake(80, 60));
        }];
    }
    
    CPLabel *chargeTitleLB = [CPLabel new];
    chargeTitleLB.text = @"会员信息";
    chargeTitleLB.font = [UIFont boldSystemFontOfSize:15];

    [cell.contentView addSubview:chargeTitleLB];
    [chargeTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.IDBackIV.mas_bottom).offset(SPACE_OFFSET_F * 2);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.right.mas_equalTo(SPACE_OFFSET_F);
    }];

    UIView *sepLine1 = [UIView new];
    sepLine1.backgroundColor = CPBoardColor;

    [cell.contentView addSubview:sepLine1];
    [sepLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(chargeTitleLB.mas_bottom).offset(SPACE_OFFSET_F/2);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(.5);
    }];
    
    CPLabel *bankHint = [CPLabel new];
    bankHint.text = @"银行卡";
    [cell.contentView addSubview:bankHint];
    [bankHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sepLine1.mas_bottom).offset(SPACE_OFFSET_F/2);
        make.left.mas_equalTo(chargeTitleLB.mas_left).offset(SPACE_OFFSET_F);
    }];
    
    UIView *sepLine2 = [UIView new];
    sepLine2.backgroundColor = CPBoardColor;
    
    [cell.contentView addSubview:sepLine2];
    [sepLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bankHint.mas_bottom).offset(SPACE_OFFSET_F/2);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(.5);
    }];
    
    {
        self.bankOwnerLB = [CPLabel new];
        self.bankOwnerLB.text = [NSString stringWithFormat:@"收款人名称：%@",self.model.bname];
        
        [cell.contentView addSubview:self.bankOwnerLB];
        [self.bankOwnerLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(chargeTitleLB.mas_left).offset(SPACE_OFFSET_F);
            make.top.mas_equalTo(sepLine2.mas_bottom).offset(SPACE_OFFSET_F/2);
        }];
        
        self.bankNumberLB = [CPLabel new];
        self.bankNumberLB.text = [NSString stringWithFormat:@"银行卡号：%@",self.model.banknum];
        
        [cell.contentView addSubview:self.bankNumberLB];
        [self.bankNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bankOwnerLB.mas_left);
            make.top.mas_equalTo(self.bankOwnerLB.mas_bottom).offset(SPACE_OFFSET_F/2);
        }];
        
        self.bankNameLB = [CPLabel new];
        self.bankNameLB.text = [NSString stringWithFormat:@"银行名称：%@",self.model.oldbankinfo.bankname];
        
        [cell.contentView addSubview:self.bankNameLB];
        [self.bankNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bankOwnerLB.mas_left);
            make.top.mas_equalTo(self.bankNumberLB.mas_bottom).offset(SPACE_OFFSET_F/2);
        }];
        
        
        CPButton *allotBT = [CPButton new];
        
        [cell.contentView addSubview:allotBT];
        [allotBT addTarget:self action:@selector(alloctAction:) forControlEvents:64];
        [allotBT setTitle:@"分配" forState:0];
        [allotBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bankNameLB.mas_bottom).offset(2 * SPACE_OFFSET_F);
            make.left.mas_equalTo(self.bankOwnerLB.mas_left);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(50);
        }];
        
        
        self.subMemberTF = [CPTextField new];
        self.subMemberTF.placeholder = @"子会员";
        
        [cell.contentView addSubview:self.subMemberTF];
        [self.subMemberTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(allotBT.mas_centerY);
            make.left.mas_equalTo(allotBT.mas_right).offset(SPACE_OFFSET_F/2);
            make.right.mas_equalTo(-SPACE_OFFSET_F);
            make.height.mas_equalTo(30);
        }];

    }
    
    
    {
        
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
//            [weakSelf getConfigUrl:@"200" block:^(NSString *url, NSString *title) {
                CPWebVC *webVC = [[CPWebVC alloc] init];
                        webVC.urlStr = @"https://www.baidu.com";
//                webVC.contentStr = url;
//                webVC.title = title;
                webVC.hidesBottomBarWhenPushed = YES;
                
                [weakSelf.navigationController pushViewController:webVC animated:YES];
//            }];
        };
        
        [cell.contentView addSubview:self.checkBox];

        [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.subMemberTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(20);
        }];
    }
    
    {
        self.actionButton = [CPButton new];
        
        [cell.contentView addSubview:self.actionButton];
        [self.actionButton setTitle:@"审核通过" forState:0];
        [self.actionButton addTarget:self action:@selector(checkPassActino:) forControlEvents:64];
        [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.checkBox.mas_bottom).offset(2 * SPACE_OFFSET_F);
            make.left.mas_equalTo(SPACE_OFFSET_F);
            make.right.mas_equalTo(-SPACE_OFFSET_F);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
        RAC(self.actionButton,enabled) = [RACSignal combineLatest:@[self.subMemberTF.rac_textSignal]
                                                           reduce:^id{
                                                               return @(
                                                               self.subMemberTF.text.length > 0 &&
                                                               self.agreeProtocol == YES
                                                               );
                                                           }];
    }

}
#pragma mark - delete method implement
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return 1;}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {return 680;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"CellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self setupUI:cell];

    return cell;
}

#pragma mark - private method

- (void)handleAgreeProtocolBlock:(NSInteger )agrree {
    self.agreeProtocol = agrree;
    
    self.actionButton.enabled = (
                                 self.subMemberTF.text.length > 0 &&
                                 self.agreeProtocol == YES
    );
}

- (void)alloctAction:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    
    ZCMemeberSearchVC *vc = [ZCMemeberSearchVC new];
    vc.selectModel = ^(DLData *model) {
        [weakSelf handleAllocActionBlock:model];
    };

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleAllocActionBlock:(DLData *)model {
    self.subMemberTF.text = model.linkname;
    self.dlModel = model;
    
    self.actionButton.enabled = (
                                 self.subMemberTF.text.length > 0 &&
                                 self.agreeProtocol == YES
                                 );
}

- (void)loadData {
    NSDictionary *params = @{
                             //                             @"userid" : USER_ID
                             @"userid" : @(self.userID)
                             };
    
    __weak typeof(self) weakSelf = self;
    
    [ZCUserDetailModel modelRequestWith:DOMAIN_ADDRESS@"/api/user/getUserModelDetail"
                             parameters:params
                                  block:^(id  _Nonnull result) {
                                      [weakSelf handleLoadDataSuccussBlock:result];
                                  } fail:^(CPError * _Nonnull error) {
                                      
                                  }];
}

- (void)handleLoadDataSuccussBlock:(ZCUserDetailModel *)result {
    self.model = result;
    [self.dataTableView reloadData];
}

- (void)checkPassAction:(id)sender {
    
    NSMutableDictionary *params = @{
                             @"userid" : USER_ID,
                             @"operatorid" : @(self.model.ID)
                             }.mutableCopy;
    if (self.model.typeid == 9) {
        [params setObject:@(self.model.ID) forKey:@"belonguserid"];
    } else if (self.model.typeid == 8) {
        [params setObject:@(self.dlModel.ID) forKey:@"belonguserid"];
    }

    __weak typeof(self) weakSelf = self;
    
    [ZCBaseModel modelRequestWith:DOMAIN_ADDRESS@"/api/user/updateUserCheckcfg"
                       parameters:params
                            block:^(id  _Nonnull result) {
                                [weakSelf.view makeToast:@"深圳成功" duration:2.0f position:CSToastPositionCenter];
                            } fail:^(CPError * _Nonnull error) {
                                
                            }];
}


@end
