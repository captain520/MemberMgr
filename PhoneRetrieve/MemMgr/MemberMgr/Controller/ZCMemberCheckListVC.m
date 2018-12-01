//
//  ZCMemberCheckListVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/17.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCMemberCheckListVC.h"
#import "ZCMemberCheckCell.h"
#import "CPTabBarView.h"
#import "ZCCheckFooter.h"
#import "ZCMemberCheckVC.h"
#import "ZCUnlockMemberVC.h"
#import "ZCSearchDelegateListModel.h"

@interface ZCMemberCheckListVC ()

@property (nonatomic, strong) CPTabBarView *tabbarView;
@property (nonatomic, assign) NSInteger currentTabIndex;

@end

@implementation ZCMemberCheckListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.title = @"会员审核";
    
    [self setupUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter && getter method implement
- (CPTabBarView *)tabbarView {
    
    if (_tabbarView == nil) {
        
        __weak typeof(self) weakSelf = self;
        
        _tabbarView = [[CPTabBarView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, CELL_HEIGHT_F)];
        _tabbarView.backgroundColor = [UIColor whiteColor];
        _tabbarView.selectBlock = ^(NSInteger index) {
            //TODO: 切换选择刷新
            weakSelf.currentTabIndex = index;
            [weakSelf loadData];
        };
        
        [self.view addSubview:_tabbarView];
    }
    
    return _tabbarView;
}
#pragma mark - setupUI

- (void)setupUI {

    self.tabbarView.dataArray = @[@"新注册审核",@"冻结审核"];
    
    [self.dataTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tabbarView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark - delete method implement
#pragma mark - delete method implement
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 3 * 30 + 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"ZCMemberListCell";
    
    ZCMemberCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[ZCMemberCheckCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    __weak typeof(self) weakSelf = self;
    cell.checkBlock = ^{
        [weakSelf handleCheckBlock:indexPath];
    };
    
    cell.model = self.dataArray[indexPath.section][indexPath.row];

    return cell;
}

- (void)handleCheckBlock:(NSIndexPath *)indexPath {
    DDLogInfo(@"section:%ld",indexPath.section);
    DLData *model = self.dataArray[indexPath.section][indexPath.row];
    
    if (self.currentTabIndex == 0) {
        

        ZCMemberCheckVC *vc = [ZCMemberCheckVC new];
        vc.userID = model.ID;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (self.currentIndex == 1) {
        ZCUnlockMemberVC *vc = [ZCUnlockMemberVC new];
        vc.userID = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SPACE_OFFSET_F;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - private method
//- (void)loadData {
//    self.dataTableView.separatorColor = CPBoardColor;
//    [super loadData];
//}
//
//#pragma mark - private method
- (void)loadData {
    
    NSMutableDictionary *params = @{
                                    @"currentuserid" : USER_ID,
                                    @"typeid" : @(6),
                                    @"currentusertypeid" : @([CPUserInfoModel shareInstance].loginModel.Typeid),
                                    @"currentpage" : @(self.currentIndex),
                                    @"pagesize" : @"10",
                                    @"checkcfg" : self.currentTabIndex == 0 ? @"2" : @"3"
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
