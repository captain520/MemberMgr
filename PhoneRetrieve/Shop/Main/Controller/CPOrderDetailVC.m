//
//  CPOrderDetailVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPOrderDetailVC.h"
#import "CPTitleDetailCell.h"
#import "CPEvaluatedTypeHeader.h"
#import "CPEvaluatedContentCell.h"
#import "CPSelectCell.h"
#import "CPRetrieveOrderDetailModel.h"

@interface CPOrderDetailVC ()

@property (nonatomic, strong) NSArray *tempDataArray;
@property (nonatomic, strong) NSMutableArray <NSIndexPath *> *selectedIndexPath;
@property (nonatomic, strong) CPRetrieveOrderDetailModel *detaillModel;
@property (nonatomic, strong) NSMutableArray *itemDatas;

@end

@implementation CPOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"评估详情"];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    DDLogInfo(@"---------%ld-----------%ld",section,[self.dataArray[section] count]);
    return [self.dataArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (0 == section) {
        return cellSpaceOffset;
    } else if(3 == section) {
        return 0.000000001;
    }
    
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (3 == section) {
        return 0.000000001;
    }
    
    return cellSpaceOffset;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (0 == section || 3 == section) {
        return nil;
    }
    
    NSString *headerIdenitfier = @"CPEvaluatedTypeHeader";
    CPEvaluatedTypeHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdenitfier];
    if (!header) {
        header = [[CPEvaluatedTypeHeader alloc] initWithReuseIdentifier:headerIdenitfier];
        header.shouldShowSepLine = NO;
    }
    
    switch (section) {
        case 1:
            header.title = @"手机信息";
            break;
        case 2:
            header.title = @"评估详情";
            break;
        case 3:
            header.title = @"手机操作";
            break;
        case 4:
            header.title = @"客户资料";
            break;
        case 5:
            header.title = @"评估人";
            break;
            
        default:
            break;
    }

    return header;
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return CELL_HEIGHT_F;
            break;
        case 2:
        {
            CGFloat height = 20.0f;
            NSDictionary *itemDict = self.itemDatas[indexPath.row];
            
            NSString *key = [itemDict allKeys].firstObject;
            CGFloat temoHeight = cp_getTextSize(key, (SCREENWIDTH - 3  * cellSpaceOffset)/2, @{NSFontAttributeName : CPFont_M}).height;
            height = MAX(height, ceil(temoHeight / 20.0f) * 20.0f);
            
            NSString *value = [itemDict allValues].firstObject;
            temoHeight = cp_getTextSize(value, (SCREENWIDTH - 3  * cellSpaceOffset)/2, @{NSFontAttributeName : CPFont_M}).height;
//            height = MAX(height, temoHeight);
            height = MAX(height, ceil(temoHeight / 20.0f) * 20.0f);
            
            return height;
        }
            break;
        case 3:
            return 0;
            break;
        default:
            break;
    }
    
    return 30.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell = nil;
    
    switch (indexPath.section) {
        case 0:
        case 1:
        case 4:
        case 5:
            cell = [self configOrderNoCell:indexPath];
            break;
        case 2:
            cell = [self configEvaluatedContentCell:indexPath];
            break;
        case 3:
            cell = [self configDataHandleCell:indexPath];
            break;
            
        default:
            cell = [self configOrderNoCell:indexPath];
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
    cell.content = self.tempDataArray[indexPath.section][indexPath.row];
    
    return cell;
}

- (CPEvaluatedContentCell *)configEvaluatedContentCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"configHintCell";
    
    CPEvaluatedContentCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CPEvaluatedContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
//    if (indexPath.row%2 == 0) {
//        cell.contentView.alpha = 0.5f;
//    } else {
//        cell.contentView.backgroundColor = BgColor;
//        cell.contentView.alpha = 1.f;
//    }
    
    cell.itemDict = self.itemDatas[indexPath.row];

    return cell;
}

- (id)configDataHandleCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"configHintCell";
    
    CPSelectCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CPSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shouldShowBottomLine = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
    }
    cell.hasSelected = YES;
    cell.content = @"备份手机数据,解除ID锁,恢复出厂设置";

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)loadData {
    
    
    __weak typeof(self) weakSelf = self;
    
    NSDictionary *params = @{
                             @"id" : self.orderID
//                             @"id" : @"1"
                             };
    
    [CPRetrieveOrderDetailModel modelRequestWith:CPURL_SHOP_GET_RETRIEVE_DETAIL
                                      parameters:params
                                           block:^(CPRetrieveOrderDetailModel *result) {
                                               [weakSelf handleLoadDataSuccessBlock:result];
                                           } fail:^(CPError *error) {
                                               
                                           }];
}

- (void)handleLoadDataSuccessBlock:(CPRetrieveOrderDetailModel *)result {
    
    if (![result isKindOfClass:[CPRetrieveOrderDetailModel class]]) {
        return;
    }
    
    NSArray *itemDicts = cp_dictionaryWithJsonString(result.resultjson);
    self.itemDatas = @[].mutableCopy;
    
    [itemDicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *tempArray = obj[@"data"];
        [tempArray enumerateObjectsUsingBlock:^(NSDictionary *obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            NSDictionary *tempDict = @{obj[@"name"] : obj1[@"name"]};
            [self.itemDatas addObject:tempDict];
        }];
    }];
    

    self.tempDataArray = @[
                           @[result.resultno],
                           @[result.goodsname,result.price],
                           @[self.itemDatas],
                           @[@""],
                           @[result.customname ? result.customname : @"--",
                             result.customphone ? result.customphone : @"--",
                             result.customphone ? result.customimei : @"--"
                             ],
                           @[[CPUserInfoModel shareInstance].loginModel.linkname,
                             [CPUserInfoModel shareInstance].loginModel.phone,
                             result.createtime]
                           ];
    
    self.dataArray = @[
                       @[@"订单号:"],
                       @[@"手机型号:",@"评估价格:"],
                       self.itemDatas,
                       @[@""],
                       @[@"姓名：",@"联系电话:",@"IMEI:"],
                       @[@"姓名：",@"联系电话:",@"回收时间:"]
                       ];

    self.detaillModel = result;
    [self.dataTableView reloadData];
}
@end
