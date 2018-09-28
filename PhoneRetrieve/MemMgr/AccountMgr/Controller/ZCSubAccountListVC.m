//
//  ZCSubAccountListVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/19.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCSubAccountListVC.h"
#import "ZCSubAccountCell.h"

@interface ZCSubAccountListVC ()

@end

@implementation ZCSubAccountListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"子账号管理";
    
    NSMutableArray *tempData = @[].mutableCopy;
    for (NSInteger i = 0; i < 30; ++i) {
        [tempData addObject:@[@"--"]];
    }
    
    self.dataArray = tempData.mutableCopy;
    
    [self loadData];
}

#pragma mark - setter && getter method implement
#pragma mark - setupUI
#pragma mark - delete method implement
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 3 * 30 + 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"ZCSubAccountCell";
    
    ZCSubAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[ZCSubAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SPACE_OFFSET_F;
}
#pragma mark - private method

@end
