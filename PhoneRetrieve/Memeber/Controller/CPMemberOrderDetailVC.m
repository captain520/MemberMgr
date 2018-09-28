//
//  CPMemberOrderDetailVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemberOrderDetailVC.h"
#import "CPMemberOrderDetailCell.h"
#import "CPMemberOrderDetailFooter.h"
#import "CPMemberOrderDetailModel.h"
#import "CPMemberCheckReportVC.h"
#import "CPOrderDetailVC.h"
#import "CPWebVC.h"

@interface CPMemberOrderDetailVC ()

@end

@implementation CPMemberOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {return self.dataArray.count;}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {return 1;}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {return 100;}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {return 80;}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {return cellSpaceOffset;}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CPMemberOrderDetailCell.h";
    CPMemberOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[CPMemberOrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CPMemberOrderDetailModel *model = self.dataArray[indexPath.section];
    cell.model = model;

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NSString *footerIdentifier = @"footerIdentifier";
    
    CPMemberOrderDetailFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerIdentifier];
    if (nil == footer) {
        footer = [[CPMemberOrderDetailFooter alloc] initWithReuseIdentifier:footerIdentifier];
        footer.contentView.backgroundColor = UIColor.whiteColor;
    }
    
    __weak typeof(self) weakSelf = self;
    
    footer.checkReportAction = ^{
        DDLogInfo(@"------------------------------");
        [weakSelf push2CheckReportVC:section];
    };
    
    footer.model = self.dataArray[section];
    
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CPMemberOrderDetailModel *model = self.dataArray[indexPath.section];
    
    CPOrderDetailVC *vc = [[CPOrderDetailVC alloc] init];
    vc.orderID = model.ID;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - private method implement
- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    
    [self.dataTableView reloadData];

    [CPMemberOrderDetailModel modelRequestWith:DOMAIN_ADDRESS@"api/Reportresult/findUserReportResult"
                       parameters:@{@"orderid" : self.orderid
                                    }
                            block:^(id result) {
                                [weakSelf handleLoadDataBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
    
    [self setTitle:@"订单详情"];
}

- (void)handleLoadDataBlock:(NSArray <CPMemberOrderDetailModel *> *)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        return;
    }
    
    self.dataArray = [NSMutableArray arrayWithArray:result];

    [self.dataTableView reloadData];
}


/**
 * 跳转到检测报告页面
 */
- (void)push2CheckReportVC:(NSInteger)section {
    
    CPMemberOrderDetailModel *model = self.dataArray[section];
    
    CPMemberCheckReportVC *vc = [[CPMemberCheckReportVC alloc] init];
    vc.resultid = model.ID;
    
    [self.navigationController pushViewController:vc animated:YES];
}



@end
