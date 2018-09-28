//
//  CPMemberQuoteFlowVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/12.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemberQuoteFlowVC.h"
#import "CPFlowCell.h"
#import "CPSKUFooter.h"
#import "CPRetrievePriceModel.h"
#import "CPEvaluatedPriceVC.h"
#import "CPQuoteManager.h"

@interface CPMemberQuoteFlowVC ()

@property (nonatomic, strong) NSMutableArray <NSIndexPath *> *selectedIndexPaths;
@property (nonatomic, strong) UIButton *nextButton;


@end

@implementation CPMemberQuoteFlowVC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    DDLogError(@"~~~~~~~~~~~~~释放实例~~~~~~~~~~~~~~~~~");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentMainModel = [[CPQuoteManager shareInstance] currentFlowModel];
    [CPQuoteManager shareInstance].flowIndex++;

    [self initialzedBaseProperties];
    [self loadData];
}

- (void)initialzedBaseProperties {
    
    self.selectedIndexPaths = @[].mutableCopy;
    
    self.title = self.currentMainModel.name;
}

- (void)viewWillAppear:(BOOL)animated {
    
    DDLogError(@"*****************************");
    [[CPQuoteManager shareInstance] log];
    
    [super viewWillAppear:animated];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *testArray = @[@"000",@"1111",@"2222",@"3333"].mutableCopy;
    NSArray *tempArray = @[@"aaaa",@"bbbb",@"ccccc"];
    [testArray insertObjects:tempArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, tempArray.count)]];
//    DDLogError(@"%@",testArray);
//    DDLogInfo(@"------------------------------");
//    CPItemData *itemModel = self.currentMainModel.itemData[indexPath.row];
    
    if (self.currentMainModel.inputtype == 1) {

        //        单选
        self.selectedIndexPaths = @[indexPath].mutableCopy;

        [self loadNextQuoteFlowItem:indexPath.row];
        
    } else if (self.currentMainModel.inputtype == 2) {
        //        多选
        if ([self.selectedIndexPaths containsObject:indexPath]) {
            [self.selectedIndexPaths removeObject:indexPath];
            //  取消移除选中
        } else {
            //  保存选中
            //            [[CPMemberQuoteManager shareInstance].mutipleQuoteFlowDataDict removeObjectForKey:itemModel.reportitemid];
            [self.selectedIndexPaths addObject:indexPath];
        }
    }

//    [self.selectedIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self.currentMainModel.itemData enumerateObjectsUsingBlock:^(CPItemData * _Nonnull item, NSUInteger itemIdx, BOOL * _Nonnull stop) {
//
//            if (obj.row == itemIdx) {
//                item.isSelected = YES;
//                DDLogError(@"--------------------");
//            } else {
//                item.isSelected = NO;
//                DDLogError(@"**********");
//            }
//        }];
//    }];
//
//    [[CPQuoteManager shareInstance] log];

    [self.currentMainModel.itemData enumerateObjectsUsingBlock:^(CPItemData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        CPItemData *itemModel = self.currentMainModel.itemData[indexPath.row];
        obj.isSelected = NO;
        [self.selectedIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop) {
//            itemModel.isSelected = obj1.row == idx;
            if (obj1.row == idx) {
                obj.isSelected = YES;
                DDLogError(@"--------------------");
            }
        }];
    }];

    [[CPQuoteManager shareInstance] log];
    
    [tableView reloadData];
    [self updateActionUI];
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
    
    if ([[CPQuoteManager shareInstance] canPush]) {
        CPMemberQuoteFlowVC *vc = [[CPMemberQuoteFlowVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self valuePrice];
        [self.view makeToast:@"进行价格评估" duration:1.0f position:CSToastPositionCenter];
    }

//    CPFlowModel *model = nil;
//    if ([CPMemberQuoteManager shareInstance].mainQuoteFlowDataArray.count > self.currentMainStep + 1) {
//        model = [CPMemberQuoteManager shareInstance].mainQuoteFlowDataArray[self.currentMainStep + 1];
//
//        CPMemberQuoteFlowVC *vc = [[CPMemberQuoteFlowVC alloc] init];
//        vc.currentMainModel = model;
////        vc.currentMainStep = self.currentMainStep + 1;
//
//        [self.navigationController pushViewController:vc animated:YES];
//
//    } else {
//        //TODO: 价格评估
//
//        [self.view makeToast:@"进行价格评估" duration:1.0f position:CSToastPositionCenter];
////        [self valuePrice];
//
//    }
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
                                    [weakSelf handleLoadNextQuoteFlowItem:result reportitemid:item.reportitemid];
                                } fail:^(CPError *error) {
                                    
                                }];
    } else {
        //       没有子流程
        [self nextAction:nil];
    }
    
}

