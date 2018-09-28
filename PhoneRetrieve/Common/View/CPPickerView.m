//
//  CPPickerView.m
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/9.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "CPPickerView.h"

@implementation CPPickerView {
    NSString *selectItem;
}

- (id)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray {
    
    if (self = [super initWithFrame:frame]) {
        self.dataArray       = dataArray;
        self.delegate        = self;
        self.dataSource      = self;
        self.clipsToBounds   = NO;
        self.backgroundColor = MainColor;
        self.userInteractionEnabled = YES;
    }
    
    return self;
}


#pragma mark - Delegate method

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.dataArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.dataArray[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSArray *tempArray = [self.dataArray objectAtIndex:component];
    return tempArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSArray *tempArray = [self.dataArray objectAtIndex:component];
    
    selectItem = tempArray[row];
}

#pragma mark - Private method implement
- (void)doneAction:(id)sender {
    !self.selectBlock ? : self.selectBlock(selectItem);
}
@end
