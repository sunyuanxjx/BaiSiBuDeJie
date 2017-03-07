//
//  BSTabBar.m
//  01-BuDeJie
//
//  Created by yz on 15/12/15.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSTabBar.h"

#import "UIView+Frame.h"

@interface BSTabBar ()

@property (nonatomic, weak) UIButton *addButton;

@end


@implementation BSTabBar

- (UIButton *)addButton
{
    if (_addButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        
        
        
        [self addSubview:btn];
        _addButton = btn;
    }
    
    return _addButton;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.items.count;
    
    // 调整内部子控件的位置
    CGFloat btnW = self.width / (count + 1);
    CGFloat btnH = self.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    
    int i = 0;
    for (UIView *tabBarButton in self.subviews) {
        // 判断是否是UITabBarButton
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (i == 2) {
                i += 1;
            }
            
            btnX = i * btnW;
            
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            
            i++;
        }
    }
    
    // 设置发布按钮
    self.addButton.centerX = self.width * 0.5;
    self.addButton.centerY = self.height * 0.5;

}

@end
