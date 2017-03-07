//
//  UITextField+XJXPlaceholder.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/1/29.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "UITextField+XJXPlaceholder.h"

@implementation UITextField (XJXPlaceholder)

// 快速设置占位文字颜色
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    // KVC方法获取文本框占位label
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;

}

@end
