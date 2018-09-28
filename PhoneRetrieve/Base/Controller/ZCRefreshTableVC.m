//
//  ZCRefreshTableVC.m
//  MemberManager
//
//  Created by 王璋传 on 2018/9/13.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCRefreshTableVC.h"

@interface ZCRefreshTableVC ()


@end

@implementation ZCRefreshTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Setter && Getter method implement

- (UITableView *)dataTableView {
    
    if (nil == _dataTableView) {
        
        __weak typeof(self) weakSelf = self;
        
        CGRect frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - STATUSBAR_HEIGHT);
        
        _dataTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _dataTableView.delegate             = self;
        _dataTableView.dataSource           = self;
        _dataTableView.separatorColor       = UIColor.clearColor;
        _dataTableView.backgroundColor      = BgColor;
        _dataTableView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
        _dataTableView.mj_header            = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf handleMJHeaderFreshBlock];
        }];
        _dataTableView.mj_footer            = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf handleMJFooterFreshBlock];
        }];

        [self.view addSubview:_dataTableView];
    }
    
    return _dataTableView;
}

- (void)handleMJHeaderFreshBlock {
    self.currentIndex = 0;
    
    [self loadData];
}

- (void)handleMJFooterFreshBlock {
    
    self.currentIndex++;
    
    [self loadData];
}

#pragma mark - Tableview Delegate and datasouce method implement

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT_F;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"CellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"section:%ld, row:%ld",indexPath.section,indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

#pragma mark - Private method

- (void)loadData {
    
    [self.dataTableView.mj_header endRefreshing];
    [self.dataTableView.mj_footer endRefreshing];
    
    [self.dataTableView reloadData];
}


@end
