//
//  XJXDIYHeader.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/2/14.
//  Copyright © 2017年 sunyuan. All rights reserved.
//  自定义下拉刷新控件

#import "XJXDIYHeader.h"

@implementation XJXDIYHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
   
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    

}

#pragma mark - 重写Header内部的方法
- (void)setState:(MJRefreshState)state
{
    [super setState:state];
    
    if (state == MJRefreshStateIdle) { // 下拉可以刷新
        
        
        [UIView animateWithDuration:0.25 animations:^{
            
        }];
    } else if (state == MJRefreshStatePulling) { // 松开立即刷新
        
        
    
    } else if (state == MJRefreshStateRefreshing) { // 正在刷新
        
        
     
    }
}

@end
