//
//  CPEvaluatedPriceVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPEvaluatedPriceVC.h"
#import "CPEvaluatePriceHeader.h"
#import "CPEvaluatedTypeHeader.h"
#import "CPEvaluatedContentCell.h"
#import "CPSelectCell.h"
#import "CPDeviceOwnerInfoVC.h"
#import "CPShopGoodsListVC.h"
#import "CPMemberQuotePriceFooter.h"
#import "CPMemberQuoteFlowVC.h"
#import "CPQuoteManager.h"
#import "CPGoodSearchResultVC.h"

@interface CPEvaluatedPriceVC ()

@property (nonatomic, strong) NSMutableArray <NSIndexPath *> *selectedIndexPath;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) NSMutableArray *itemDatas;
@property (nonatomic, assign) BOOL hasAgreeProtocol;

@property (nonatomic, assign) BOOL isUpDirection;

@end

@implementation CPEvaluatedPriceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([CPUserInfoModel shareInstance].repaircfg.integerValue == 1) {
        self.dataArray = @[
                           @[@""],
                           @[@"",@"",@""],
                           @[@"备份手机数据",@"接触ID锁",@"回复出厂设置"]
                           ];
        
    } else if ([CPUserInfoModel shareInstance].repaircfg.integerValue == 2) {
        self.dataArray = @[
                           @[@""],
                           @[@"",@"",@""]
                           ];
        
    }
    

    self.selectedIndexPath = @[].mutableCopy;
    
    self.dataTableView.allowsMultipleSelection = YES;
    
    [self.nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.dataTableView.frame = CGRectMake(0, NAV_HEIGHT, SCREENWIDTH, SCREENHEIGHT - NAV_HEIGHT - NAV_HEIGHT);

    
    [self setTitle:[CPMemberQuoteManager shareInstance].deviceName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)nextButton {
    
    if (nil == _nextButton) {
        _nextButton = [UIButton new];
        _nextButton.titleLabel.font = CPFont_L;
        [_nextButton setTitle:@"下一步" forState:0];
        [_nextButton setBackgroundColor:MainColor];
        [_nextButton setTitleColor:UIColor.whiteColor forState:0];

        _nextButton.enabled = [[CPUserInfoModel shareInstance].repaircfg isEqualToString:@"2"];
        [_nextButton setBackgroundImage:CPEnableImage forState:UIControlStateNormal];
        [_nextButton setBackgroundImage:CPDisableImage forState:UIControlStateDisabled];
        
        [self.view addSubview:_nextButton];
        
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(0);
            make.height.mas_equalTo(CELL_HEIGHT_F * 3 / 2);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
    }
    
    return _nextButton;
}

- (void)setItemDicts:(NSArray<NSDictionary *> *)itemDicts {
    _itemDicts = itemDicts;
    
    
    self.itemDatas = @[].mutableCopy;
    
    [itemDicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *tempArray = obj[@"data"];
        [tempArray enumerateObjectsUsingBlock:^(NSDictionary *obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            NSDictionary *tempDict = @{obj[@"name"] : obj1[@"name"]};
            [self.itemDatas addObject:tempDict];
        }];
    }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return 200;
        case 1:
            return 100 + self.isUpDirection * CELL_HEIGHT_F;
            break;

        default:
            break;
    }
    
    return CELL_HEIGHT_F;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
       
        NSString *headerIdenitfier = @"headerIdenitfier";
        
        CPEvaluatePriceHeader *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdenitfier];
        if (!footer) {
            CGFloat height = [self tableView:tableView heightForFooterInSection:section];
            footer = [[CPEvaluatePriceHeader alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, height)];
        }
        
        [footer.reevaluedButton addTarget:self action:@selector(revalueAction:) forControlEvents:64];
        
        footer.cp_content = self.model.price;

        return footer;
    } else if(1 == section && [CPUserInfoModel shareInstance].loginModel.Typeid > 5) {
        
//        __weak typeof(self) weakSelf = self;

        NSString *headerIdenitfier = @"MemberPriceFooter";
        CPMemberQuotePriceFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdenitfier];
        if (!footer) {
            footer = [[CPMemberQuotePriceFooter alloc] initWithReuseIdentifier:headerIdenitfier];
            footer.actionBlock = ^(BOOL isUpDirection) {
//                DDLogError(@"******************************%@",@(isUpDirection));
//                weakSelf.isUpDirection = isUpDirection;
//                [weakSelf.dataTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationTop];
            };
            footer.contentView.backgroundColor = UIColor.groupTableViewBackgroundColor;
        }

        footer.price = self.model.currentprice;

        return footer;
    }
    
    return nil;
}

- (void)revalueAction:(id)sender {
    
    !self.revalueActionBlock ? : self.revalueActionBlock();
    
    if (IS_MEMBER_ACCOUNT) {
        
        NSArray *array = [[self.navigationController.viewControllers reverseObjectEnumerator] allObjects];

        [array enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[CPGoodSearchResultVC class]]) {
                [self.navigationController popToViewController:obj animated:YES];
                [((CPGoodSearchResultVC *)obj) push2QuoteFlow:YES];
                *stop = YES;
            }

            if ([obj isKindOfClass:[CPShopGoodsListVC class]]) {
                [self.navigationController popToViewController:obj animated:YES];
                [((CPShopGoodsListVC *)obj) push2QuoteFlow:YES];
                *stop = YES;
            }
        }];
        
