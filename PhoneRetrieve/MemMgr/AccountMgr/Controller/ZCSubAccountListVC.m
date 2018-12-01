//
//  ZCSubAccountListVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/19.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCSubAccountListVC.h"
#import "ZCSubAccountCell.h"
#import "ZCSearchDelegateListModel.h"
#import "ZCCheckInMemberListVC.h"
#import "ZCMemberDetailVC.h"
#import "ZCAddMemberVC.h"

@interface ZCSubAccountListVC ()<UIAlertViewDelegate>

@property (nonatomic, strong) DLData *deleteModel;

@end

@implementation ZCSubAccountListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"子账号管理";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新增" style:UIBarButtonItemStyleDone target:self action:@selector(addMemberAction:)];

    [self loadData];
}

#pragma mark - setter && getter method implement
#pragma mark - setupUI
#pragma mark - delete method implement
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 3 * 30 + 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"ZCSubAccountCell";
    
    ZCSubAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[ZCSubAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    __weak typeof(self) weakSelf = self;
    
    cell.model = self.dataArray[indexPath.section];
    cell.checkInBlock = ^(DLData * _Nonnull model) {
        [weakSelf handleCheckInBlock:model];
    };
    
    cell.modifyBlock = ^(DLData * _Nonnull model) {
        [weakSelf handleModifyBlock:model];
    };
    
    cell.deleteBlock = ^(DLData * _Nonnull model) {
        [weakSelf handleDeleteBlock:model];
    };
    
    return cell;
}

- (void)handleCheckInBlock:(DLData *)result {
    
    ZCCheckInMemberListVC *vc = [[ZCCheckInMemberListVC alloc] init];
    vc.model = result;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleModifyBlock:(DLData *)result {
    
    ZCAddMemberVC *vc = [[ZCAddMemberVC alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleDeleteBlock:(DLData *)result {
    
    self.deleteModel = result;
    
    NSString *message = [NSString stringWithFormat:@"确定要删除子账号:%@",result.linkname];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (1 == buttonIndex) {
        
        __weak typeof(self) weakSelf = self;
        
        NSDictionary *params = @{
                                 @"userid" : @(self.deleteModel.ID),
                                 };
        [CPBaseModel modelRequestWith:DOMAIN_ADDRESS
                           parameters:params
                                block:^(id result) {
                                    [weakSelf.dataArray removeObject:self.deleteModel];
                                    [weakSelf.dataTableView reloadData];
                                } fail:^(CPError *error) {
                                    
                                }];
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SPACE_OFFSET_F;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DLData *model = self.dataArray[indexPath.section];
    
    ZCMemberDetailVC *vc = [[ZCMemberDetailVC alloc] init];
    vc.userID = model.ID;
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - private method
- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = @{
                                    @"userid" : USER_ID,
                                    @"currentpage" : @(self.currentIndex),
                                    @"pagesize" : @"20",
                                    }.mutableCopy;
    
    [ZCSearchDelegateListModel modelRequestPageWith:DOMAIN_ADDRESS@"/api/user/findChildAgentList"
                                         parameters:params
                                              block:^(id  _Nonnull result) {
                                                  [weakSelf handleLoadDataBlcok:result];
                                              } fail:^(CPError * _Nonnull error) {
                                                  
                                              }];
}

- (void)handleLoadDataBlcok:(ZCSearchDelegateListModel *)result {
    
    [self.dataTableView.mj_header endRefreshing];
    
    if (result.hasNoData) {
        [self.dataTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.dataTableView.mj_footer endRefreshing];
    }
    
    self.dataArray = result.data.mutableCopy;
}

- (void)addMemberAction:(id)sender {
    
    ZCAddMemberVC *vc = [[ZCAddMemberVC alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
