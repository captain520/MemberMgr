//
//  CPSearchResultVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/15.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPSearchResultVC.h"
#import "CPUserSearchResultCell.h"

@interface CPSearchResultVC ()

@end

@implementation CPSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = @[
                       @[
                           @"",
                           @"",
                           @"",
                           @"",
                           @"",
                           @"",
                           @"",
                           ]
                       ].mutableCopy;

    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter && getter method implement
#pragma mark - setupUI
#pragma mark - delete method implement
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPUserSearchResultCell";
    
    CPUserSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[CPUserSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.sortNum = indexPath.row;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    !self.didSelecRow ? : self.didSelecRow(indexPath.row);
}

#pragma mark - private method

- (void)loadData {
    [self.dataTableView reloadData];
}

- (void)refreshTableViewWithDataArray:(NSArray *)dataArray {
    self.dataArray = dataArray.mutableCopy;
    
    [self.dataTableView reloadData];
}

@end
