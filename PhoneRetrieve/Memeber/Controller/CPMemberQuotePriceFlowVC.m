//
//  CPMemberQuotePriceFlowVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/10.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemberQuotePriceFlowVC.h"
#import "CPFlowCell.h"
#import "CPSKUFooter.h"
#import "CPRetrievePriceModel.h"
#import "CPEvaluatedPriceVC.h"

@interface CPMemberQuotePriceFlowVC ()

@property (nonatomic, strong) NSMutableArray <NSIndexPath *> *selectedIndexPaths;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation CPMemberQuotePriceFlowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialzedBaseProperties];
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshActino:) name:@"RefreshQuoteFlow" object:nil];
}

- (void)initialzedBaseProperties {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"left") style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    self.selectedIndexPaths = @[].mutableCopy;
    
    self.title = self.currentMainModel.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter && getter method implement

- (UIButton *)nextButton {
    
    if (nil == _nextButton) {
        _nextButton = [UIButton new];
        _nextButton.titleLabel.font = CPFont_L;
        [_nextButton setTitle:@"无以上问题直接下一步" forState:0];
        [_nextButton setBackgroundColor:MainColor];
//        [_nextButton setBackgroundColor:UIColor.redColor];
        [_nextButton setTitleColor:UIColor.whiteColor forState:0];
        [_nextButton setHidden:YES];
        [_nextButton addTarget:self action:@selector(nextAction:) forControlEvents:64];

        [self.view addSubview:_nextButton];
        
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(0);
            make.height.mas_equalTo(CELL_HEIGHT_F * 3 / 2);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
    }
    
    return _nextButton;
}

#pragma mark - UITabelViewDelegate && datasouce method implement
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentMainModel.itemData.count;;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CPItemData *rowModel = self.currentMainModel.itemData[indexPath.row];

    if (rowModel.tips) {
        return 70.0f;
    } else if (rowModel.typecfg == 2) {
        return 120;
    }
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self configFlowCell:indexPath];
}
- (id)configFlowCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPFlowCell";
    
    CPFlowCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CPFlowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shouldShowBottomLine = NO;
        cell.backgroundColor = self.dataTableView.backgroundColor;
    }
    
    CPItemData *rowModel = self.currentMainModel.itemData[indexPath.row];
    cell.model = rowModel;
    
    cell.shouldHighted = [self.selectedIndexPaths containsObject:indexPath];
//    cell.shouldHighted = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.currentMainModel.tips.length > 0 ? CELL_HEIGHT_F : cellSpaceOffset;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (self.currentMainModel.tips.length > 0) {
        
        NSString *headerIdentifier = @"headerIdentifier";
        
        UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
        CPLabel *titleLB = [header.contentView viewWithTag:CPBASETAG];
        if (!header) {
            header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentifier];
