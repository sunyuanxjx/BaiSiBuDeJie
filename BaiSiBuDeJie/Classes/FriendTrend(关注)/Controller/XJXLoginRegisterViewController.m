//
//  XJXLoginRegisterViewController.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/1/28.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXLoginRegisterViewController.h"
#import "XJXLoginRegisterView.h"
#import "XJXFastLoginView.h"

@interface XJXLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *midViewOfleadingConstraint;

@end

@implementation XJXLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    // midView同时添加两个View没有关系,只要在viewDidLayoutSubviews重新布局一下frame,让另一个在屏幕之外就可以了
    // 创建登录view
    XJXLoginRegisterView *loginView = [XJXLoginRegisterView loginView];
    // 添加到中间的view
    [self.midView addSubview:loginView];
    
    // 创建注册view
    XJXLoginRegisterView *registerView = [XJXLoginRegisterView registerView];
    // 添加到中间的view
    [self.midView addSubview: registerView];
    
    // 创建快速登录View
    XJXFastLoginView *fastLoginView = [XJXFastLoginView fastLoginView];
    // 添加到底部的view
    [self.bottomView addSubview:fastLoginView];
    
    
    

    
}

// 点击注册账号按钮,切换View
- (IBAction)registerBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    // 平移中间View
    _midViewOfleadingConstraint.constant = _midViewOfleadingConstraint.constant == 0? -self.midView.xjx_width * 0.5:0;
    [UIView animateWithDuration:0.1 animations:^{
        // 布局子控件
        [self.view layoutIfNeeded];
    }];
    
}


// 重新布局子控件
-(void)viewDidLayoutSubviews
{
    // 一定要用到super
    [super viewDidLayoutSubviews];
    // 设置登录view的frame
    XJXLoginRegisterView *loginView = self.midView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.midView.xjx_width * 0.5, self.midView.xjx_height);
    // 设置注册view的frame
    XJXLoginRegisterView *registerView = self.midView.subviews[1];
    registerView.frame = CGRectMake(self.midView.xjx_width * 0.5, 0, self.midView.xjx_width * 0.5, self.midView.xjx_height);
    
    // 快速登录的View
    XJXFastLoginView *fastLoginView = self.bottomView.subviews.firstObject;
    fastLoginView.frame = self.bottomView.bounds;
    
}

// 退出按钮
- (IBAction)close:(id)sender {
    
    // 退出当前控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
