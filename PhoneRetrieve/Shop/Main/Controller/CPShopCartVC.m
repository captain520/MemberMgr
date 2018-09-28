//
//  CPShopCartVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopCartVC.h"
#import "CPOrderActionView.h"
#import "CPShopCartCell.h"
#import "CPCartModel.h"
#import "CPConsignDetailVC.h"
#import "CPOrderDetailVC.h"
#import "CPMemberCartCell.h"

@interface CPShopCartVC ()

@property (nonatomic, strong) NSMutableArray *selectedIndexPaths;
@property (nonatomic, strong) CPOrderActionView *actionView;

@end

@implementation CPShopCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.dataArray = @[
//                       @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]
//                       ];
    
    [self initializedBaseProperties];
    [self setupUI];
    
    [self loadData];
}

- (void)initializedBaseProperties {
    self.selectedIndexPaths = @[].mutableCopy;
}

- (void)setupUI {
    
    {
        __weak CPShopCartVC *weakSelf = self;

        self.actionView = [CPOrderActionView new];
//        _actionView.backgroundColor = [UIColor blueColor];
        [self.actionView.selecteAllBT addTarget:self action:@selector(selectAllBTAction:) forControlEvents:64];
        _actionView.actionBlock = ^{
            [weakSelf nextAction];
        };
        [self.view addSubview:_actionView];
        
        [_actionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(2 * CELL_HEIGHT_F);
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.00000000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([CPUserInfoModel shareInstance].loginModel.Typeid > 5) {
        return 2 * CELL_HEIGHT_F + 30;
    }
    
    return 2 * CELL_HEIGHT_F;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2 * CELL_HEIGHT_F;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //  会员回收车
    if ([CPUserInfoModel shareInstance].loginModel.Typeid > 5) {
        return [self configMemeberCarCell:indexPath];
    }
    
    static NSString *identifier = @"CPShopCartCell";
    
    CPShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CPShopCartCell alloc] initWithStyle:0 reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.model = self.dataArray[indexPath.row];

    __weak typeof(self) weakSelf = self;
    cell.hasSelected = [self.selectedIndexPaths containsObject:indexPath];
    cell.actionBlock = ^{
        [weakSelf handleCellActionBlock:indexPath];
    };
    
    return cell;
}

- (CPMemberCartCell *)configMemeberCarCell:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CPMemberCartCell";
    
    CPMemberCartCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CPMemberCartCell alloc] initWithStyle:0 reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.model = self.dataArray[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    cell.hasSelected = [self.selectedIndexPaths containsObject:indexPath];
    cell.actionBlock = ^{
        [weakSelf handleCellActionBlock:indexPath];
    };
    
    return cell;
}

- (void)handleCellActionBlock:(NSIndexPath *)indexPath {
    
    [self.selectedIndexPaths containsObject:indexPath] ?
    [self.selectedIndexPaths removeObject:indexPath] : [self.selectedIndexPaths addObject:indexPath];
    
    [self.dataTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self updateActionView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    [self.selectedIndexPaths containsObject:indexPath] ?
//    [self.selectedIndexPaths removeObject:indexPath] : [self.selectedIndexPaths addObject:indexPath];
//
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//
//    [self updateActionView];
    
    CPCartModel *tempModel = self.dataArray[indexPath.section];

    CPOrderDetailVC *vc = [[CPOrderDetailVC alloc] init];
    vc.orderID = [NSString stringWithFormat:@"%ld",(long)tempModel.ID];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)updateActionView {
    
    __block CGFloat amount = 0.0f;
    
    self.actionView.capacity = self.selectedIndexPaths.count;
    
    [self.selectedIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CPCartModel *mmodel = self.dataArray[obj.row];
        amount +=  mmodel.price.floatValue;
    }];
    
    self.actionView.amount = [NSString stringWithFormat:@"%.2f",amount];
    
    if (self.selectedIndexPaths.count == self.dataArray.count) {
        [self.actionView.selecteAllBT setImage:CPImage(@"Tick_preseed") forState:0];
    } else {
        [self.actionView.selecteAllBT setImage:CPImage(@"Tick_default") forState:0];
    }
}

- (void)nextAction {
    
    if (self.selectedIndexPaths.count == 0) {
        
        [self.view makeToast:@"至少选择一个订单" duration:2.0 position:CSToastPositionCenter];

        return;
    }
    
    NSMutableArray *tempDataArray = @[].mutableCopy;
    [self.selectedIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger row = obj.row;
        [tempDataArray addObject:self.dataArray[row]];
    }];

    CPConsignDetailVC *vc = [[CPConsignDetailVC alloc] init];
    vc.selectedModels = tempDataArray;

    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark + private method

- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    
    NSDictionary *params = @{
                             @"userid" : @([CPUserInfoModel shareInstance].loginModel.ID),
                             @"typeid": @([CPUserInfoModel shareInstance].loginModel.Typeid),
                             @"currentpage" : @"1",
                             @"pagesize" : @"1000"
                             };

    [CPCartModel modelRequestWith:DOMAIN_ADDRESS@"/api/reportresult/findRecycList"
                       parameters:params
                            block:^(NSArray <CPCartModel *> *result) {
                                [weakSelf handleLoadDataSuccessBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
}

- (void)handleLoadDataSuccessBlock:(NSArray <CPCartModel *> *)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        return;
    }
    
    self.dataArray = result;
    
    [self.dataTableView reloadData];
    
    [self.view bringSubviewToFront:self.actionView];
}

- (void)selectAllBTAction:(UIButton *)sender {
    
    if (self.selectedIndexPaths.count == self.dataArray.count) {
        [self.selectedIndexPaths removeAllObjects];
        [self.dataTableView reloadData];
        [self updateActionView];
    } else {
        
        [self.selectedIndexPaths removeAllObjects];
        
        [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [self.selectedIndexPaths addObject:indexPath];
        }];
        
        [self.dataTableView reloadData];
        
        [self updateActionView];
    }
    
}

@end
