//
//  ZCMemeberSearchVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/17.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCMemeberSearchVC.h"

@interface ZCMemeberSearchVC ()<UISearchBarDelegate>

@property (nonatomic, strong) ZCSearchDelegateListModel *model;

@end

@implementation ZCMemeberSearchVC

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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

#pragma mark - setter && getter method implement
#pragma mark - setupUI
#pragma mark - delete method implement
#pragma mark - private method

- (void)loadData {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(loadData) object:nil];
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = @{
                             @"userid" : USER_ID,
                             @"level" : @"1",
                             @"typeid" : @([CPUserInfoModel shareInstance].loginModel.Typeid),
                             @"currentpage" : @(self.currentIndex),
                             @"pagesize" : @"30",
                             }.mutableCopy;
    NSString *searchText = self.searchController.searchBar.text;
    if (searchText.length > 0 && ![searchText isEqualToString:@"全部"]) {
        
        if (cp_isNumber(searchText)) {
            [params setObject:searchText forKey:@"phone"];
        } else {
            [params setObject:searchText forKey:@"linkname"];
        }
    }

//    [ZCSearchDelegateListModel modelRequestPageWith:DOMAIN_ADDRESS@"/api/user/findUserPageList"
    [ZCSearchDelegateListModel modelRequestPageWith:DOMAIN_ADDRESS@"/api/user/findUserListWithAgent"
                                         parameters:params
                                              block:^(id  _Nonnull result) {
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
