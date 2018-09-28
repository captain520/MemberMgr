//
//  CPImageTitleUpDownCell.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPImageTitleUpDownCell : UICollectionViewCell


/**
 更新图片和标题

 @param imageUrl 图片URL路径
 @param title 标题内容
 */
- (void)updateImage:(NSString *)imageUrl title:(NSString *)title;

@end
