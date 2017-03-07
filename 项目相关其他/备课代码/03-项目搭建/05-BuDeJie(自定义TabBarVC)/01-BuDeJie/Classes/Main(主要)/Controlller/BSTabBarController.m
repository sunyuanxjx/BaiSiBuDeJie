//
//  BSTabBarController.m
//  01-BuDeJie
//
//  Created by yz on 15/12/15.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSTabBarController.h"

#import "UIImage+Image.h"

#import "BSEssenceViewController.h"
#import "BSNewViewController.h"
#import "BSFriendTrendsViewController.h"
#import "BSMineViewController.h"
#import "BSPublishViewController.h"


@interface BSTabBarController ()

@end

@implementation BSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 2.2 添加子控制器
    [self setUpAllChildViewController];
    
    // 2.3 设置tabButton内容
    [self setUpAllTabBarButton];
    
}


// 设置所有tabButton内容
- (void)setUpAllTabBarButton
{
    // 精华
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"精华";
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_essence_click_icon"];
    
    // 新帖
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新帖";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_new_click_icon"];
    
    // 关注
    UINavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"关注";
    nav2.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav2.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_friendTrends_click_icon"];
    
    // 我
    UINavigationController *nav3 = self.childViewControllers[3];
    nav3.tabBarItem.title = @"我";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_new_click_icon"];

}

// 添加所有子控制器
- (void)setUpAllChildViewController
{
    // 精华
    BSEssenceViewController *essenceVc = [[BSEssenceViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:essenceVc];
    [self addChildViewController:nav];
    
    // 新帖
    BSNewViewController *newVc = [[BSNewViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:newVc];
    [self addChildViewController:nav1];
    
    // 关注
    BSFriendTrendsViewController *friendVc = [[BSFriendTrendsViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:friendVc];
    [self addChildViewController:nav2];
    
    // 我
    BSMineViewController *meVc = [[BSMineViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:meVc];
    [self addChildViewController:nav3];
}



@end
