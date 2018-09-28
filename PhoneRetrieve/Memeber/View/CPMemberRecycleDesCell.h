//
//  CPMemberRecycleDesCell.h
//  PhoneRetrieve
//
//  Created by 王璋传 on 2018/7/4.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseCell.h"

@interface CPMemberRecycleDesCell : CPBaseCell

//  图片箭头是否指向上面
@property (nonatomic, assign) BOOL isUpDirection;

//  右边图片名称
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, assign) NSInteger level;


/**
更新标题Cell的文字内容

 @param title 文字内容
 */
- (void)updateTitle:(NSString *)title;

@end
