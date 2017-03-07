//
//  UIView+XJXFrame.m
//  BuDeJie
//
//  Created by 孙远 on 2017/01/25.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "UIView+XJXFrame.h"

@implementation UIView (XJXFrame)

+ (instancetype)xjx_viewFromXib
{
   
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;

}



-(void)setXjx_width:(CGFloat)xjx_width
{
    CGRect rect = self.frame;
    rect.size.width = xjx_width;
    self.frame = rect;

}

-(CGFloat)xjx_width
{
    return self.frame.size.width;
}

-(void)setXjx_height:(CGFloat)xjx_height
{
    CGRect rect = self.frame;
    rect.size.height = xjx_height;
    self.frame = rect;
    
}

-(CGFloat)xjx_height
{
    return self.frame.size.height;
}

-(void)setXjx_x:(CGFloat)xjx_x
{
   CGRect rect = self.frame;
    rect.origin.x = xjx_x;
    self.frame = rect;
}

-(CGFloat)xjx_x
{
    return self.frame.origin.x;
}

-(void)setXjx_y:(CGFloat)xjx_y
{
    CGRect rect = self.frame;
    rect.origin.y = xjx_y;
    self.frame = rect;
}

-(CGFloat)xjx_y
{
    return self.frame.origin.y;
}

-(void)setXjx_centerX:(CGFloat)xjx_centerX
{
    CGPoint center = self.center;
    center.x = xjx_centerX;
    self.center = center;
}

-(CGFloat)xjx_centerX
{
    return self.center.x;
}

-(void)setXjx_centerY:(CGFloat)xjx_centerY
{
    CGPoint center = self.center;
    center.y = xjx_centerY;
    self.center = center;
}

-(CGFloat)xjx_centerY
{
    return self.center.y;
}


@end
