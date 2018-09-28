//
//  ZCUnlockMemberVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/18.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCUnlockMemberVC.h"
#import "CPCheckBox.h"
#import "CPWebVC.h"
#import "ZCMemeberSearchVC.h"

@interface ZCUnlockMemberVC ()

@property (nonatomic, strong) CPLabel *nameLB, *addressLB, *phoneLB;
@property (nonatomic, strong) CPLabel *bankOwnerLB, *bankNumberLB, *bankNameLB;
@property (nonatomic, strong) CPLabel *oldBankOwnerLB, *oldBankNumberLB, *oldBankNameLB;

@property (nonatomic, strong) UIImageView *licenseIV, *IDFrontIV, *IDBackIV;
@property (nonatomic, strong) CPButton *actionButton;

@property (nonatomic, strong) CPCheckBox *checkBox;

@property (nonatomic, assign) BOOL agreeProtocol;

@end

@implementation ZCUnlockMemberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"会员解冻";
    
    self.dataArray = @[@[@" "]].mutableCopy;
    
    self.dataTableView.mj_header = nil;
    self.dataTableView.mj_footer = nil;
    
    [self loadData];
}

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
        self.nameLB.text = @"会员名称:船长";
        
        [cell.contentView addSubview:self.nameLB];
        [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(memberTitleLB.mas_left).offset(SPACE_OFFSET_F);
            make.top.mas_equalTo(sepLine.mas_bottom).offset(SPACE_OFFSET_F/2);
        }];
        
        self.addressLB = [CPLabel new];
        self.addressLB.text = @"会员地址:船长街道办";
        
        [cell.contentView addSubview:self.addressLB];
        [self.addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(memberTitleLB.mas_left).offset(SPACE_OFFSET_F);
            make.top.mas_equalTo(self.nameLB.mas_bottom).offset(SPACE_OFFSET_F/2);
        }];
        
        self.phoneLB = [CPLabel new];
        self.phoneLB.text = @"会员电话:15814099327";
        
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
        self.bankOwnerLB.text = @"收款人名称：xxxxx";
        
        [cell.contentView addSubview:self.bankOwnerLB];
        [self.bankOwnerLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(chargeTitleLB.mas_left).offset(SPACE_OFFSET_F);
            make.top.mas_equalTo(sepLine2.mas_bottom).offset(SPACE_OFFSET_F/2);
        }];
        
        self.bankNumberLB = [CPLabel new];
        self.bankNumberLB.text = @"银行卡号：xxxxx";
        
        [cell.contentView addSubview:self.bankNumberLB];
        [self.bankNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bankOwnerLB.mas_left);
            make.top.mas_equalTo(self.bankOwnerLB.mas_bottom).offset(SPACE_OFFSET_F/2);
        }];
        
        self.bankNameLB = [CPLabel new];
        self.bankNameLB.text = @"银行名称：xxxxx";
        
        [cell.contentView addSubview:self.bankNameLB];
        [self.bankNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bankOwnerLB.mas_left);
            make.top.mas_equalTo(self.bankNumberLB.mas_bottom).offset(SPACE_OFFSET_F/2);
        }];
        
        
        CPLabel *oldbankHint = [CPLabel new];
        oldbankHint.text = @"旧银行卡";
        [cell.contentView addSubview:oldbankHint];
        [oldbankHint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bankNameLB.mas_bottom).offset(SPACE_OFFSET_F/2);
            make.left.mas_equalTo(chargeTitleLB.mas_left).offset(SPACE_OFFSET_F);
        }];
        
        UIView *sepLine3 = [UIView new];
        sepLine3.backgroundColor = CPBoardColor;
        
        [cell.contentView addSubview:sepLine3];
        [sepLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(oldbankHint.mas_bottom).offset(SPACE_OFFSET_F/2);
            make.left.mas_equalTo(SPACE_OFFSET_F);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(.5);
        }];
        
        
        self.oldBankOwnerLB = [CPLabel new];
        self.oldBankOwnerLB.text = @"收款人名称：xxxxx";
        
        [cell.contentView addSubview:self.oldBankOwnerLB];
        [self.oldBankOwnerLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(chargeTitleLB.mas_left).offset(SPACE_OFFSET_F);
            make.top.mas_equalTo(sepLine3.mas_bottom).offset(SPACE_OFFSET_F/2);
        }];
        
        self.oldBankNumberLB = [CPLabel new];
        self.oldBankNumberLB.text = @"银行卡号：xxxxx";
        
        [cell.contentView addSubview:self.oldBankNumberLB];
        [self.oldBankNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.oldBankOwnerLB.mas_left);
            make.top.mas_equalTo(self.oldBankOwnerLB.mas_bottom).offset(SPACE_OFFSET_F/2);
        }];
        
        self.oldBankNameLB = [CPLabel new];
        self.oldBankNameLB.text = @"银行名称：xxxxx";
        
        [cell.contentView addSubview:self.oldBankNameLB];
        [self.oldBankNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.oldBankOwnerLB.mas_left);
            make.top.mas_equalTo(self.oldBankNumberLB.mas_bottom).offset(SPACE_OFFSET_F/2);
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
            make.top.mas_equalTo(self.oldBankNameLB.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(20);
        }];
    }
    
    {
        self.actionButton = [CPButton new];
        
        [cell.contentView addSubview:self.actionButton];
        [self.actionButton setTitle:@"审核通过" forState:0];
        [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.checkBox.mas_bottom).offset(2 * SPACE_OFFSET_F);
            make.left.mas_equalTo(SPACE_OFFSET_F);
            make.right.mas_equalTo(-SPACE_OFFSET_F);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
        self.actionButton.enabled = self.agreeProtocol;
    }
    
}
#pragma mark - delete method implement
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return 1;}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {return 720;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"CellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [self setupUI:cell];
    
    return cell;
}

#pragma mark - private method

- (void)handleAgreeProtocolBlock:(NSInteger )agrree {
    self.agreeProtocol = agrree;
    
    self.actionButton.enabled = (
                                 self.agreeProtocol == YES
                                 );
}

- (void)alloctAction:(id)sender {
    
    ZCMemeberSearchVC *vc = [ZCMemeberSearchVC new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
