//
//  ZCOrderSearchVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/14.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCOrderSearchVC.h"
#import "CPSearchResultVC.h"

@interface ZCOrderSearchVC ()<UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating>

@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic, strong) CPSearchResultVC *resultVC;

@end

@implementation ZCOrderSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view = self.dataTableView;
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - setter && getter method implement
#pragma mark - setupUI
- (void)handleDidSelectRowBlock:(NSInteger )row {
    DDLogInfo(@"%ld",row);
//    [self.navigationController pushViewController:UIViewController.new animated:YES];
    [self.searchController setActive:NO];
}

- (void)setupUI {
    
    [self setTitle:@"交易订单查询"];
    
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


    ZCLabel *beginHintLB = [ZCLabel new];
    beginHintLB.text = @"开始时间:";
    [self.view addSubview:beginHintLB];
    [beginHintLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sepLine.mas_bottom).offset(SPACE_OFFSET_F);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
    }];

    self.beginDateTF = [ZCDatePickerTF new];

    [self.view addSubview:self.beginDateTF];
    [_beginDateTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(beginHintLB.mas_bottom).offset(SPACE_OFFSET_F/2);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];

    ZCLabel *endHintLB = [ZCLabel new];
    endHintLB.text = @"结束时间:";
    [self.view addSubview:endHintLB];
    [endHintLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.beginDateTF.mas_bottom).offset(SPACE_OFFSET_F);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
    }];

    self.endDateTF = [ZCDatePickerTF new];

    [self.view addSubview:self.endDateTF];
    [self.endDateTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(endHintLB.mas_bottom).offset(SPACE_OFFSET_F/2);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];

    ZCButton *actionBT = [ZCButton new];
    [actionBT setTitle:@"搜索" forState:0];

    [self.view addSubview:actionBT];
    [actionBT addTarget:self action:@selector(searchAction) forControlEvents:64];
    [actionBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.endDateTF.mas_bottom).offset(CELL_HEIGHT_F);
        make.left.mas_equalTo(SPACE_OFFSET_F);
        make.right.mas_equalTo(-SPACE_OFFSET_F);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];
}
#pragma mark - delete method implement
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark - private method
- (void)searchAction {
    DDLogInfo(@"%s",__FUNCTION__);
}


@end