//            header.contentView.backgroundColor = UIColor.whiteColor;
            
            if (!titleLB) {
                titleLB = [CPLabel new];
                titleLB.tag = CPBASETAG;
                titleLB.textColor = UIColor.redColor;
                titleLB.text = self.currentMainModel.tips;
                [header.contentView addSubview:titleLB];
                [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(cellSpaceOffset);
                    make.right.mas_equalTo(-cellSpaceOffset);
                    make.centerY.mas_equalTo(header.contentView.mas_centerY);
                }];
            }
            
        }
        
        return header;
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self culFooterHeight];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    NSString *footerIdneitify = @"CPSKUFooter";
    
    CPSKUFooter *footer = nil;
    if (!footer) {
        footer = [[CPSKUFooter alloc] initWithReuseIdentifier:footerIdneitify];
        footer.contentView.backgroundColor = UIColor.clearColor;
        footer.clipsToBounds = NO;
    }
    
    footer.model = self.currentMainModel;

    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDLogInfo(@"------------------------------");
    CPItemData *itemModel = self.currentMainModel.itemData[indexPath.row];
    
    if (self.currentMainModel.inputtype == 1) {
        //        单选
        self.selectedIndexPaths = @[indexPath].mutableCopy;
        
        [[CPMemberQuoteManager shareInstance].singlebQuoteFlowDataDict setObject:itemModel forKey:itemModel.reportid];
        
        [self loadNextQuoteFlowItem:indexPath.row];
        
    } else if (self.currentMainModel.inputtype == 2) {
        //        多选
        if ([self.selectedIndexPaths containsObject:indexPath]) {
            [self.selectedIndexPaths removeObject:indexPath];
            //  取消移除选中
            [[CPMemberQuoteManager shareInstance].mutipleQuoteFlowDataDict removeObjectForKey:itemModel.reportitemid];
        } else {
            //  保存选中
//            [[CPMemberQuoteManager shareInstance].mutipleQuoteFlowDataDict removeObjectForKey:itemModel.reportitemid];
            [self.selectedIndexPaths addObject:indexPath];
            [[CPMemberQuoteManager shareInstance].mutipleQuoteFlowDataDict setObject:itemModel forKey:itemModel.reportitemid];
        }
    }
    
    [tableView reloadData];
    [self updateActionUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - private method

- (CGFloat)culFooterHeight {
    
    CGFloat height = 0.0f;
    
    //  WebView的高度
    if (self.currentMainModel.Description.length > 0) {
        height += cp_getHtmlStringSize(self.currentMainModel.Description).height;
    }
    
    //  滚屏图片的高度和间隙
    {
        if (self.currentMainModel.images.count > 0) {
            height += 140. + cellSpaceOffset;
        }
    }
    
    //  链接的高度
    {
        height += CELL_HEIGHT_F + cellSpaceOffset;
    }
    
    
    return height;
}

- (void)loadData {
    [self.dataTableView reloadData];
    [self updateActionUI];
}

/**
 * 刷新操作按钮
 */
- (void)updateActionUI {
    if (self.currentMainModel.inputtype == 1) {
        return;
    }
    
    self.nextButton.hidden = NO;
    self.dataTableView.frame = CGRectMake(0, NAV_HEIGHT + 30.0f, SCREENWIDTH, SCREENHEIGHT - 30.0f - NAV_HEIGHT * 2);
    
    if (self.selectedIndexPaths.count > 0) {
        [self.nextButton setTitle:@"下一步" forState:0];
    } else {
        [_nextButton setTitle:@"无以上问题直接下一步" forState:0];
    }
}

- (void)nextAction:(id)sender {
    
    CPFlowModel *model = nil;
    if ([CPMemberQuoteManager shareInstance].mainQuoteFlowDataArray.count > self.currentMainStep + 1) {
        model = [CPMemberQuoteManager shareInstance].mainQuoteFlowDataArray[self.currentMainStep + 1];
        
        CPMemberQuotePriceFlowVC *vc = [[CPMemberQuotePriceFlowVC alloc] init];
        vc.currentMainModel = model;
        vc.currentMainStep = self.currentMainStep + 1;
        
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        //TODO: 价格评估
        
        [self.view makeToast:@"进行价格评估" duration:1.0f position:CSToastPositionCenter];
        [self valuePrice];
        
    }
}

- (void)loadNextQuoteFlowItem:(NSInteger)index {
    
    NSString *urlStr = DOMAIN_ADDRESS@"/api/Report/findUserReportData";
    __weak typeof(self) weakSelf = self;
    
    CPItemData *item = self.currentMainModel.itemData[index];
    if (item.reportitemid.integerValue > 0) {
        //       有子流程
        [CPFlowModel modelRequestWith:urlStr
                           parameters:@{@"goodsid" : @(self.currentMainModel.goodsid),
                                        @"report_item_id" : item.reportitemid
                                        }
                                block:^(id result) {
                                    [weakSelf handleLoadNextQuoteFlowItem:result];
                                } fail:^(CPError *error) {
                                    
                                }];
    } else {
        //       没有子流程
        [self nextAction:nil];
    }
    
}

- (void)handleLoadNextQuoteFlowItem:(NSArray <CPFlowModel *> *)result {
    
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        
        [self nextAction:nil];

        return;
    }
    
    //    将流程的标题赋值给选项parentName;
    [result enumerateObjectsUsingBlock:^(CPFlowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.itemData enumerateObjectsUsingBlock:^(CPItemData * _Nonnull subObj, NSUInteger subIdx, BOOL * _Nonnull stop) {
            subObj.parentName = obj.name;
        }];
    }];
    
    
    CPMemberQuotePriceFlowVC *vc = [[CPMemberQuotePriceFlowVC alloc] init];
    vc.currentMainModel = result.firstObject;
    vc.currentMainStep = self.currentMainStep;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)valuePrice {
    
    NSString *urlStr = DOMAIN_ADDRESS@"/api/Reportresult/insertUserResult";

    NSMutableArray *dataArray = @[].mutableCopy;
    
    NSMutableDictionary *mutipleSelectedDict = @{}.mutableCopy;
    [[CPMemberQuoteManager shareInstance].mutipleQuoteFlowDataDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, CPItemData *obj, BOOL * _Nonnull stop) {
        [mutipleSelectedDict setObject:obj forKey:obj.reportid];
    }];
    
    [mutipleSelectedDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, CPItemData *obj, BOOL * _Nonnull stop) {
        NSMutableDictionary *tempDict = @{}.mutableCopy;
        
        [tempDict setObject:obj.reportid forKey:@"reportid"];
        [tempDict setObject:obj.parentName forKey:@"name"];
        [tempDict setObject:obj.reportitemid forKey:@"reportitemid"];
        
        NSMutableArray *tempArray = @[].mutableCopy;
        [[CPMemberQuoteManager shareInstance].mutipleQuoteFlowDataDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, CPItemData *obj1, BOOL * _Nonnull stop) {
            NSMutableDictionary *itemTempDict = @{}.mutableCopy;
            
            [itemTempDict setObject:obj1.reportitemid forKey:@"reportitemid"];
            [itemTempDict setObject:obj1.name forKey:@"name"];
            
            [tempArray addObject:itemTempDict];
        }];
        
        [tempDict setObject:tempArray forKey:@"data"];
        
        [dataArray addObject:tempDict];
    }];

    
    
    NSMutableDictionary *selectedDict = [CPMemberQuoteManager shareInstance].singlebQuoteFlowDataDict;
    
    [selectedDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, CPItemData *obj, BOOL * _Nonnull stop) {
        NSMutableDictionary *tempDict = @{}.mutableCopy;
        
        [tempDict setObject:obj.reportid forKey:@"reportid"];
        [tempDict setObject:obj.parentName forKey:@"name"];
        [tempDict setObject:obj.reportitemid forKey:@"reportitemid"];
        
        NSMutableArray *tempArray = @[].mutableCopy;
        [selectedDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key1, CPItemData *obj1, BOOL * _Nonnull stop1) {
            NSMutableDictionary *itemTempDict = @{}.mutableCopy;
            if ([obj1.reportid isEqualToString:obj.reportid]) {
                [itemTempDict setObject:obj1.reportitemid forKey:@"reportitemid"];
                [itemTempDict setObject:obj1.name forKey:@"name"];
                
                [tempArray addObject:itemTempDict];
            }

        }];
        
        [tempDict setObject:tempArray forKey:@"data"];
        
        [dataArray addObject:tempDict];
    }];

    
    NSString *jsonStr = cp_jsonString(dataArray);
    
    NSMutableDictionary *params = @{
                                    @"currentuserid" : @([CPUserInfoModel shareInstance].loginModel.ID),
                                    @"code" : [CPUserInfoModel shareInstance].loginModel.cp_code,
                                    @"goodsid" : [CPMemberQuoteManager shareInstance].goodsid,
                                    @"typeid" : @([CPUserInfoModel shareInstance].loginModel.Typeid),
                                    @"resultjson" : jsonStr
                                    }.mutableCopy;
    
    
    __weak typeof(self) weakSelf = self;
