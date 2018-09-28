//
//  CPConsignStateVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPConsignStateVC.h"
#import "CPTitleDetailCell.h"
#import "CPLeftRightCell.h"

@interface CPConsignStateVC ()

@property (nonatomic, strong) NSArray *tempDataArray;

@end

@implementation CPConsignStateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = @[
                       @[@"交易单号:",@"物流公司:",@"物流单号:"],
                       @[@"离开湖南开往深圳",@"离开湖南开往深圳",@"离开湖南开往深圳",@"离开湖南开往深圳",@"离开湖南开往深圳"]
                       ];
    self.tempDataArray = @[
                           @[@"9878899900",@"顺丰快递",@"SF10032993332"],
                           @[@"2018-01-21 12:21",@"2018-01-21 12:21",@"2018-01-21 12:21",@"2018-01-21 12:21",@"2018-01-21 12:21"]
                           ];
    
    self.dataTableView.separatorColor = UIColor.clearColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        return [self configOrderNoCell:indexPath];
    } else {
        return [self configConsignFlowCell:indexPath];
    }
    
    return [self configOrderNoCell:indexPath];
}

- (id)configOrderNoCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPTitleDetailCell";
    
    CPTitleDetailCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CPTitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shouldShowBottomLine = NO;
    }
    
    NSArray *tempArray = self.dataArray[indexPath.section];
    
    cell.title = [tempArray objectAtIndex:indexPath.row];;
    cell.content = self.tempDataArray[indexPath.section][indexPath.row];
    
//    cell.actionBT.hidden = !(indexPath.section == 1 && indexPath.row == 1);
//    [cell.actionBT addTarget:self action:@selector(push2ConsignStateVC:) forControlEvents:64];
    
    return cell;
}

- (id)configConsignFlowCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPTitleDetailCell";
    
    CPLeftRightCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CPLeftRightCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shouldShowBottomLine = NO;
    }
    
    NSArray *tempArray = self.dataArray[indexPath.section];
    
    cell.title = [tempArray objectAtIndex:indexPath.row];;
    cell.subTitle = self.tempDataArray[indexPath.section][indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *headerIdentifier = @"header";
    
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentifier];
        header.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
@end
