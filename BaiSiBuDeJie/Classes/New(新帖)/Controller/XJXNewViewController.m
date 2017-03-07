//
//  XJXNewViewController.m
//  BuDeJie
//
//  Created by 孙远 on 2017/1/24.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXNewViewController.h"
#import "XJXSubTagViewController.h"

@interface XJXNewViewController ()

@end

@implementation XJXNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    // 设置导航栏
    [self setupNavBar];
}

// 设置 导航栏
-(void)setupNavBar
{
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(tagClick)];

    // titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}


-(void)tagClick
{
    // 进入推荐标签页
    XJXSubTagViewController *subTagVC = [[XJXSubTagViewController alloc] init];
    [self.navigationController pushViewController:subTagVC animated:YES];
}

@end
