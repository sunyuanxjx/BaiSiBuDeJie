//
//  XJXFastLoginButton.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/1/29.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXFastLoginButton.h"

@implementation XJXFastLoginButton

// UIButton中 图片默认在左,文字默认在右
// 重新布局子控件 使图片在上,文字在下
-(void)layoutSubviews
{
    [super layoutSubviews];
    // 设置图片位置
    self.imageView.xjx_y = 0;
    self.imageView.xjx_centerX = self.xjx_width * 0.5;
    // 设置标题位置
    self.titleLabel.xjx_y = self.xjx_height - self.titleLabel.xjx_height;
    // 设置文字宽度,设置label宽度
    [self.titleLabel sizeToFit];
    self.titleLabel.xjx_centerX = self.xjx_width * 0.5;
}

@end
