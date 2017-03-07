//
//  XJXNavigationController.m
//  BuDeJie
//
//  Created by 孙远 on 2017/1/25.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXNavigationController.h"

@interface XJXNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation XJXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 全屏滑动
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    
    [self.view addGestureRecognizer:pan];
    
    pan.delegate = self;
    
    // 禁止之前的手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

#pragma mark -- UIGestureRecognizerDelegate
// 决定是否触发手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1;
}

// 设置所有导航条字体大小,背景图片
+(void)load
{
    // 拿到所有导航控制器的导航条
    NSArray *arrVC = [NSArray arrayWithObject:self];
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:arrVC];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:attrs];
    
    // 设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

// 统一设置返回按钮
// 重写下面方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    
    
    // 设置返回按钮.只有非根控制器才需要
    // 只有从根控制器中推进到下一个控制器,这个控制器才能成为根控制器的子控制器,count>0,才需要返回
    // 恢复滑动返回功能 -> 分析:把系统的返回按钮覆盖 -> 1.手势失效(1.可能手势被清空 2.可能手势代理做了一些事情,导致手势失效
    if (self.childViewControllers.count > 0) {
        
        // 隐藏底部导航条,在根控制器跳转之后隐藏
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back) title:@"返回"];
    }
    
 
    
    // 真正在跳转
    [super pushViewController:viewController animated:YES];

}

-(void)back
{
    // 返回
    [self popViewControllerAnimated:YES];
}

@end
