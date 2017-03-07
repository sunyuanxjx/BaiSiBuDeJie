//
//  UIImage+XJXOriginalImage.h
//  BuDeJie
//
//  Created by 孙远 on 2017/1/25.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XJXOriginalImage)

// 选中的图片被渲染  --> iOS7以后默认tabBar上按钮图片都会被渲染
// 返回一张不被渲染的照片
+(UIImage *)imageOriginalWithName:(NSString *)imageName;

// 返回一张由矩形裁剪为圆形的图片-对象方法 调用方法 [UIImage imageNamed:@""] xjx_circleImage
- (instancetype)xjx_circleImage;

// 类方法 调用方法 [UIImage xjx_circleImageNamed:@""]
+(instancetype)xjx_circleImageNamed:(NSString *)name;

@end
