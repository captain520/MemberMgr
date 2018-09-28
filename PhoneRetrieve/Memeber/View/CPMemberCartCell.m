//
//  CPMemberCartCell.m
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/14.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemberCartCell.h"

@implementation CPMemberCartCell {
    UIButton *selectBT;
    
    UIImageView *pictureIV;
    CPLabel *nameLB, *priceLB, *orderNoLB, *overdueLB, *ptPriceLB;
    
    CPLabel *createTimeLB;
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
//        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(8 + 2 * CELL_HEIGHT_F);
        make.width.mas_equalTo(selectBT.mas_height).multipliedBy(0.5f);
        //        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        //        make.left.mas_equalTo(cellSpaceOffset);
        //        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    pictureIV = [UIImageView new];
    pictureIV.image = CPImage(@"hme_iphone");
//    pictureIV.backgroundColor = UIColor.redColor;
    [self.contentView addSubview:pictureIV];
    
    [pictureIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.left.mas_equalTo(selectBT.mas_right).offset(cellSpaceOffset/2);
//        make.bottom.mas_equalTo(-cellSpaceOffset/2);
//        make.width.mas_equalTo(pictureIV.mas_height);
        make.size.mas_equalTo(2 * CELL_HEIGHT_F);
    }];
    
    //  订单号
    orderNoLB = [CPLabel new];
    orderNoLB.text = @"订单号: 2018272633383";
    [self.contentView addSubview:orderNoLB];
    
    nameLB = [CPLabel new];
    nameLB.text = @"苹果: iPhne 6s Plus (手机)";
    [self.contentView addSubview:nameLB];
    
    
    priceLB = [CPLabel new];
    priceLB.text = @"客户成交价: ¥1892.00";
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
    
    
    ptPriceLB = [CPLabel new];
    ptPriceLB.text = @"平台回收交价: ¥1892.00";
    [self.contentView addSubview:ptPriceLB];
    
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
//        make.top.mas_equalTo(pictureIV.mas_bottom);
        make.left.mas_equalTo(cellSpaceOffset);
        make.bottom.mas_equalTo(-4);
//        make.right.mas_equalTo(createTimeLB.mas_left).offset(-4);
//        make.top.mas_equalTo(nameLB.mas_bottom);
//        make.left.mas_equalTo(priceLB.mas_right).offset(cellSpaceOffset/2);
//        make.height.mas_equalTo(orderNoLB.mas_height);
//        make.right.mas_offset(-cellSpaceOffset);
    }];
    
    [ptPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(priceLB.mas_bottom);
        make.left.mas_equalTo(orderNoLB.mas_left);
        make.right.mas_offset(-cellSpaceOffset);
        make.bottom.mas_equalTo(pictureIV.mas_bottom);
        make.height.mas_equalTo(orderNoLB.mas_height);
    }];
    
    createTimeLB = [CPLabel new];
    createTimeLB.numberOfLines = 1;
    createTimeLB.text = [NSString stringWithFormat:@"回收时间：%@",@"2018-07-12"];
    [self.contentView addSubview:createTimeLB];
    [createTimeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderNoLB.mas_left);
        make.top.mas_equalTo(overdueLB.mas_top);
        make.right.mas_equalTo(-cellSpaceOffset);
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
    orderNoLB.text = [NSString stringWithFormat:@"订单号：%@",_model.resultno];
    nameLB.text = _model.goodsname;
    
    if ([CPUserInfoModel shareInstance].loginModel.Typeid > 5) {
        priceLB.text = [NSString stringWithFormat:@"客户成交价: ¥%.2f",model.price.floatValue];
        ptPriceLB.text = [NSString stringWithFormat:@"平台回收交价: ¥%.2f",model.currentprice.floatValue];
        createTimeLB.text = [NSString stringWithFormat:@"回收时间：%@",model.createtime];
    } else {
        priceLB.text = [NSString stringWithFormat:@"¥%@",_model.price];
        ptPriceLB.text = [NSString stringWithFormat:@"创建时间：%@",_model.createtime];
    }
    
    overdueLB.text = [NSString stringWithFormat:@"失效时间：%@",_model.daleytime];
}

@end
