//
//  CPRecycleDesVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/4.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRecycleDesVC.h"
#import "CPMemberRecycleDesCell.h"
#import "CPRecycleDesModel.h"
#import "CPWebVC.h"

@interface CPRecycleDesVC ()

@property (nonatomic, strong) NSArray <CPRecycleDesModel *> *models;

@end

@implementation CPRecycleDesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray arrayWithArray:@[
                                                      @[@""],
                                                      @[@""],
                                                      @[@""],
                                                      @[@""]
                                                      ]];

    [self loadData];
    
    self.navigationItem.title = [NSString stringWithFormat:@"会员号：%@",[CPUserInfoModel shareInstance].loginModel.cp_code];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {return self.models.count;};
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return 1;
////    CPRecycleDesModel *model = [self.models objectAtIndex:section];
////
////    return model.cp_data.count;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"";
    
    CPMemberRecycleDesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CPMemberRecycleDesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.shouldShowBottomLine = YES;
    }
    
    if (indexPath.row > 0) {
        cell.imageName = @"right";
        cell.level = 2;
    } else {
        cell.level = 1;
    }
    
    CPRecycleDesModel *model = self.dataArray[indexPath.section][indexPath.row];
    [cell updateTitle:model.title];

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row > 0) {
        //TODO: 跳转到说明对应的网页
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        CPRecycleDesModel *detailModel =  self.dataArray[indexPath.section][indexPath.row];
        [self getHelpDetail:detailModel.ID block:^(NSString *url, NSString *title) {
            CPWebVC *webVC = [[CPWebVC alloc] init];
            webVC.title      = title;
            webVC.contentStr = url;
            webVC.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:webVC animated:YES];
        }];

        return;
    }
    
    CPMemberRecycleDesCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.dataArray[indexPath.section]];
    
    if (tempArray.count > 1) {  // 折叠
        
        cell.isUpDirection = NO;
        
        CPRecycleDesModel *subModel = self.models[indexPath.section];
        
        NSMutableArray *indexPathArray = @[].mutableCopy;
        for (NSInteger i = 0; i < subModel.cp_data.count; ++i) {
            NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:indexPath.row + i + 1 inSection:indexPath.section];
            [indexPathArray addObject:tempIndexPath];
        }
        
        tempArray = @[self.models.firstObject].mutableCopy;
        
        [self.dataArray replaceObjectAtIndex:indexPath.section withObject:tempArray];
        
        [tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } else {    //  展开
        
        cell.isUpDirection = YES;
        
        CPRecycleDesModel *subModel = self.models[indexPath.section];
        
        NSMutableArray *indexPathArray = @[].mutableCopy;
        for (NSInteger i = 0; i < subModel.cp_data.count; ++i) {
            NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:indexPath.row + i + 1 inSection:indexPath.section];
            [indexPathArray addObject:tempIndexPath];
            [tempArray addObject:subModel.cp_data[i]];
        }
        
        [self.dataArray replaceObjectAtIndex:indexPath.section withObject:tempArray];
        
        [tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationMiddle];
    }

}

#pragma mark - private medtho implement
- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    
    [CPRecycleDesModel modelRequestWith:DOMAIN_ADDRESS@"/api/sysconfig/findRecycList?code=160"
                             parameters:nil
                                  block:^(id result) {
                                      [weakSelf handleLoadDataBlock:result];
                                  } fail:^(CPError *error) {
                                      
                                  }];
    
}

- (void)handleLoadDataBlock:(NSArray <CPRecycleDesModel *> *)resut {
    
    if (!resut || ![resut isKindOfClass:[NSArray class]]) {
        return;
    }
    
    self.models = resut;

    [self.dataArray removeAllObjects];
    
    [resut enumerateObjectsUsingBlock:^(CPRecycleDesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *tempArray = @[].mutableCopy;
        [tempArray addObject:obj];
        [self.dataArray addObject:tempArray];
    }];
    
    [self.dataTableView reloadData];
}

@end
