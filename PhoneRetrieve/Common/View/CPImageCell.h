//
//  CPImageCell.h
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/10.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPImageCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) void (^deleteAction)(NSIndexPath *indexPath);

@end
