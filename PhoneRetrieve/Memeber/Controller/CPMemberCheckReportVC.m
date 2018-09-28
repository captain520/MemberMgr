//
//  CPMemberCheckReportVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/11.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemberCheckReportVC.h"
#import "CPMemberCheckReportInfoCell.h"
#import "CPMemberReportResultModel.h"
#import "CPMemeberCheckQuestionCell.h"
#import "CPMemberCheckOKCell.h"

@interface CPMemberCheckReportVC ()

@property (nonatomic, strong) CPMemberReportResultModel *model;

@end

@implementation CPMemberCheckReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"验机报告"];
    
    self.dataArray = @[
                       @[@""],
                       @[@""]
                       ];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 + self.model.checkjson.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 1;
    } else {
        
        CPMemberReportResultCheckjson *model = self.model.checkjson[section - 1];
        return model.data.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDLogInfo(@"-------------------------:%@",@(indexPath.section));
    switch (indexPath.section) {
        case 0:
            return 60;
            break;
        default:
        {
            CPMemberReportResultCheckjson *model = self.model.checkjson[indexPath.section - 1];
            CPMemberReportResultJsonData *data = model.data[indexPath.row];
            
            if (data.checkcfg == 0) {
                return CELL_HEIGHT_F;
            } else {
                return 100;
            }
        }
            break;
    }
    
    return CELL_HEIGHT_F;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (1 == section) {
        return CELL_HEIGHT_F;
    }
    
    return 0.000000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (0 == section) {
        return cellSpaceOffset;
    }
    return 0.000000001;
}

#pragma mark - uitableview Datasouce && delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 < indexPath.section) {
        CPMemberReportResultCheckjson *model = self.model.checkjson[indexPath.section - 1];
        CPMemberReportResultJsonData *data = model.data[indexPath.row];
        if (data.checkcfg == 1) {
            return [self configCheckQuestionCell:indexPath];
        } else {
            return [self configCheckOKCell:indexPath];
        }
            
    }
    return [self configBaseInfoCell:indexPath];
}

- (CPMemberCheckReportInfoCell *)configBaseInfoCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CPMemberCheckReportInfoCell";
    
    CPMemberCheckReportInfoCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell =[[CPMemberCheckReportInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.model = self.model;
    
    return cell;
    
}

- (CPMemeberCheckQuestionCell *)configCheckQuestionCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CPMemeberCheckQuestionCell";
    
    CPMemeberCheckQuestionCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell =[[CPMemeberCheckQuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    CPMemberReportResultCheckjson *model = self.model.checkjson[indexPath.section - 1];
    cell.model = model.data[indexPath.row];

    return cell;
    
}

- (CPMemberCheckOKCell *)configCheckOKCell:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CPMemberCheckOKCell";
    
    CPMemberCheckOKCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[CPMemberCheckOKCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CPMemberReportResultCheckjson *model = self.model.checkjson[indexPath.section - 1];
    cell.model = model.data[indexPath.row];

    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (1 != section) {
        return nil;
    }
    
    NSString *headerIdentifier = @"Header";
    
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    CPLabel *titleLB  = [header.contentView viewWithTag:CPBASETAG];
    if (nil == header) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentifier];
        header.contentView.backgroundColor = UIColor.whiteColor;
        
        titleLB = [CPLabel new];
        titleLB.text = @"验货信息";
        [header.contentView addSubview:titleLB];
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(header.contentView.mas_centerX);
            make.centerY.mas_equalTo(header.contentView.mas_centerY);
        }];
        
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;
        
        [header.contentView addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(.5);
        }];
    }
    
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

#pragma mark - private method

- (void)loadData {

    __weak typeof(self) weakSelf = self;

    [CPMemberReportResultModel modelRequestWith:DOMAIN_ADDRESS@"/api/Reportresult/getResultCheckInfo"
                       parameters:@{@"resultid" : self.resultid}
                            block:^(id result) {
                                [weakSelf handleLoadDataBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
}

- (void)handleLoadDataBlock:(CPMemberReportResultModel *)result {
    if (!result || ![result isKindOfClass:[CPMemberReportResultModel class]]) {
        return;
    }
    
    self.model = result;
   
    [self.dataTableView reloadData];
}



@end
