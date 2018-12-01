//
//  ZCCheckInMemberListVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/10/16.
//  Copyright © 2018 Captain. All rights reserved.
//

#import "ZCCheckInMemberListVC.h"
#import "ZCSearchDelegateListModel.h"
#import "ZCCheckInMemberCell.h"
#import "ZCMemberDetailVC.h"

@interface ZCCheckInMemberListVC ()

@end

@implementation ZCCheckInMemberListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"子账号开拓会员"];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"ZCCheckInMemberCell";
    
    ZCCheckInMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZCCheckInMemberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.model = self.dataArray[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZCMemberDetailVC *vc = [[ZCMemberDetailVC alloc] init];
    vc.userID = self.model.ID;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - private method implement

- (void)loadData {
    
    NSMutableDictionary *params = @{
                                    @"currentuserid" : @(self.model.ID),
                                    @"typeid" : @(6),
                                    @"currentusertypeid" : @(self.model.Typeid),
                                    @"currentpage" : @(self.currentIndex),
                                    @"pagesize" : @"100",
//                                    @"checkcfg" :  @"1"
                                    }.mutableCopy;
    
    __weak typeof(self) weakSelf = self;
    
    [ZCSearchDelegateListModel modelRequestPageWith:DOMAIN_ADDRESS@"api/user/findUserPageList"
                                         parameters:params
                                              block:^(ZCSearchDelegateListModel *result) {
                                                  [weakSelf handleLoadDataBlock:result];
                                              } fail:^(CPError * _Nonnull error) {
                                                  
                                              }];
    
}

- (void)handleLoadDataBlock:(ZCSearchDelegateListModel *)result {
    
    [self.dataTableView.mj_header endRefreshing];
    
    if (result.hasNoData) {
        [self.dataTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.dataTableView.mj_footer endRefreshing];
    }
    
    if (result.data && [result.data isKindOfClass:[NSArray class]]) {
        self.dataArray = @[result.data].mutableCopy;
        [self.dataTableView reloadData];
    }
}

@end
