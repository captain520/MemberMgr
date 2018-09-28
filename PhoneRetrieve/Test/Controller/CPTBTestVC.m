//
//  CPTBTestVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/13.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPTBTestVC.h"

@interface CPTBTestVC ()

@end

@implementation CPTBTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = @[
                       @[@""],
                       @[@""],
                       @[@""]
                       ];
    
    self.dataTableView.separatorColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT_F;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *cellIdenitifier = @"CellIdentifier";
//    CPBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenitifier];
//    if (nil == cell) {
//        
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
