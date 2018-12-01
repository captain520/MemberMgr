//
//  ZCRegisterMemberSearchVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/10/16.
//  Copyright © 2018 Captain. All rights reserved.
//

#import "ZCRegisterMemberSearchVC.h"

@interface ZCRegisterMemberSearchVC ()<UISearchBarDelegate>

@property (nonatomic, strong) ZCSearchDelegateListModel *model;

@end

@implementation ZCRegisterMemberSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof(self) weakSelf = self;
    
    [self.searchController setActive:YES];
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.text = @"全部";
    self.selectedIndex = ^(NSInteger index) {
        [weakSelf handleSelectedIndexBlock:index];
    };
    
    [self loadData];
}

- (void)handleSelectedIndexBlock:(NSInteger )index {
    !self.selectModel ? : self.selectModel(self.model.data[index]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    //    searchBar.text = nil;
    //    [self performSelector:@selector(loadData) withObject:nil afterDelay:.25];
}
- (void)willPresentSearchController:(UISearchController *)searchController {
    DDLogInfo(@"");
}
- (void)didPresentSearchController:(UISearchController *)searchController {
    DDLogInfo(@"");
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    DDLogInfo(@"%s",__FUNCTION__);
}
- (void)didDismissSearchController:(UISearchController *)searchController {
    DDLogInfo(@"%s",__FUNCTION__);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    DDLogInfo(@"");
    
    [self performSelector:@selector(loadData) withObject:nil afterDelay:.25];
}

#pragma mark - private method
- (void)loadData {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(loadData) object:nil];
    
    NSMutableDictionary *params = @{
                                    @"currentuserid" : USER_ID,
                                    @"typeid" : @(6),
                                    @"currentusertypeid" : @([CPUserInfoModel shareInstance].loginModel.Typeid),
                                    @"currentpage" : @(self.currentIndex),
                                    @"pagesize" : @"10",
//                                    @"checkcfg" : @"1",
                                    }.mutableCopy;
    
    
    NSString *searchText = self.searchController.searchBar.text;
    if (searchText.length > 0 && ![searchText isEqualToString:@"全部"]) {
        if (cp_isNumber(searchText)) {
            [params setObject:searchText forKey:@"phone"];
        } else {
            [params setObject:searchText forKey:@"linkname"];
        }
    }
    
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
    
    self.model = result;
    
    if (result.data && [result.data isKindOfClass:[NSArray class]]) {
        [self.resultVC refreshTableViewWithDataArray:@[result.data]];
    } else {
        [self.resultVC refreshTableViewWithDataArray:@[@[]]];
    }
}

@end
