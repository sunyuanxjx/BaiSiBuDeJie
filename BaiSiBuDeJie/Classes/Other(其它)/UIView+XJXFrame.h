//
//  UIView+XJXFrame.h
//  BuDeJie
//
//  Created by 孙远 on 2017/01/25.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

// 直接用self.xjx_width 来代替 self.frame.size.width

@interface UIView (XJXFrame)

@property CGFloat xjx_width;
@property CGFloat xjx_height;
@property CGFloat xjx_x;
@property CGFloat xjx_y;

@property CGFloat xjx_centerX;
@property CGFloat xjx_centerY;


+ (instancetype)xjx_viewFromXib;
@end
