//
//  CPShopTabBarController.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/6.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopTabBarController.h"
#import "CPNavigationController.h"
#import "CPShopMainVC.h"
#import "CPLoginVC.h"
#import "CPShopHelpVC.h"
#import "CPShopOrderVC.h"
#import "CPShopAboutVC.h"
#import "CPShippingInformationListVC.h"
#import "CPGoodOrderListVC.h"
#import "CPAssistantOrderListVC.h"
#import "CPAssistantManagerVC.h"
#import "CPWebVC.h"
#import "CPShopAccountManagerVC.h"
#import "CPHelpCenterVC.h"

#import "CPMemeberMainVC.h"
#import "CPRecycleDesVC.h"
#import "CPMemberInfoVC.h"
#import "CPRateControlVC.h"

@interface CPShopTabBarController ()

@end

@implementation CPShopTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CPShopAboutVC *aboutVC = [[CPShopAboutVC alloc] init];
    aboutVC.tabBarItem = [self createTabBarItemWithTitle:@"门店资料" imageName:@"tab_data_default" selectedImage:@"tab_data_pressed"];
    CPNavigationController *aboutNav = [[CPNavigationController alloc] initWithRootViewController:aboutVC];
    
    self.viewControllers = @[aboutNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initializedBaseViewControllersFor:(CPTabVCType)type {
   
    if (type == CPTabVCTypeMemeber || type == CPTabVCTypeSubMember) {
        [self initMemmberTabBar];
        return;
    }
    //  首页
    CPShopMainVC *homeVC = [[CPShopMainVC alloc] init];
    homeVC.tabBarItem = [self createTabBarItemWithTitle:@"首页" imageName:@"tab_home-default" selectedImage:@"tab_home-pressed"];
    CPNavigationController *homeNav = [[CPNavigationController alloc] initWithRootViewController:homeVC];

//    CPShopOrderVC *orderVC = [[CPShopOrderVC alloc] init];
//    orderVC.tabBarItem = [self createTabBarItemWithTitle:@"订单中心" imageName:@"tab_oder_default" selectedImage:@"tab_oder_pressed"];
//    CPNavigationController *orderNav = [[CPNavigationController alloc] initWithRootViewController:orderVC];
//
//    CPShippingInformationListVC *shippingVC = [[CPShippingInformationListVC alloc] init];
//    shippingVC.tabbarType = CPTabBarTypeShippingState;
//    shippingVC.tabBarItem = [self createTabBarItemWithTitle:@"发货信息" imageName:@"tab_car_default" selectedImage:@"tab_car_pressed"];
//    CPNavigationController *shippingNav = [[CPNavigationController alloc] initWithRootViewController:shippingVC];
    CPAssistantManagerVC *orderVC = [[CPAssistantManagerVC alloc] init];
    orderVC.tabBarItem = [self createTabBarItemWithTitle:@"店员管理" imageName:@"tab_shopassistan_default" selectedImage:@"tab_shopassistant-pressed"];
    CPNavigationController *orderNav = [[CPNavigationController alloc] initWithRootViewController:orderVC];
    
    CPHelpCenterVC *helpVC = [[CPHelpCenterVC alloc] init];
//    CPWebVC *shippingVC = [[CPWebVC alloc] init];
//    //    webVC.urlStr = url;
//    shippingVC.shouldHomeItem = NO;
//    shippingVC.contentStr = [CPUserInfoModel shareInstance].helpHtml;
////    shippingVC.title = @"帮助中心";
////    CPShippingInformationListVC *shippingVC = [[CPShippingInformationListVC alloc] init];
////    shippingVC.tabbarType = CPTabBarTypeShippingState;
    helpVC.tabBarItem = [self createTabBarItemWithTitle:@"帮助中心" imageName:@"tab_help_default" selectedImage:@"tab_help_pressed"];
    CPNavigationController *shippingNav = [[CPNavigationController alloc] initWithRootViewController:helpVC];
    
    
//    CPShopAboutVC *aboutVC = [[CPShopAboutVC alloc] init];
//    aboutVC.tabBarItem = [self createTabBarItemWithTitle:@"我的门店资料" imageName:@"tab_data_default" selectedImage:@"tab_data_pressed"];
    CPShopAccountManagerVC *aboutVC = [[CPShopAccountManagerVC alloc] init];
    aboutVC.tabBarItem = [self createTabBarItemWithTitle:@"账户管理" imageName:@"tab_shop_default" selectedImage:@"tab_shop_pressed"];
    CPNavigationController *aboutNav = [[CPNavigationController alloc] initWithRootViewController:aboutVC];

    if (type == CPTabVCTypeShop) {
        self.viewControllers = @[homeNav,orderNav,shippingNav,aboutNav];
//        self.viewControllers = @[homeNav,orderNav,aboutNav];
    } else if (type == CPTabVCTypeAssistant) {
        
//        CPGoodOrderListVC *assistantOrderVC = [[CPGoodOrderListVC alloc] init];
        CPAssistantOrderListVC *assistantOrderVC = [[CPAssistantOrderListVC alloc] init];
        assistantOrderVC.tabBarItem = [self createTabBarItemWithTitle:@"订单查询" imageName:@"tab_oder_default" selectedImage:@"tab_oder_pressed"];
        CPNavigationController *assistantOrderNav = [[CPNavigationController alloc] initWithRootViewController:assistantOrderVC];
        
        aboutVC.tabBarItem = [self createTabBarItemWithTitle:@"我的" imageName:@"tab_help_default" selectedImage:@"tab_help_pressed"];
//        orderVC.tabBarItem = [self createTabBarItemWithTitle:@"订单查询" imageName:@"tab_oder_default" selectedImage:@"tab_oder_pressed"];
       
        self.viewControllers = @[homeNav,assistantOrderNav,aboutNav];
    }
}



/**
 会员主页界面
 */
- (void)initMemmberTabBar {
    
    //  会员-首页
    CPMemeberMainVC *homeVC = [[CPMemeberMainVC alloc] init];
    homeVC.tabBarItem = [self createTabBarItemWithTitle:@"首页" imageName:@"tab_home-default" selectedImage:@"tab_home-pressed"];
    CPNavigationController *homeNav = [[CPNavigationController alloc] initWithRootViewController:homeVC];
    
    //  会员-回收说明
    CPRecycleDesVC *recycleVC = [[CPRecycleDesVC alloc] init];
    recycleVC.tabBarItem = [self createTabBarItemWithTitle:@"回收指南" imageName:@"HelpIcon_unselected" selectedImage:@"HelpIcon_selected"];
    CPNavigationController *recycleNav = [[CPNavigationController alloc] initWithRootViewController:recycleVC];
    
    //  比例调节
    CPRateControlVC *rateControlVC = [[CPRateControlVC alloc] init];
    rateControlVC.tabBarItem = [self createTabBarItemWithTitle:@"比例调节" imageName:@"rate_unselected" selectedImage:@"rate_selected"];
    CPNavigationController *rateControlNav = [[CPNavigationController alloc] initWithRootViewController:rateControlVC];
    //  会员-信息
    CPMemberInfoVC *memberInfoVC = [[CPMemberInfoVC alloc] init];
    memberInfoVC.tabBarItem = [self createTabBarItemWithTitle:@"会员资料" imageName:@"tab_data_default" selectedImage:@"tab_data_pressed"];
    CPNavigationController *memeberInfoNav = [[CPNavigationController alloc] initWithRootViewController:memberInfoVC];
    
    self.viewControllers = @[homeNav,rateControlNav,recycleNav,memeberInfoNav];
}
/**
 * 创建UITabBarItem
 */
- (UITabBarItem *)createTabBarItemWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImageName
{
    UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:title image:[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    barItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName : MainColor} forState:UIControlStateSelected];
    
    return barItem;
}

@end
