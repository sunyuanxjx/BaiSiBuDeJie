//
//  UIImage+XJXOriginalImage.m
//  BuDeJie
//
//  Created by 孙远 on 2017/1/25.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "UIImage+XJXOriginalImage.h"

@implementation UIImage (XJXOriginalImage)

// 返回一张不被渲染的照片
+(UIImage*)imageOriginalWithName:(NSString*)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

// 返回一张由矩形裁剪为圆形的图片
- (instancetype)xjx_circleImage
{
    // 1.开启图形上下文
    // 比例因素,当前点与像素比例
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    // 描述裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    // 设置裁剪区域
    [path addClip];
    // 画图片
    [self drawAtPoint:CGPointZero];
    // 取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+(instancetype)xjx_circleImageNamed:(NSString *)name
{
    return [[self imageNamed:name] xjx_circleImage];
}

@end
