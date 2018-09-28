//
//  CPResultVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/26.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPResultVC.h"
#import "CPGoodModel.h"

@interface CPResultVC ()

@end

@implementation CPResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = @[
//                       @[@"123"],
//                       @[@"123"]
                       ];
    
    [self loadData];
}

- (void)updateWithDataArray:(NSArray *)dataArray {
    self.dataArray = dataArray;
    
    [self.dataTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"CellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    CPGoodModel *model = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.text = model.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    !self.actionBlock ? : self.actionBlock();
    
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = UIColor.whiteColor;
//
//    UINavigationController *nav = [UIApplication sharedApplication].keyWindow.rootViewController;
//
//    [nav pushViewController:vc animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
