//
//  CPShopCartCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopCartCell.h"

@implementation CPShopCartCell {
    UIButton *selectBT;
    
    UIImageView *pictureIV;
    CPLabel *nameLB, *priceLB, *orderNoLB, *overdueLB, *timeLB;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupUI {
   
//    selectBT = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CELL_HEIGHT_F, CELL_HEIGHT_F)];
    selectBT = [UIButton new];
//    selectBT.frame = CGRectMake(0, 0, CELL_HEIGHT_F, CELL_HEIGHT_F);
    selectBT.backgroundColor = UIColor.whiteColor;
    [selectBT setImage:CPImage(@"choose_default") forState:0];
//    selectBT.userInteractionEnabled = NO;
    [selectBT addTarget:self action:@selector(selectAction:) forControlEvents:64];
    [self.contentView addSubview:selectBT];
    
    [selectBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(cellSpaceOffset);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(selectBT.mas_height).multipliedBy(0.5f);
//        make.centerY.mas_equalTo(self.contentView.mas_centerY);
//        make.left.mas_equalTo(cellSpaceOffset);
//        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    pictureIV = [UIImageView new];
    pictureIV.image = CPImage(@"hme_iphone");
    [self.contentView addSubview:pictureIV];

    [pictureIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cellSpaceOffset/2);
        make.left.mas_equalTo(selectBT.mas_right).offset(cellSpaceOffset/2);
        make.bottom.mas_equalTo(-cellSpaceOffset/2);
        make.width.mas_equalTo(pictureIV.mas_height);
    }];
    
    //  订单号
    orderNoLB = [CPLabel new];
    orderNoLB.text = @"订单号: 2018272633383";
    [self.contentView addSubview:orderNoLB];
    
    nameLB = [CPLabel new];
    nameLB.text = @"苹果: iPhne 6s Plus (手机)";
    [self.contentView addSubview:nameLB];
    
    
    priceLB = [CPLabel new];
    priceLB.text = @"回收价: ¥1892.00";
    [self.contentView addSubview:priceLB];
    
    {
        NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:@"回收价: " attributes:nil];
        
        NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:@"¥1892.00" attributes:@{NSForegroundColorAttributeName : CPERROR_COLOR}];
        [attr0 appendAttributedString:attr1];
        priceLB.attributedText = attr0;
    }
    

    
    overdueLB = [CPLabel new];
    overdueLB.text = @"失效时间: 5小时";
    overdueLB.textColor =  CPERROR_COLOR;
    [self.contentView addSubview:overdueLB];
    
    
    timeLB = [CPLabel new];
    timeLB.text = @"回收时间:2018-02-01 18:21";
    [self.contentView addSubview:timeLB];
    
    [orderNoLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pictureIV.mas_top);
        make.left.mas_equalTo(pictureIV.mas_right).offset(cellSpaceOffset/2);
    }];
    
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(orderNoLB.mas_bottom);
        make.left.mas_equalTo(orderNoLB.mas_left);
        make.right.mas_offset(-cellSpaceOffset);
        make.height.mas_equalTo(orderNoLB.mas_height);
    }];
    
    [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLB.mas_bottom);
        make.left.mas_equalTo(orderNoLB.mas_left);
        make.height.mas_equalTo(orderNoLB.mas_height);
    }];
    
    [overdueLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLB.mas_bottom);
        make.left.mas_equalTo(priceLB.mas_right).offset(cellSpaceOffset/2);
        make.height.mas_equalTo(orderNoLB.mas_height);
        make.right.mas_offset(-cellSpaceOffset);
    }];

    [timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(priceLB.mas_bottom);
        make.left.mas_equalTo(orderNoLB.mas_left);
        make.right.mas_offset(-cellSpaceOffset);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(orderNoLB.mas_height);
    }];
    
}

- (void)setHasSelected:(BOOL)hasSelected {
    
    _hasSelected = hasSelected;
    
    if (_hasSelected) {
        [selectBT setImage:CPImage(@"Tick_preseed") forState:0];
    } else {
        [selectBT setImage:CPImage(@"Tick_default") forState:0];
    }
}

- (void)setCanEdit:(BOOL)canEdit {
    _canEdit = canEdit;
    
    if (canEdit == YES) {
        return;
    }
    
    [pictureIV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cellSpaceOffset/2);
        make.left.mas_equalTo(cellSpaceOffset);
        make.bottom.mas_equalTo(-cellSpaceOffset/2);
        make.width.mas_equalTo(pictureIV.mas_height);
    }];
    
    overdueLB.hidden = YES;
}

- (void)selectAction:(UIButton *)sender {
    DDLogInfo(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    
    !self.actionBlock ? : self.actionBlock();
}

- (void)setModel:(CPCartModel *)model {
    
    _model = model;
    
    [pictureIV sd_setImageWithURL:CPUrl(_model.goodsurl) placeholderImage:CPImage(@"apple")];
    nameLB.text = _model.goodsname;
    orderNoLB.text = [NSString stringWithFormat:@"订单号：%@",_model.resultno];
    if (IS_MEMBER_ACCOUNT) {
        priceLB.text = [NSString stringWithFormat:@"客户成交价：%@",_model.price];
        timeLB.text = [NSString stringWithFormat:@"平台回收价：%@",_model.currentprice];
    } else {
        priceLB.text = [NSString stringWithFormat:@"¥%@",_model.price];
        timeLB.text = [NSString stringWithFormat:@"创建时间：%@",_model.createtime];
    }
    
    overdueLB.text = [NSString stringWithFormat:@"失效时间：%@",_model.daleytime];

}

@end
