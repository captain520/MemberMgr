//
//  ZCBaseVC.m
//  MemberManager
//
//  Created by 王璋传 on 2018/9/12.
//  Copyright © 2018年 王璋传. All rights reserved.
//

#import "ZCBaseVC.h"

@interface ZCBaseVC ()

@end

@implementation ZCBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    DDLogInfo(@"__________  %@  __________",NSStringFromClass(self.class));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
