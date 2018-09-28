//
//  CPShopAboutVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopAboutVC.h"
#import "CPImageLeftCell.h"
#import "CPShopAboutHeader.h"
#import "CPTitleDetailCell.h"
#import "CPWebVC.h"
#import "CPLoginVC.h"

@interface CPShopAboutVC ()

@end

@implementation CPShopAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = @[
                       @[@"账户管理",@"帮助中心"]
                       ];
    
    if ([CPUserInfoModel shareInstance].isLogined == NO) {
        [self push2LoginVC];
    }
    
    [self loadData];
    
    self.navigationItem.rightBarButtonItem = nil;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"call") style:UIBarButtonItemStylePlain target:self action:@selector(showHelp)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT_F;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CellIdentify";
    
    CPImageLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[CPImageLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
//        cell.contentView.backgroundColor = Ccc;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (0 == indexPath.row) {
        cell.imageName = @"me_icon_Account";
    } else {
        cell.imageName = @"me_icon_help";
    }
    
    cell.title = self.dataArray[indexPath.section][indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    NSString *headerIdenitfier = @"CPShopAboutHeader";
    CPShopAboutHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdenitfier];
    if (!header) {
        header = [[CPShopAboutHeader alloc] initWithReuseIdentifier:headerIdenitfier];
    }

    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self push2VCWith:@"CPShopAccountManagerVC" title:@"账户管理"];
            break;
        case 1:
            [self push2WebView:nil];
            break;
            
            
        default:
            break;
    }
}

//  跳转到网页
- (void)push2WebView:(NSString *)url {
    
    if (url == nil) {
        url = @"https://www.baidu.com";
    }
    
    CPWebVC *webVC = [[CPWebVC alloc] init];
    webVC.urlStr = url;
    webVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:webVC animated:YES];
    
}

- (void)push2LoginVC {
    
    CPLoginVC *vc = [[CPLoginVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)showHelp {
    [self push2VCWith:@"CPShopHelpVC" title:@"我的客服"];
}

@end
