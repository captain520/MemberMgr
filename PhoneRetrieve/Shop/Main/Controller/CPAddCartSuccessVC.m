//
//  CPAddCartSuccessVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPAddCartSuccessVC.h"
#import "CPShopTabBarController.h"
#import "CPOrderDetailVC.h"
#import "CPConsignResultVC.h"

@interface CPAddCartSuccessVC ()

@property (nonatomic, strong) UIImageView *stateIV;
@property (nonatomic, strong) UILabel *orderNOLB;
@property (nonatomic, strong) UIButton *detailBT;
@property (nonatomic, strong) CPLabel *hintLB;

@end

@implementation CPAddCartSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI {
    
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"tab_home-default") style:UIBarButtonItemStyleDone target:self action:@selector(push2MainPage)];
    }
    
    {
        _stateIV = [UIImageView new];
        _stateIV.image = CPImage(@"complete");
        
        [self.view addSubview:_stateIV];
        
        [_stateIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(CELL_HEIGHT_F + NAV_HEIGHT);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(80, 80));
        }];
    }
    
    {
        _orderNOLB = [UILabel new];
        _orderNOLB.textAlignment = NSTextAlignmentCenter;
        _orderNOLB.textColor = [UIColor redColor];
        if (self.type == CPSucessTypeAddCart) {
            _orderNOLB.text = self.model.resultno;
        } else if (self.type == CPSucessTypeSendGood) {
            _orderNOLB.text = self.shipModel.ordersn;
        }

        [self.view addSubview:_orderNOLB];
        
        [_orderNOLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_stateIV.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
    }
    
    {
        _detailBT = [UIButton new];
        _detailBT.titleLabel.font = CPFont_L;
        [_detailBT addTarget:self action:@selector(push2DetailVC) forControlEvents:64];

        [self.view addSubview:_detailBT];
        
        [_detailBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_orderNOLB.mas_bottom).offset(CELL_HEIGHT_F);
            make.centerX.mas_equalTo(self.view.mas_centerX);
        }];
        
        NSDictionary *option0 = @{
                                  NSFontAttributeName : CPFont_L,
                                  NSForegroundColorAttributeName : C33
                                  };
        NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:@"订单提交成功，您可以"
                                                                                  attributes:option0];
        NSDictionary *option1 = @{
                                  NSFontAttributeName : CPFont_L,
                                  NSForegroundColorAttributeName : C33,
                                  NSUnderlineStyleAttributeName : @1
                                  };
        NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:@"查看详情" attributes:option1];
        
        [attr0 appendAttributedString:attr1];
        
        [_detailBT setAttributedTitle:attr0 forState:0];
    }
    
    {
        _hintLB               = [CPLabel new];
        _hintLB.text          = @"请留意查收本次交易货款!";
        _hintLB.font          = CPFont_L;
        _hintLB.textAlignment = NSTextAlignmentCenter;
        _hintLB.hidden = _type == CPSucessTypeAddCart;;
        [self.view addSubview:_hintLB];
        
        [_hintLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_detailBT.mas_bottom).offset(0);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setType:(CPSucessType)type {
   
    _type = type;
}

#pragma mark - private method
- (void)push2DetailVC {
    
    if (self.type == CPSucessTypeAddCart) {
//        [self push2VCWith:@"CPOrderDetailVC" title:@"评估详情"];
        [self push2RetirveEvaluateDetailVC];
    } else if (self.type == CPSucessTypeSendGood) {
        [self push2ShippingDetail];
    }
}

- (void)push2ShippingDetail {
    
    CPConsignResultVC *vc = [[CPConsignResultVC alloc] init];
    vc.ID = self.shipModel.ID;
    vc.title = @"发货详情";
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)push2MainPage {
//    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj isKindOfClass:[CPShopTabBarController class]]) {
//            [self.navigationController popToViewController:obj animated:YES];
//            *stop = YES;
//        }
//    }];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - private method

- (void)push2RetirveEvaluateDetailVC {
    
    CPOrderDetailVC *vc = [[CPOrderDetailVC alloc] init];
//    vc.model = self.model;
    vc.orderID = self.model.ID;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
