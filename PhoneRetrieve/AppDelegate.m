//
//  AppDelegate.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "AppDelegate.h"
#import <UMPush/UMessage.h>
#import <UMCommon/UMCommon.h>
#import <UserNotifications/UserNotifications.h>
#import "CPUpdateVersionModel.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) CPUpdateVersionModel *checkVersionModel;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    Byte test = 200;
    

    printf("\033[31mThis text is red \033[0mThis text has default color\n");

    [self setUINavigatinoBarProperities];
    
    [self configLogColors];

    [self configUMPush:launchOptions];
    
    DDLogInfo(@"------------------------------%d",test);

    DDLogError(@"错误信息"); // 红色

    DDLogWarn(@"警告"); // 橙色

    DDLogInfo(@"提示信息"); // 默认是黑色

    DDLogVerbose(@"详细信息"); // 默认是黑色
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self checkUpdateVersion];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return YES;
}

// iOS 8 及以下请用这个
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

    return YES;
}

// iOS 9 以上请用这个
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {

    return YES;
}

/**
 *  初始化导航条
 */
- (void)setUINavigatinoBarProperities {
    
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    //    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:UIColor.whiteColor];
    //
    [[UINavigationBar appearance] setBackIndicatorImage:[[UIImage imageNamed:@"left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[[UIImage imageNamed:@"left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-100, 0) forBarMetrics:UIBarMetricsDefault];
    
    //    [[UINavigationBar appearance] setClipsToBounds:YES];
//        [[UINavigationBar appearance] setTranslucent:NO];
    
    //
    //    [[UINavigationBar appearance] setTranslucent:NO];//设置为不透明
    //
    NSDictionary *titleTextAttributes = @{NSForegroundColorAttributeName:C33,NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    [[UINavigationBar appearance] setTitleTextAttributes:titleTextAttributes];

    
    //    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
}

- (void)configLogColors {
//    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:UIColor.whiteColor backgroundColor:UIColor.redColor forFlag:DDLogFlagError];
    [[DDTTYLogger sharedInstance] setForegroundColor:UIColor.greenColor backgroundColor:nil forFlag:DDLogFlagInfo];
}

- (void)configUMPush:(NSDictionary *)launchOptions {
    
    [UMConfigure initWithAppkey:@"5ad5f252b27b0a412400000d" channel:@"App Store"];
    
    // Push组件基本功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    [UNUserNotificationCenter currentNotificationCenter].delegate=self;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions
                                                       Entity:entity
                                            completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                                if (granted) {
                                                }else{
                                                }
                                            }];
    
    
}

//iOS10以下使用这两个方法接收通知
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
    }
    completionHandler(UIBackgroundFetchResultNewData);
}
//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        //应用处于前台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于前台时的本地推送接受
    }
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}
//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于后台时的本地推送接受
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //    DDLogInfo(@"%@",[deviceToken description]);
    DDLogInfo(@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                      stringByReplacingOccurrencesOfString: @">" withString: @""]
                     stringByReplacingOccurrencesOfString: @" " withString: @""]);
    NSString *push_token = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                             stringByReplacingOccurrencesOfString: @">" withString: @""]
                            stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    [CPUserInfoModel shareInstance].push_token = push_token;
    [CPRegistParam shareInstance].push_token = push_token;
}

- (void)checkUpdateVersion {
    
    
    __weak typeof(self) weakSelf = self;
    
    NSDictionary *params = @{
                             @"clientcfg" : @"2",
                             @"typecfg" : @"1"
                             };
    
    [CPUpdateVersionModel modelRequestWith:DOMAIN_ADDRESS@"/api/version/getLastVersion"
                       parameters:params
                            block:^(CPUpdateVersionModel *result) {
                                [weakSelf handlecheckUpdateVersionBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];

}

- (void)handlecheckUpdateVersionBlock:(CPUpdateVersionModel *)result {
    if (!result || ![result isKindOfClass:[CPUpdateVersionModel class]]) {
        return;
    }
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if ([app_Version isEqualToString:result.name]) {
        return;
    }
    
    self.checkVersionModel = result;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:result.Description
                                                       delegate:self
                                              cancelButtonTitle:@"立即升级"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSURL *url = [NSURL URLWithString:self.checkVersionModel.url];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
