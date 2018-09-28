//
//  CPAssistantDetailVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPAssistantDetailVC.h"
#import "CPTitleDetailCell.h"
#import "CPIDIV.h"
#import "CPUserDetailInfoModel.h"

@interface CPAssistantDetailVC ()

@property (nonatomic, strong) NSArray *tempDataArray;
@property (nonatomic, strong) CPUserDetailInfoModel *model;

@end

@implementation CPAssistantDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = @[
                       @[@"姓名：",@"联系电话：",@"密码：",@"店员编号："]
                       ];
    
    self.tempDataArray = @[
                           @[@"粥粥",@"1781267632",@"*******",@"983881283"]
                           ];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return cellSpaceOffset;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 200.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NSString *headerIdentify = @"CPIDIV";
    
    CPIDIV *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentify];
    if (!header) {
        header = [[CPIDIV alloc] initWithReuseIdentifier:headerIdentify];
    }
    
    header.model = self.model;

    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell = nil;
    switch (indexPath.section) {
        case 0:
        {
            return [self configOrderNoCell:indexPath];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
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
//
//    switch (indexPath.row) {
//        case 0:
//
//            break;
//
//        default:
//            break;
//    }
    
    cell.content = self.tempDataArray[indexPath.section][indexPath.row];
    
//    cell.actionBT.hidden = !(indexPath.section == 1 && indexPath.row == 1);
//    [cell.actionBT addTarget:self action:@selector(push2ConsignStateVC) forControlEvents:64];
    
    return cell;
}

- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    
    [CPUserDetailInfoModel modelRequestWith:CPURL_USER_GET_USER_DETAIL_INFOMATION
                                 parameters:@{@"userid" : self.userid}
                                      block:^(CPUserDetailInfoModel *result) {
                                          [weakSelf handleLoadDataSuccessBlock:result];
                                      } fail:^(CPError *error) {
                                          
                                      }];
}

- (void)handleLoadDataSuccessBlock:(CPUserDetailInfoModel *)result {
    
    if (!result && ![result isKindOfClass:[CPUserDetailInfoModel class]]) {
        
        [self.view makeToast:result.msg duration:1.0f position:CSToastPositionCenter];
        return;
    }

    self.model = result;
    
    self.tempDataArray = @[
                          @[self.model.linkname,self.model.phone,@"**********",self.model.cpcode]
                           ];
    
    [self.dataTableView reloadData];
}

@end
