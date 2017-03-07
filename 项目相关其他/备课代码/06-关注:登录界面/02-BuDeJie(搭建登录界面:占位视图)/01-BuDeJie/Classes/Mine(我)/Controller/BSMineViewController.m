//
//  BSMineViewController.m
//  01-BuDeJie
//
//  Created by yz on 15/12/15.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSMineViewController.h"

#import "UIBarButtonItem+Item.h"

#import "BSSettingViewController.h"

@interface BSMineViewController ()

@end

@implementation BSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavBar];
    
  
    
    
}
// 设置导航条
- (void)setUpNavBar
{
    UIBarButtonItem *night = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] targer:self action:@selector(night:)];
    
    UIBarButtonItem *setting = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] targer:self action:@selector(setting)];
    
    // right
    self.navigationItem.rightBarButtonItems = @[setting,night];
    
    // titleView
    self.navigationItem.title = @"我的";
}

// 夜间模式
- (void)night:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

- (void)setting
{
    // 进入设置界面
    BSSettingViewController *settingVc = [[BSSettingViewController alloc] init];
    
    settingVc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:settingVc animated:YES];
    
    
}
@end