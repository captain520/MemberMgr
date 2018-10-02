//
//  ZCMemberListVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/15.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCMemberListVC.h"
#import "ZCMemberListCell.h"
#import "ZCOrderSearchVC.h"
#import "ZCMemeberSearchVC.h"
#import "ZCMemberDetailVC.h"
#import "ZCSearchDelegateListModel.h"

@interface ZCMemberListVC ()

@property (nonatomic, strong) ZCSearchDelegateListModel *model;

@end

@implementation ZCMemberListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];

    self.navigationItem.rightBarButtonItems = @[self.editButtonItem, searchItem];
    
    [self loadData];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    [self.dataTableView setEditing:editing animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter && getter method implement
#pragma mark - setupUI
#pragma mark - delete method implement
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 3 * 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"ZCMemberListCell";
    
    ZCMemberListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[ZCMemberListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.shouldShowBottomLine = YES;
    }
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = CELL_BG_COLOR;
    } else {
        cell.backgroundColor = UIColor.whiteColor;
    }
    
    cell.model = self.dataArray[indexPath.section][indexPath.row];
    
    return cell;
}

cccc
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.isEditing == NO) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        DLData *model = self.dataArray[indexPath.section][indexPath.row];
        
        ZCMemberDetailVC *vc = [ZCMemberDetailVC new];
        vc.userID = model.ID;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    DDLogInfo(@"%@",tableView.indexPathsForSelectedRows);
}
#pragma mark - private method
- (void)loadData {
    
    NSMutableDictionary *params = @{
                                    @"currentuserid" : USER_ID,
                                    @"typeid" : @(6),
                                    @"currentusertypeid" : @([CPUserInfoModel shareInstance].loginModel.Typeid),
                                    @"currentpage" : @(self.currentIndex),
                                    @"pagesize" : @"10",
                                    }.mutableCopy;
    
    __weak typeof(self) weakSelf = self;

    [ZCSearchDelegateListModel modelRequestPageWith:DOMAIN_ADDRESS@"api/user/findUserPageList/findUserPageList"
                                         parameters:params
                                              block:^(ZCSearchDelegateListModel *result) {
                                                  [weakSelf handleLoadDataBlock:result];
                                              } fail:^(CPError * _Nonnull error) {
                                                  
                                              }];
    
}

- (void)handleLoadDataBlock:(ZCSearchDelegateListModel *)result {
    
    if (result.hasNoData) {
        [self.dataTableView.mj_header endRefreshing];
        [self.dataTableView.mj_footer endRefreshingWithNoMoreData];
    }
    
    self.model = result;
    
    if (result.data && [result.data isKindOfClass:[NSArray class]]) {
        self.dataArray = @[result.data].mutableCopy;
        [self.dataTableView reloadData];
    }
}

- (void)searchAction:(id)sender {
    
    ZCMemeberSearchVC *searchVC = [ZCMemeberSearchVC new];
    //    ZCSearchListVC *searchVC = [ZCSearchListVC new];
    
    [self.navigationController pushViewController:searchVC animated:YES];
}

@end
