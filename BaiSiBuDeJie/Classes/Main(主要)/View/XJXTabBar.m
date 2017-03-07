//
//  XJXTabBar.m
//  BuDeJie
//
//  Created by 孙远 on 2017/1/25.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXTabBar.h"

@interface XJXTabBar()

/** 添加发布按钮  **/
@property(nonatomic, weak) UIButton *plusBtn;

/**  **/
@property(nonatomic, weak) UIControl *previousClickedTabBarBtn;

@end

@implementation XJXTabBar

// 发布按钮
-(UIButton *)plusBtn
{
    if (_plusBtn == nil) {
        
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        
        // 根据按钮内容自适应
        [plusBtn sizeToFit];
        
        _plusBtn = plusBtn;
        
        [self addSubview:plusBtn];
    }
    
    return _plusBtn;

}

// 重新布局子控件时调用
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 布局tabBarButton
    NSInteger count = self.items.count + 1;
    
    CGFloat btnW = self.xjx_width / count;
    CGFloat btnH = self.xjx_height;
    CGFloat btnX = 0;
    
    NSInteger i = 0;
    for (UIControl *tabBarButton in self.subviews) {
        
        // self.subviews 不仅有plusBtn,UITabBarButton,还有 UIBarBackground,所有需要判断
        // // 私有类:打印出来这个类,但是敲不出来,说明这个类是系统私有类,只能用NSClassFromString方法
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            // 设置 previousClickedTabBarBtn 默认值 为最前面的按钮
            if (i == 0 && self.previousClickedTabBarBtn == nil) {
                self.previousClickedTabBarBtn = tabBarButton;
                
            
            }
            
            if (i == 2) {
                i++;
            }
            btnX = i*btnW;
            tabBarButton.frame = CGRectMake(btnX, 0, btnW, btnH);
            i++;
            
            // 监听点击
            [tabBarButton addTarget:self action:@selector(tabBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    // 设置发布按钮center
    self.plusBtn.center = CGPointMake(self.xjx_width * 0.5, self.xjx_height * 0.5);
    
}

-(void)tabBarBtnClick:(UIControl *)tabBarBtn
{
    // 第二次点击TabBar按钮就会调用,在此实现刷新功能
    if (self.previousClickedTabBarBtn == tabBarBtn) {
        
        // 发出通知,告知外界tabBarBtn被重复点击了,在XJXAllViewController监听通知
        [[NSNotificationCenter defaultCenter] postNotificationName:XJXTabBarButtonDidRepeatClickNotification object:nil];
    }
    
    self.previousClickedTabBarBtn = tabBarBtn;
}



@end
