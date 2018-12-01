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
#import "ZCRegisterMemberSearchVC.h"

@interface ZCMemberListVC ()

@property (nonatomic, strong) ZCSearchDelegateListModel *model;
@property (nonatomic, strong) UIBarButtonItem *searchItem, *selectAllItem;
@property (nonatomic, strong) NSArray <NSIndexPath *> *selectIndexPaths;

@end

@implementation ZCMemberListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.searchItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
    self.selectAllItem = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStyleDone target:self action:@selector(selectAllCell:)];

    [self.editButtonItem setTitle:@"分配"];
    self.navigationItem.rightBarButtonItems = @[self.editButtonItem, self.searchItem];
    
    [self setTitle:@"已注册会员信息"];
    
    [self loadData:nil];
}


- (void)selectAllCell:(id)sender {
    NSArray *firstArray = self.dataArray.firstObject;
    [firstArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    self.editButtonItem.title = editing ? @"确定" : @"分配";
    if (editing) {
        self.navigationItem.rightBarButtonItems = @[self.editButtonItem,self.selectAllItem];
    } else {
        self.navigationItem.rightBarButtonItems = @[self.editButtonItem, self.searchItem];

        
        if (self.dataTableView.indexPathsForSelectedRows.count > 0) {
            
            self.selectIndexPaths = self.dataTableView.indexPathsForSelectedRows;
            
            __weak typeof(self) weakSelf = self;
            
            ZCMemeberSearchVC *vc = [ZCMemeberSearchVC new];
            vc.selectModel = ^(DLData *model) {
                [weakSelf handleAllocActionBlock:model];
            };
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }

    [self.dataTableView setEditing:editing animated:YES];
}

- (void)handleAllocActionBlock:(DLData *)model {
    
    NSMutableArray *tempArray = @[].mutableCopy;
    
    [self.selectIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DLData *tempModel = self.dataArray[obj.section][obj.row];
        [tempArray addObject:@(tempModel.ID)];
    }];
    
    NSString *ids = [tempArray componentsJoinedByString:@","];
    
    NSDictionary *params = @{
                             @"userids" : ids,
                             @"belonguserid" : @(model.ID)
                             };
    
    [CPBaseModel modelRequestWith:DOMAIN_ADDRESS@"/api/user/updateBelongChildAgent"
                       parameters:params
                            block:^(id result) {
                                
                            } fail:^(CPError *error) {
                                
                            }];
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.isEditing) {
        return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
- (void)loadData:(DLData *)filterModel {
    
    NSMutableDictionary *params = @{
                                    @"currentuserid" : USER_ID,
                                    @"typeid" : @(6),
                                    @"currentusertypeid" : @([CPUserInfoModel shareInstance].loginModel.Typeid),
                                    @"currentpage" : @(self.currentIndex),
                                    @"pagesize" : @"10",
//                                    @"checkcfg" : @"1",
                                    }.mutableCopy;
    
    __weak typeof(self) weakSelf = self;
    if (filterModel) {
        [params setObject:filterModel.phone forKey:@"phone"];
        [params setObject:filterModel.linkname forKey:@"linkname"];
        [params setObject:@(1) forKey:@"currentpage"];
    }

    [ZCSearchDelegateListModel modelRequestPageWith:DOMAIN_ADDRESS@"api/user/findUserPageList"
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
    
    __weak typeof(self) weakSelf = self;
    ZCRegisterMemberSearchVC *searchVC = [ZCRegisterMemberSearchVC new];
    searchVC.selectModel = ^(DLData *model) {
        DDLogInfo(@"");
        [weakSelf handleSearchResult:model];
    };
    
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)handleSearchResult:(DLData *)data {
    [self loadData:data];
}

@end
