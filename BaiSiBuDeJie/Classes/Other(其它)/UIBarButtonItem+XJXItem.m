//
//  UIBarButtonItem+XJXItem.m
//  BuDeJie
//
//  Created by 孙远 on 2017/1/25.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "UIBarButtonItem+XJXItem.h"

@implementation UIBarButtonItem (XJXItem)

// 正常和高亮btn
+(UIBarButtonItem*)itemWithImage:(UIImage*)image highImage:(UIImage*)highImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 把Btn包装成UIView
    UIView *containV = [[UIView alloc] initWithFrame:btn.bounds];
    [containV addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:containV];

}

// 正常和高亮btn
+(UIBarButtonItem*)itemWithImage:(UIImage*)image selImage:(UIImage*)selImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 把Btn包装成UIView
    UIView *containV = [[UIView alloc] initWithFrame:btn.bounds];
    [containV addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:containV];
    
    
}

// 统一返回按钮
+(UIBarButtonItem*)backWithImage:(UIImage*)image highImage:(UIImage*)highImage target:(id)target action:(SEL)action title:(NSString*)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
}

@end