//    [CPRetrievePriceModel modelRequestWith:urlStr
    [CPRetrievePriceModel modelPostRequestWith:urlStr
                                    parameters:params
                                         block:^(CPRetrievePriceModel *result) {
                                             [weakSelf handlePriceBlock:result items:dataArray];
                                         } fail:^(NSError *error) {
                                             
                                         }];
}
- (void)handlePriceBlock:(CPRetrievePriceModel *)result items:(NSArray *)items {
    
    __weak typeof(self) weakSelf = self;
    
    CPEvaluatedPriceVC *vc = [[CPEvaluatedPriceVC alloc] init];
//    vc.revalueActionBlock = ^{
//        [weakSelf loadData];
//    };
    vc.model = result;
    vc.itemDicts = items;
//    vc.title = self.deviceName;

    [self.navigationController pushViewController:vc animated:YES];
}


/**
 * 重写返回方法
 */
- (void)back {
    
    [self.selectedIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CPItemData *itemModel = self.currentMainModel.itemData[obj.row];
        
        if (self.currentMainModel.inputtype == 1) {
            [[CPMemberQuoteManager shareInstance].singlebQuoteFlowDataDict removeObjectForKey:itemModel.reportid];
        } else if (self.currentMainModel.inputtype == 2) {
            [[CPMemberQuoteManager shareInstance].mutipleQuoteFlowDataDict removeObjectForKey:itemModel.reportitemid];
        }
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshActino:(NSNotification *)nfc {
    [self.selectedIndexPaths removeAllObjects];
    [self.dataTableView reloadData];
    [[CPMemberQuoteManager shareInstance].singlebQuoteFlowDataDict removeAllObjects];
    [[CPMemberQuoteManager shareInstance].mutipleQuoteFlowDataDict removeAllObjects];
}

@end
