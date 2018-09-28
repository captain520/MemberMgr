//
//  CPBaseVC.m
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/8.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "CPBaseVC.h"
#import "CPConfigUrlModel.h"

@interface CPBaseVC ()

@end

@implementation CPBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
//    self.hidesBottomBarWhenPushed = YES;
    
//    [self loadCustomNav];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"left") style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"tab_home-default") style:UIBarButtonItemStyleDone target:self action:@selector(push2MainPage)];
    
    DDLogInfo(@"**********>Class:%@<**********",NSStringFromClass(self.class));
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"left") style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight | UIRectEdgeBottom;
}

- (void)loadCustomNav {
    
    UIButton *customView = [[UIButton alloc] initWithFrame:CGRectZero];
    [customView addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [customView setImage:CPImage(@"back") forState:UIControlStateNormal];
    [customView setImageEdgeInsets:UIEdgeInsetsMake(8, -10, 8, 0)];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:customView];
    
    self.navigationItem.leftBarButtonItem = item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
}

- (void)push2VCWith:(NSString *)className title:(NSString *)title {
    
    Class c = NSClassFromString(className);
    
    UIViewController *vc    = c.new;
    vc.title = title;
    vc.hidesBottomBarWhenPushed = YES;
//    vc.view.backgroundColor = UIColor.whiteColor;
    
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)push2MainPage {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)getConfigUrl:(NSString *)code block:(void (^)(NSString *url,NSString *title))block {
    
    [CPConfigUrlModel modelRequestWith:DOMAIN_ADDRESS@"/api/sysconfig/getSysConfigByCode"
                            parameters:@{@"code" : code}
                                 block:^(CPConfigUrlModel *result) {
                                     !block ? : block(result.Description, result.title);
                                 } fail:^(CPError *error) {
                                     
                                 }];
}

- (void)getHelpDetail:(NSString *)detailID block:(void (^)(NSString *url,NSString *title))block {
    
    [CPConfigUrlModel modelRequestWith:DOMAIN_ADDRESS@"/api/sysconfig/getHelpDetail"
                            parameters:@{@"id" : detailID}
                                 block:^(CPConfigUrlModel *result) {
                                     !block ? : block(result.Description, result.title);
                                 } fail:^(CPError *error) {
                                     
                                 }];
}

@end
