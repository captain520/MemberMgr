//
//  ZCMemeberSearchVC.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/9/17.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "ZCMemeberSearchVC.h"

@interface ZCMemeberSearchVC ()

@end

@implementation ZCMemeberSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.searchController setActive:YES];
    self.searchController.searchBar.text = @"all";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    DDLogInfo(@"%s",__FUNCTION__);
}
- (void)didDismissSearchController:(UISearchController *)searchController {
    DDLogInfo(@"%s",__FUNCTION__);
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
