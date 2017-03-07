//
//  BSIoginRegisterField.m
//  01-BuDeJie
//
//  Created by yz on 15/12/16.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSIoginRegisterField.h"

@implementation BSIoginRegisterField

/*
    1.placeHolder是怎么显示文字，肯定也是依赖与一个控件
    2.拿到Label就能设置了
    3.但是只有当前文本框才能设置
    4.如果想要所有文本框能设置，提供分类
    5.问题：如果先设置占位颜色，在设置占位文字，会设置不成功.
    6.因为控件是懒加载的，不设置文字，不会加载这个控件
    7.把设置的颜色，先保存起来，等下次设置文字的时候，在取出文字颜色设置.
    8.每次设置文字，在重新设置颜色，交换系统方法实现.
 */

- (void)awakeFromNib
{
    self.placeholderColor = [UIColor lightGrayColor];
    
    // 监听文本框开始编辑：1.代理 2.通知 3.绑定监听者
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)textBegin
{
    
    self.placeholderColor = [UIColor whiteColor];

    
}

- (void)textEnd
{

    
    self.placeholderColor = [UIColor lightGrayColor];
}
@end
