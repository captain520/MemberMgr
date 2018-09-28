//
//  CPHelpCenterVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/21.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPHelpCenterVC.h"
#import "CPHelpListModel.h"
#import "CPWebVC.h"
#import "CPImageCell.h"
#import "CPFullImageCell.h"
#import "CPHelpDetailModel.h"

@interface CPHelpCenterVC ()

@property (nonatomic, strong) NSMutableArray *dataModels;

@end

@implementation CPHelpCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"帮助中心";

    [self loadData];
    
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return IS_SHOP ? 1 : self.dataModels.count;
            break;
        case 2:
            return self.dataModels.count;
            break;
        default:
            break;
    }

    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (IS_SHOP) {
        return 3;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if ((IS_SHOP && section == 2) || (IS_ASSISTANT && section == 1)) {
        return 0.00000000001;
    }
    
    return 44.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return cellSpaceOffset/2;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            return CELL_HEIGHT_F * 2;
            break;
        case 1:
            return IS_SHOP ? CELL_HEIGHT_F  * 2: CELL_HEIGHT_F * 1;
            break;
        default:
            break;
    }
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((IS_SHOP && indexPath.section == 2) || (IS_ASSISTANT && indexPath.section == 1)) {
        
        static NSString *cellIdentify = @"CellIdentify";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (nil == cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
            cell.clipsToBounds = YES;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        CPHelpListModel *model = self.dataModels[indexPath.row];
        cell.textLabel.text      = model.title;
        cell.textLabel.font      = CPFont_M;
        cell.textLabel.textColor = C33;
        
        return cell;
    } else {
        return [self confgiImageCell:indexPath];

    }
}

- (CPFullImageCell *)confgiImageCell:(NSIndexPath *)indexPath {
    
    static NSString * cellIdenitify = @"CPImageCell";
    
    CPFullImageCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdenitify];
    if (nil == cell) {
        cell = [[CPFullImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenitify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shouldShowBottomLine = NO;
    }
    
    if (indexPath.section == 0) {
        cell.imageName = @"回收流程";
    } else if (indexPath.section == 1) {
        cell.imageName = @"发货流程";
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return @"回收流程说明";
            break;
        case 1:
            return IS_SHOP ?  @"发货流程说明" : nil;
            break;
        default:
            break;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ((IS_SHOP && indexPath.section == 2) || (IS_ASSISTANT && indexPath.section == 1)) {
        
        CPHelpListModel *model = self.dataModels[indexPath.row];
        
        CPWebVC *webVC = [[CPWebVC alloc] init];
        webVC.title                    = model.title;
        webVC.contentStr               = model.Description;
        webVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:webVC animated:YES];
        
    } else if (indexPath.section == 0) {
        
        [self loadHelpDetail:@"8"];

    } else if (indexPath.section == 1) {
        
        [self loadHelpDetail:@"9"];
    }
}

- (void)loadHelpDetail:(NSString *)code {
    
    __weak typeof(self) weakSelf = self;
    
    [CPHelpDetailModel modelRequestWith:DOMAIN_ADDRESS@"/api/sysconfig/getHelpDetail"
                             parameters:@{@"id" : code}
                                  block:^(CPHelpDetailModel *result) {
                                      [weakSelf handleLoadHelpDetailBlock:result];
                                  } fail:^(CPError *error) {
                                      
                                  }];
    
}

- (void)handleLoadHelpDetailBlock:(CPHelpDetailModel *)result {
    if (!result || ![result isKindOfClass:[CPHelpDetailModel class]]) {
        
        [self.view makeToast:result.msg duration:1.0f position:@"center"];
        
        return;
    }
    
    CPWebVC *webVC = [[CPWebVC alloc] init];
    webVC.title                    = result.title;
    webVC.contentStr               = result.Description;
    webVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:webVC animated:YES];

}

#pragma mark - Private method

- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    
    [CPHelpListModel modelRequestWith:DOMAIN_ADDRESS@"/api/sysconfig/findSysConfigByCode?code=122"
                           parameters:nil
                                block:^(id result) {
                                    [weakSelf handleLoadDataBlock:result];
                                } fail:^(CPError *error) {
                                    
                                }];
}

- (void)handleLoadDataBlock:(NSArray <CPHelpListModel *> *)result {
    
    if (self.dataModels) {
        [self.dataModels removeAllObjects];
    } else {
        self.dataModels = @[].mutableCopy;
    }
    
    [result enumerateObjectsUsingBlock:^(CPHelpListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.ID != 8 && obj.ID != 9) {
            [self.dataModels addObject:obj];
        }
    }];

//    self.dataModels = result.mutableCopy;
    
    [self.dataTableView reloadData];
}

@end


