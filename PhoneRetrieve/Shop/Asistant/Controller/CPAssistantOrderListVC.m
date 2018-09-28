//
//  CPAssistantOrderListVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/19.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPAssistantOrderListVC.h"
#import "CPOrderCell.h"
#import "CPAssistanteOrderDetailModel.h"
#import "CPOrderDetailVC.h"
#import "CPOrderSearchVC.h"

@interface CPAssistantOrderListVC ()

@end

@implementation CPAssistantOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"search") style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
    
//    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 3 * CELL_HEIGHT_F;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"CPShopCartCell";
    
    CPOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CPOrderCell alloc] initWithStyle:0 reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.assistantOrderModel = self.dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.00000000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CPAssistanteOrderDetailModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    CPOrderDetailVC *vc = [[CPOrderDetailVC alloc] init];
    vc.orderID = model.ID;
    vc.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - private method
- (void)loadData {
    
    if (self.dataArray && self.dataArray.count > 0) {
        [self.dataTableView reloadData];
        return;
    }
    
    NSString *ID = self.userid;
    if (ID == nil) {
        ID = [NSString stringWithFormat:@"%ld",[CPUserInfoModel shareInstance].loginModel.ID];
    }

    __weak typeof(self) weakSelf = self;
    NSDictionary *params = @{
                             @"typeid": @(4),
                             @"userid": ID
                             };
    
//    NSDictionary *params = @{
//                             @"typeid": @([CPUserInfoModel shareInstance].loginModel.Typeid),
//                             @"userid": @([CPUserInfoModel shareInstance].loginModel.ID),
//                             @"sendcfg":@"0",
//                             @"statuscfg":@"0",
//                             @"paycfg":@"0",
//                             @"starttime":@"2018-03-10 00:00:00",
//                             @"endtime":@"2018-03-30 00:00:00",
//                             @"currentpage":@"1",
//                             @"pagesize":@"20"
//                             @"resultno":@"",
//                             @"":@"",
//                             @"":@"",
                             
//                             };
    
    [CPAssistanteOrderDetailModel orderModelRequestWith:CPURL_ASSISTANT_GET_RETRIEVE_ORDER
                       parameters:params
                            block:^(id result) {
                                [weakSelf handleLoadDataSuccessBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
}

- (void)handleLoadDataSuccessBlock:(NSArray <CPAssistanteOrderDetailModel *> *)result {
    if (!result ||  ![result isKindOfClass:[NSArray class]]) {
        return;
    }
    
    self.dataArray = result;
    [self.dataTableView reloadData];
}

- (void)searchAction:(id)sender {
    
    CPOrderSearchVC *vc = [[CPOrderSearchVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.type = CPOrderSearchTypeOrder;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)back {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
