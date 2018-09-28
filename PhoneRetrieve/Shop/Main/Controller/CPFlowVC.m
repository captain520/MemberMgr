//
//  CPFlowVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/16.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPFlowVC.h"
#import "CPFlowCell.h"
#import "CPFlowModel.h"
#import "CPRetrieveFlowProgressView.h"
#import "CPEvaluatedPriceVC.h"
#import "CPSKUFooter.h"
#import "CPRetrievePriceModel.h"
#import "CPEvaluatedPriceVC.h"

@interface CPFlowVC ()

@property (nonatomic, strong) NSArray <CPFlowModel *> *models;
@property (nonatomic, strong) CPFlowModel *currentModel;
@property (nonatomic, assign) NSUInteger currentStep;
@property (nonatomic, strong) CPRetrieveFlowProgressView *stepView;
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSArray *> *selecteItems;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, strong) NSMutableArray <NSIndexPath *> *firstPageSelectedIndexPaths;

@end

@implementation CPFlowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上一步" style:UIBarButtonItemStylePlain target:self action:@selector(preValueAction:)];
    
    self.dataArray = @[
                       @[@"",@"",@"",@"",@"",@""]
                       ];
    
    self.firstPageSelectedIndexPaths = @[].mutableCopy;
    
    self.selecteItems = @{}.mutableCopy;
    
    [self loadData];
    
    [self.view addSubview:self.stepView];
    [self.nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark - setter && getter method

- (CPRetrieveFlowProgressView *)stepView {
    if (!_stepView) {
        _stepView = [[CPRetrieveFlowProgressView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREENWIDTH, cellSpaceOffset)];
        _stepView.progress = 0.0;
    }
    
    return _stepView;
}

- (UIButton *)nextButton {
    
    if (nil == _nextButton) {
        _nextButton = [UIButton new];
        _nextButton.titleLabel.font = CPFont_L;
        [_nextButton setTitle:@"无以上问题下一步,下一步" forState:0];
        [_nextButton setBackgroundColor:MainColor];
        [_nextButton setTitleColor:UIColor.whiteColor forState:0];
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentModel.itemData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CPItemData *rowModel = self.currentModel.itemData[indexPath.row];
    
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
    
    CPItemData *rowModel = self.currentModel.itemData[indexPath.row];
    cell.model = rowModel;
    
    
    NSArray *selecteItems = [self.selecteItems valueForKey:self.currentModel.reportid];
    cell.shouldHighted = [selecteItems containsObject:cp_int2String(indexPath.row)];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 0;
//    return 370.0f;
//    return self.footerHeight;
    return [self culFooterHeight];
}

- (CGFloat)culFooterHeight {
    
    CGFloat height = 0.0f;
    
    //  WebView的高度
    if (self.currentModel.Description.length > 0) {
        height += cp_getHtmlStringSize(self.currentModel.Description).height;
    }
    
    //  滚屏图片的高度和间隙
    {
        if (self.currentModel.images.count > 0) {
            height += 140. + cellSpaceOffset;
        }
    }
    
    //  链接的高度
    {
        height += CELL_HEIGHT_F + cellSpaceOffset;
    }
    

    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    
    __weak typeof(self) weakSelf = self;
    
    NSString *footerIdneitify = @"CPSKUFooter";
    
    CPSKUFooter *footer = nil;//[tableView dequeueReusableHeaderFooterViewWithIdentifier:footerIdneitify];
    if (!footer) {
        footer = [[CPSKUFooter alloc] initWithReuseIdentifier:footerIdneitify];
        footer.contentView.backgroundColor = UIColor.clearColor;
//        footer.contentView.backgroundColor = UIColor.redColor;
        footer.clipsToBounds = NO;
        footer.actionBlock = ^(CGFloat height) {
//            weakSelf.footerHeight = height;
//            [tableView reloadData];
        };
    }
    
    footer.model = self.currentModel;
//    if (self.currentStep < self.model.skuProperties.count) {
//        footer.model = self.model.skuProperties[self.currentStep];
//    } else {
//        footer.model = (Skuproperties *)self.model.appearanceProperties[self.currentStep - self.model.skuProperties.count + 1];
//    }
    
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.currentStep == 0) {
        if ([self.firstPageSelectedIndexPaths containsObject:indexPath]) {
            [self.firstPageSelectedIndexPaths removeObject:indexPath];
        } else {
            [self.firstPageSelectedIndexPaths addObject:indexPath];
        }
        
        if (self.firstPageSelectedIndexPaths.count > 0) {
            [self.nextButton setTitle:@"下一步" forState:0];
        } else {
            [self.nextButton setTitle:@"无以上问题下一步,下一步" forState:0];
        }
    } else {
        [self.nextButton setTitle:@"下一步" forState:0];
    }

    if (self.currentStep < self.models.count - 1) {
        
        if (self.currentModel.inputtype == 1) {
            [self.selecteItems setObject:@[cp_int2String(indexPath.row)] forKey:self.currentModel.reportid];
            self.currentStep++;
            
        } else if (self.currentModel.inputtype == 2) {
            
            NSMutableArray *selecteItems = @[].mutableCopy;
            NSArray *tempArray = [self.selecteItems valueForKey:self.currentModel.reportid];
            if (tempArray && tempArray.count > 0) {
                [selecteItems addObjectsFromArray:tempArray];
            }
            
            if ([selecteItems containsObject:cp_int2String(indexPath.row)]) {
                [selecteItems removeObject:cp_int2String(indexPath.row)];
            } else {
                [selecteItems addObject:cp_int2String(indexPath.row)];
            }
            
            [self.selecteItems setObject:selecteItems forKey:self.currentModel.reportid];
        }

        [self cp_updateUI];
        
    } else {
        
        if (self.currentModel.inputtype == 1) {
            [self.selecteItems setObject:@[cp_int2String(indexPath.row)] forKey:self.currentModel.reportid];
//            self.currentStep++;
            
        } else if (self.currentModel.inputtype == 2) {
            
            NSMutableArray *selecteItems = @[].mutableCopy;
            NSArray *tempArray = [self.selecteItems valueForKey:self.currentModel.reportid];
            if (tempArray && tempArray.count > 0) {
                [selecteItems addObjectsFromArray:tempArray];
            }
            
            if ([selecteItems containsObject:cp_int2String(indexPath.row)]) {
                [selecteItems removeObject:cp_int2String(indexPath.row)];
            } else {
                [selecteItems addObject:cp_int2String(indexPath.row)];
            }
            
            [self.selecteItems setObject:selecteItems forKey:self.currentModel.reportid];
        }
        
//        [self cp_updateUI];
        [self valuePrice];
//        CPEvaluatedPriceVC *vc = [[CPEvaluatedPriceVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - private method

- (void)loadData {
    
    self.currentStep = 0;
    [self.selecteItems removeAllObjects];
    
    NSString *urlStr = DOMAIN_ADDRESS@"/api/Report/findReportData";
    __weak typeof(self) weakSelf = self;
    
    [CPFlowModel modelRequestWith:urlStr
                       parameters:@{@"goodsid" : self.goodid}
                            block:^(id result) {
                                [weakSelf handleFLowModelBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
}

- (void)handleFLowModelBlock:(NSArray <CPFlowModel *> *)result {
    DDLogInfo(@"------------------------------");
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        self.models = nil;
        
        return;
    }
    
    self.models = result;
    
//    [self.models enumerateObjectsUsingBlock:^(CPFlowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.descriptionclickurl = @"https://www.baidu.com";
//    }];
    
    self.currentStep = 0;

    [self cp_updateUI];
}

- (void)cp_updateUI {
    
    self.currentModel = self.models[self.currentStep];
    
    self.nextButton.hidden = self.currentModel.inputtype == 1;
    
    [self setTitle:self.currentModel.name];

    [self.dataTableView reloadData];
    
    self.stepView.progress = 1.0 */*self.currentModel.reportid.integerValue */(_currentStep + 1)/ self.models.count;
    
    [self.dataTableView bringSubviewToFront:self.nextButton];
    
    [self.view bringSubviewToFront:self.stepView];
    
    self.dataTableView.frame = CGRectMake(0, NAV_HEIGHT + 30.0f, SCREENWIDTH, SCREENHEIGHT - 30.0f - NAV_HEIGHT * 2);
    
    [self.view bringSubviewToFront:self.nextButton];
    
    self.view.backgroundColor = self.dataTableView.backgroundColor;
}

- (void)preValueAction:(id)sender {
    if (self.currentStep == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        self.currentStep--;
        [self cp_updateUI];
    }
}

#pragma mark - private method

- (void)valuePrice {
    
    NSString *urlStr = DOMAIN_ADDRESS@"/api/Reportresult/insertResult";
    DDLogInfo(@"%@",self.selecteItems);
    
    NSMutableArray *dataArray = @[].mutableCopy;
    
    [self.selecteItems enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key0, NSArray <NSString *> * obj0, BOOL * _Nonnull stop) {
        
        [self.models enumerateObjectsUsingBlock:^(CPFlowModel * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop) {
            if ([obj1.reportid isEqualToString:key0]) {
                
                NSMutableDictionary *tempDict = @{}.mutableCopy;
                [tempDict setObject:obj1.reportid forKey:@"reportid"];
                [tempDict setObject:obj1.name forKey:@"name"];
                
                NSMutableArray *tempArray = @[].mutableCopy;
                [obj0 enumerateObjectsUsingBlock:^(NSString * _Nonnull obj2, NSUInteger idx, BOOL * _Nonnull stop) {
                    CPItemData *item = obj1.itemData[obj2.integerValue];
                    [tempArray addObject:@{@"reportitemid" : item.reportitemid,
                                           @"name" : item.name
                                           }];
                }];

                [tempDict setObject:tempArray forKey:@"data"];
                
                [dataArray addObject:tempDict];

                *stop = YES;
            }
        }];

    }];

    NSString *jsonStr = cp_jsonString(dataArray);

    NSMutableDictionary *params = @{
                                    @"userid" : @([CPUserInfoModel shareInstance].loginModel.ID),
                                    @"username" : [CPUserInfoModel shareInstance].loginModel.linkname,
                                    @"goodsid" : self.goodid,
                                    @"repaircfg" : [CPUserInfoModel shareInstance].repaircfg,//@"1",
                                    @"resultjson" : jsonStr
                                    }.mutableCopy;
    

    __weak CPFlowVC *weakSelf = self;
    
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
    vc.revalueActionBlock = ^{
        [weakSelf loadData];
    };
    vc.model = result;
    vc.itemDicts = items;
    vc.title = self.deviceName;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)nextAction:(UIButton *)sender {
    self.currentStep++;
    [self cp_updateUI];
}

@end
