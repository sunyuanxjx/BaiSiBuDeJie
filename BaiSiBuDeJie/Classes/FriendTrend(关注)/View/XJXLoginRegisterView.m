//
//  XJXLoginRegisterView.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/1/28.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXLoginRegisterView.h"

@interface XJXLoginRegisterView()

@property (weak, nonatomic) IBOutlet UIButton *loginRegisterBtn;

@end

@implementation XJXLoginRegisterView

// 加载第一个View,登录view
+(instancetype)loginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

// 加载第一个View,注册View
+(instancetype)registerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

// awakeFromNib 从xib或者storyboard加载完毕就会调用
-(void)awakeFromNib
{
    [super awakeFromNib];
    // 背景图片不要被拉伸
    // 1.拿到背景图片
    UIImage *image = _loginRegisterBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height*0.5];
    [_loginRegisterBtn setBackgroundImage:image forState:UIControlStateNormal];
    
}

@end