//        [CPQuoteManager shareInstance].flowIndex = 1;
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshQuoteFlow" object:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0.0000000001;
        case 2:
            return 0.000000001;
            break;
            
        default:
            break;
    }
    
    return 30.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (0 == section || 2 == section) {
        return nil;
    }
    
    NSString *headerIdenitfier = @"CPEvaluatedTypeHeader";
    CPEvaluatedTypeHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdenitfier];
    if (!header) {
        header = [[CPEvaluatedTypeHeader alloc] initWithReuseIdentifier:headerIdenitfier];
    }
    
    header.title = @"评估详情";
    
    return header;
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
        {
            return self.itemDatas.count;
//            __block NSUInteger itemCount = 0;
//
//            [self.itemDicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                NSArray *tempArray = obj[@"data"];
//
//                itemCount += tempArray.count;
//            }];
//
//            return itemCount;
        }
            break;
        case 2:
            return 1;
            break;
        default:
            break;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            if ([CPUserInfoModel shareInstance].loginModel.Typeid > 5) {
                return 100;
            } else {
                return CELL_HEIGHT_F;
            }
        }
            break;
        case 1:
        case 2:
            return 30.0f;
            break;

        default:
            break;
    }
    
    return CELL_HEIGHT_F;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell = nil;
    
    switch (indexPath.section) {
        case 0:
        {
            if ([CPUserInfoModel shareInstance].loginModel.Typeid > 5) {    //  会员温馨提示
                cell = [self configMemberHintCell:indexPath];
            } else {
                cell = [self configHintCell:indexPath];     //  其他  安全小贴士
            }
        }
            break;
        case 1:
            cell = [self configEvaluatedContentCell:indexPath];
            break;
        case 2:
            cell = [self configDataHandleCell:indexPath];
            break;
            
        default:
            cell = [self configHintCell:indexPath];
            break;
    }
    
//    static NSString *cellIdentify = @"CellIdentify";
    
//    CPDeviceProblemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
//    if (nil == cell) {
//        cell = [[CPDeviceProblemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
//        cell.clipsToBounds = YES;
//        cell.shouldShowBottomLine = NO;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.contentView.backgroundColor = tableView.backgroundColor;
//    }
//
//    NSArray *tempArray = self.dataArray[indexPath.section];
//
//    cell.imageName = @"question_mark";
//    cell.title = tempArray[indexPath.row];
//    cell.shouldHighted = [self.selectedIndexPath containsObject:indexPath];
    
    return cell;
}

- (id)configHintCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"configHintCell";
    
    UITableViewCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentify];
        cell.imageView.image = CPImage(@"SafetyTips");
        cell.textLabel.text = @"苹果安全小帖士";
        cell.detailTextLabel.text = @"iOS系统恢复出厂设置, 无需担心数据泄漏风险";
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.contentView.backgroundColor = UIColor.clearColor;
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


//  会员
- (id)configMemberHintCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"configMemberHintCell";
    
    CPBaseCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[CPBaseCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentify];
        cell.textLabel.text = @"温馨提示";
        cell.detailTextLabel.attributedText = [self memberHintContnet];
        cell.detailTextLabel.numberOfLines = 0;
        cell.contentView.backgroundColor = UIColor.clearColor;
        cell.backgroundColor = UIColor.whiteColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shouldShowBottomLine = YES;
    }
    
    return cell;
}

//  获取会员温馨提示富文本
- (NSAttributedString *)memberHintContnet {
    
    NSString *content0 = @"本平台根据国家法律法规，盗抢设备概不回收，一经发现立即报警\n";
    NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:content0 attributes:@{NSForegroundColorAttributeName : UIColor.redColor}];
    
    NSString *content1 = @"另拒绝回收一切有锁设备（ID锁、屏幕锁、账户锁等）";
    NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:content1 attributes:@{NSForegroundColorAttributeName : C33}];
    
    [attr0 appendAttributedString:attr1];
    
    return attr0;
}

- (CPEvaluatedContentCell *)configEvaluatedContentCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPEvaluatedContentCell";
    
    CPEvaluatedContentCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CPEvaluatedContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.itemDict = self.itemDatas[indexPath.row];
    
    return cell;
}

- (id)configDataHandleCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPSelectCell";
    
    CPSelectCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CPSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shouldShowBottomLine = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
//    NSArray <NSString * > *contents = self.dataArray[indexPath.section];
    cell.hasSelected = [self.selectedIndexPath containsObject:indexPath];
//    cell.content = [contents objectAtIndex:indexPath.row];
    cell.content = [CPUserInfoModel shareInstance].operationDes;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (2 == indexPath.section) {
        
        [self.selectedIndexPath containsObject:indexPath] ?
        [self.selectedIndexPath removeObject:indexPath] : [self.selectedIndexPath addObject:indexPath];
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        self.hasAgreeProtocol = [self.selectedIndexPath containsObject:indexPath];
        
        self.nextButton.enabled = self.hasAgreeProtocol;
    }
}

#pragma mark - private method

- (void)nextAction:(UIButton *)sender {
    NSLog(@"------------------------------");
    CPDeviceOwnerInfoVC *vc = [[CPDeviceOwnerInfoVC alloc] init];
    vc.model = self.model;
    
    [self.navigationController pushViewController:vc animated:YES];
//    [self push2VCWith:@"CPDeviceOwnerInfoVC" title:@"客户信息"];
}


@end
