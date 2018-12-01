//
//  ZCOrderListVC.m
//  MemberManager
//
//  Created by 王璋传 on 2018/9/13.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCServiceInfoListVC.h"
#import "ZCSearchVC.h"
#import "ZCServiceListHeaderView.h"
#import "ZCServiceDetailCell.h"
#import "ZCDelegateConsumModel.h"

@interface ZCServiceInfoListVC ()


@property (nonatomic, strong) ZCDelegateConsumModel *model;

@end

@implementation ZCServiceInfoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setTitle:@"服务费信息"];
    
    [self loadData];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setupUI
- (void)setupUI {
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
}

#pragma mark - delete method implement

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ZCServiceDetailCell";
    
    ZCServiceDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZCServiceDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.model = self.dataArray[indexPath.section][indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 2 * CELL_HEIGHT_F;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *headerIdentifier = @"headerIdentifier";
    
    ZCServiceListHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (nil == header) {
        header = [[ZCServiceListHeaderView alloc] initWithReuseIdentifier:headerIdentifier];
        header.contentView.backgroundColor = UIColor.whiteColor;
    }
    
    header.model = self.model.totalprice;
    
    return header;
}

- (NSString *)convertDate2StrFormat:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [dateFormatter stringFromDate:date];
}
#pragma mark - private method implement
- (void)loadData {
    
    NSString *endTime = [self convertDate2StrFormat:[NSDate date]];
    NSString *startTime = [self convertDate2StrFormat:[NSDate dateWithTimeIntervalSinceNow:-3 * 24 * 60 * 60]];
    
    NSMutableDictionary *params = @{
                                    @"agentid" : USER_ID,
//                                    @"starttime" : startTime,
//                                    @"endtime" : endTime,
                                    @"starttime" : @"2018-09-29",
                                    @"endtime" : @"2018-10-02",
                                    @"currentpage" : @(self.currentIndex),
                                    @"pagesize" : @"30",
                                    }.mutableCopy;
    
    __weak typeof(self) weakSelf = self;
    
    [ZCDelegateConsumModel modelRequestPageWith:DOMAIN_ADDRESS@"/api/Reportresultcommision/findPageList"
                                     parameters:params
                                          block:^(id  _Nonnull result) {
                                              [weakSelf handleLoadDataSuccessBlock:result];
                                          } fail:^(CPError * _Nonnull error) {
                                              
                                          }];
}

- (void)handleLoadDataSuccessBlock:(ZCDelegateConsumModel *)result {
    
    if (!result || ![result.data isKindOfClass:[NSArray class]] || result.data.count == 0) {
        return;
    }
    
    [self.dataTableView.mj_header endRefreshing];
    if (result.hasNoData) {
        [self.dataTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.dataTableView.mj_footer endRefreshing];
    }
    
    self.model = result;
    
    self.dataArray = @[result.data].mutableCopy;
    
    [self.dataTableView reloadData];
}

- (void)searchAction:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    
    ZCSearchVC *searchVC = [ZCSearchVC new];
    searchVC.loadDataBlock = ^(id data) {
        [weakSelf handleSearchBlock:data];
    };
    
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)handleSearchBlock:(ZCDelegateConsumModel *)blockData{
    
    [self.dataTableView.mj_footer endRefreshingWithNoMoreData];

    self.model = blockData;
    self.dataArray = @[blockData.data].mutableCopy;
    
    [self.dataTableView reloadData];
}

@end
