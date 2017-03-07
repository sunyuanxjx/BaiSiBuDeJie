//
//  UIBarButtonItem+XJXItem.h
//  BuDeJie
//
//  Created by 孙远 on 2017/1/25.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XJXItem)

// 正常与高亮
+(UIBarButtonItem*)itemWithImage:(UIImage*)image highImage:(UIImage*)highImage target:(id)target action:(SEL)action;

// 正常与选中状态
+(UIBarButtonItem*)itemWithImage:(UIImage*)image selImage:(UIImage*)selImage target:(id)target action:(SEL)action;

// 统一返回按钮
+(UIBarButtonItem*)backWithImage:(UIImage*)image highImage:(UIImage*)highImage target:(id)target action:(SEL)action title:(NSString*)title;

@end