- (void)handleLoadNextQuoteFlowItem:(NSArray <CPFlowModel *> *)result reportitemid:(NSString *)reportitemid {
    
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        
        [self nextAction:nil];
        
        return;
    }
    
    self.dataArray = result;
    

    //    将流程的标题赋值给选项parentName;
    [result enumerateObjectsUsingBlock:^(CPFlowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.reportitemid  = reportitemid;
//        [obj.itemData enumerateObjectsUsingBlock:^(CPItemData * _Nonnull subObj, NSUInteger subIdx, BOOL * _Nonnull stop) {
//            subObj.parentName = obj.name;
//        }];
    }];
    
    [[CPQuoteManager shareInstance].flows insertObjects:result atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange([CPQuoteManager shareInstance].flowIndex, result.count)]];
    
    if ([[CPQuoteManager shareInstance] canPush]) {
        CPMemberQuoteFlowVC *vc = [[CPMemberQuoteFlowVC alloc] init];
        vc.dataArray = self.dataArray;

        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self.view makeToast:@"进行价格评估" duration:1.0f position:CSToastPositionCenter];
    }
    
//    CPMemberQuoteFlowVC *vc = [[CPMemberQuoteFlowVC alloc] init];
//    vc.currentMainModel = result.firstObject;
////    vc.currentMainStep = self.currentMainStep;
//
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)valuePrice {
    
    NSString *urlStr = DOMAIN_ADDRESS@"/api/Reportresult/insertUserResult";
    
    NSMutableArray *dataArray = @[].mutableCopy;

    [[CPQuoteManager shareInstance].flows enumerateObjectsUsingBlock:^(CPFlowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        __block NSMutableDictionary *flowDict = nil;

        NSMutableArray *itemDicts = @[].mutableCopy;
        [obj.itemData enumerateObjectsUsingBlock:^(CPItemData * _Nonnull itemObj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (itemObj.isSelected) {
                
                flowDict = @{}.mutableCopy;
                
                [flowDict setObject:obj.reportid forKey:@"reportid"];
                [flowDict setObject:obj.name forKey:@"name"];
                if (obj.reportitemid) {
                    [flowDict setObject:obj.reportitemid forKey:@"reportitemid"];
                } else {
                    [flowDict setObject:@"0" forKey:@"reportitemid"];
                }

                NSMutableDictionary *dict = @{}.mutableCopy;
                
                [dict setObject:itemObj.reportid forKey:@"reportid"];
                [dict setObject:itemObj.name forKey:@"name"];
                [dict setObject:itemObj.reportitemid forKey:@"reportitemid"];
                
                [itemDicts addObject:dict];

                DDLogError(@"%@",itemObj.name);
            }
        }];
        
        if (flowDict) {
            [flowDict setObject:itemDicts forKey:@"data"];
            [dataArray addObject:flowDict];
        }

    }];
    
    NSString *jsonStr = cp_jsonString(dataArray);

    DDLogError(@"%@",jsonStr);

    NSMutableDictionary *params = @{
                                    @"currentuserid" : @([CPUserInfoModel shareInstance].loginModel.ID),
                                    @"code" : [CPUserInfoModel shareInstance].loginModel.cp_code,
                                    @"goodsid" : [CPMemberQuoteManager shareInstance].goodsid,
                                    @"typeid" : @([CPUserInfoModel shareInstance].loginModel.Typeid),
                                    @"resultjson" : jsonStr
                                    }.mutableCopy;
    
    
    __weak typeof(self) weakSelf = self;
    
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
    vc.model     = result;
    vc.itemDicts = items;

    [self.navigationController pushViewController:vc animated:YES];
}


/**
 * 重写返回方法
 */
- (void)back {
    
    [CPQuoteManager shareInstance].flowIndex--;

    if (self.dataArray.count > 0) {
        [[CPQuoteManager shareInstance].flows removeObjectsInArray:self.dataArray];
    }
    
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
}


@end
