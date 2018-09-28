//
//  CPOrderCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/1.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPOrderCell.h"

@implementation CPOrderCell {
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
    
    {
        orderNoLB = [CPLabel new];
        orderNoLB.text = @"订单号: 2018272633383";
        [self.contentView addSubview:orderNoLB];
        
        [orderNoLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(cellSpaceOffset);
            make.top.mas_equalTo(0);
//            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    {
        overdueLB = [CPLabel new];
        overdueLB.text = @"已经失效";
        overdueLB.textColor = [UIColor redColor];
        [self.contentView addSubview:overdueLB];
        
        [overdueLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-cellSpaceOffset);
            make.top.mas_equalTo(orderNoLB.mas_top);
            make.height.mas_equalTo(orderNoLB.mas_height);
//            make.bottom.mas_equalTo(0);
        }];
    }
    
    UIView *seplineView = [UIView new];
    seplineView.backgroundColor = CPBoardColor;
    [self.contentView addSubview:seplineView];
    [seplineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(orderNoLB.mas_bottom);
        make.left.mas_equalTo(cellSpaceOffset);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(CPBoardWidth);
    }];
    
    {
        pictureIV = [UIImageView new];
        pictureIV.image = CPImage(@"hme_iphone");
//        pictureIV.backgroundColor = UIColor.redColor;
        [self.contentView addSubview:pictureIV];
        
        [pictureIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(orderNoLB.mas_bottom).offset(cellSpaceOffset/2);
            make.left.mas_equalTo(cellSpaceOffset);
            make.bottom.mas_equalTo(-cellSpaceOffset/2);
            make.width.mas_equalTo(pictureIV.mas_height);
        }];
    }
    
    {
        nameLB = [CPLabel new];
        nameLB.text = @"苹果: iPhne 6s Plus (手机)";
        [self.contentView addSubview:nameLB];
        [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(pictureIV.mas_top);
            make.left.mas_equalTo(pictureIV.mas_right).mas_equalTo(cellSpaceOffset/2);
            make.right.mas_offset(-cellSpaceOffset);
        }];
    }
    
    {
        priceLB = [CPLabel new];
        priceLB.text = @"回收价: ¥1892.00";
        [self.contentView addSubview:priceLB];
        [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(nameLB.mas_bottom);
            make.left.mas_equalTo(nameLB.mas_left);
            make.right.mas_offset(-cellSpaceOffset);
            make.height.mas_equalTo(nameLB.mas_height);
        }];
    }
    
    {
        timeLB = [CPLabel new];
        timeLB.text = @"失效时间: 2018-02-01 18:21";
        timeLB.textColor = UIColor.redColor;
        [self.contentView addSubview:timeLB];
        [timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(priceLB.mas_bottom);
            make.left.mas_equalTo(nameLB.mas_left);
            make.right.mas_offset(-cellSpaceOffset);
            make.height.mas_equalTo(nameLB.mas_height);
            make.bottom.mas_equalTo(pictureIV.mas_bottom);
        }];
    }
}

- (void)setAssistantOrderModel:(CPAssistanteOrderDetailModel *)assistantOrderModel {
    _assistantOrderModel = assistantOrderModel;
    
    [pictureIV sd_setImageWithURL:CPUrl(_assistantOrderModel.goodsurl) placeholderImage:CPImage(@"apple")];
    orderNoLB.text = [NSString stringWithFormat:@"订单号:%@",_assistantOrderModel.resultno];
    overdueLB.text = _assistantOrderModel.statuscfg ? @"已失效" : @"已回收";
    overdueLB.textColor = _assistantOrderModel.statuscfg ? UIColor.redColor : MainColor;
    nameLB.text = [NSString stringWithFormat:@"回收时间:%@",_assistantOrderModel.createtime];
    
    NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:_assistantOrderModel.goodsname attributes:nil];
    NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"(%@) ",_assistantOrderModel.Typename] attributes:@{NSForegroundColorAttributeName : UIColor.redColor}];
    [attr0 appendAttributedString:attr1];
    
    NSAttributedString *attr2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"回收人:%@",_assistantOrderModel.username] attributes:nil];
    [attr0 appendAttributedString:attr2];
    priceLB.attributedText = attr0;
    
//    priceLB.text = _assistantOrderModel.goodsname;
    timeLB.text = [NSString stringWithFormat:@"¥:%@",_assistantOrderModel.price];

}

@end
