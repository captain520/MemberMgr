//
//  CPSearchVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/26.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPSearchVC.h"
#import "CPResultVC.h"
#import "CPGoodModel.h"

@interface CPSearchVC ()<UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
//@property (nonatomic, strong) UISearchDisplayController *searchController;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) CPResultVC *resultVC;
@property (nonatomic,strong) NSMutableArray <NSString *> *tempObjects;

@end

@implementation CPSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.dataArray = @[
//                       @[@""],
//                       @[@""]
//                       ];
    
    self.tempObjects = @[].mutableCopy;
    
    self.dataTableView.tableHeaderView = self.searchController.searchBar;

    self.searchController.active = YES;
}

#pragma mark - setter && getter method
- (UISearchBar *)searchBar {
    
    if (nil == _searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, CELL_HEIGHT_F)];
        _searchBar.delegate = self;
    }
    
    return _searchBar;
}

- (UISearchController *)searchController {
    
    if (nil == _searchController) {
//        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultVC];
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.delegate = self;
        _searchController.searchResultsUpdater = self;
    }

    return _searchController;
}

- (CPResultVC *)resultVC {
    
    __weak typeof(self) weakSelf = self;
    
    if (nil == _resultVC) {
        _resultVC = [[CPResultVC alloc] init];
        _resultVC.actionBlock = ^{
            [weakSelf handleSearchFinishedBlock];
        };
    }

    return _resultVC;
}

- (void)handleSearchFinishedBlock {
    _searchController.active = NO;
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = UIColor.whiteColor;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {

    
    DDLogInfo(@"--------------------");
    
//    [self.tempObjects addObject:@"iPhone 5ssss"];
//
//    self.resultVC.dataArray = @[self.tempObjects];
    
    __weak typeof(self) weakSelf = self;
    
    NSDictionary *params= @{
                            @"name" : self.searchController.searchBar.text
                            };
    
    [CPGoodModel modelRequestWith:CPURL_SHOP_GOOD_LIST
                       parameters:params
                            block:^(id result) {
                                [weakSelf handleLoadGoodsBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
}

- (void)handleLoadGoodsBlock:(NSArray <CPGoodModel *> *)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        return;
    }
    
    [self.resultVC updateWithDataArray:@[result]];
}

@end
