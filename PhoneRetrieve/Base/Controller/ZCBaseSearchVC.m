//
//  ZCBaseSearchVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/17.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCBaseSearchVC.h"

@interface ZCBaseSearchVC ()<UISearchControllerDelegate,UISearchResultsUpdating>

@end

@implementation ZCBaseSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter && getter method implement
#pragma mark - setupUI

- (void)setupUI {
    
    self.dataTableView.mj_header = nil;
    self.dataTableView.mj_footer = nil;
    self.dataTableView.scrollEnabled = NO;
    
    __weak typeof(self) weakSelf = self;
    
    self.resultVC = [[CPSearchResultVC alloc] init];
    self.resultVC.didSelecRow = ^(NSInteger row) {
        [weakSelf handleDidSelectRowBlock:row];
    };
    
    _searchController = [[UISearchController alloc]initWithSearchResultsController:self.resultVC];
    //设置代理
    _searchController.delegate = self;
    _searchController.searchResultsUpdater= self;
    
    //设置UISearchController的显示属性，以下3个属性默认为YES
    //搜索时，背景变暗色
    _searchController.dimsBackgroundDuringPresentation = YES;
    //搜索时，背景变模糊
    //    _searchController.obscuresBackgroundDuringPresentation = YES;
    //隐藏导航栏
    _searchController.hidesNavigationBarDuringPresentation = YES;
    
    self.dataTableView.tableHeaderView = self.searchController.searchBar;
    
    self.searchController.searchBar.barTintColor = UIColor.whiteColor;
    self.searchController.searchBar.placeholder = @"会员名称/会员电话号码";
    self.searchController.searchBar.layer.borderColor = UIColor.redColor.CGColor;
    self.searchController.searchBar.tintColor = MainColor;
    self.searchController.searchBar.backgroundImage = [UIImage new];
    //
    UITextField *searchField = [self.searchController.searchBar valueForKey:@"_searchField"];
    if (searchField) {
        [searchField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
        searchField.clipsToBounds = YES;
        searchField.textColor = C33;
        searchField.borderStyle = UITextBorderStyleRoundedRect;
        searchField.layer.borderColor = CPBoardColor.CGColor;
        searchField.layer.borderWidth = 1;
        searchField.layer.cornerRadius = 5;
        searchField.textColor = MainColor;
    }
    
    UIView *sepLine = [UIView new];
    sepLine.backgroundColor = CPBoardColor;
    
    [self.view addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(55);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(.5);
    }];
}

#pragma mark - delete method implement
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}
#pragma mark - private method
- (void)handleDidSelectRowBlock:(NSInteger )row {
    DDLogInfo(@"%ld",row);
    !self.selectedIndex ? : self.selectedIndex(row);
    [self.searchController setActive:NO];
}

@end
