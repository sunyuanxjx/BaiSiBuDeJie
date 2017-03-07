//
//  AppDelegate.m
//  01-BuDeJie
//
//  Created by yz on 15/12/15.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "AppDelegate.h"

#import "BSEssenceViewController.h"
#import "BSNewViewController.h"
#import "BSFriendTrendsViewController.h"
#import "BSMineViewController.h"
#import "BSPublishViewController.h"



/*
 1.项目结构搭建 UITaBarController和UINavgationController组成
 
 2.设置窗口的根控制器为UITabBarController
 
 3.设置窗口根控制器两种方式：storyboard,纯代码
 3.1 程序启动原理
 
 4.显示完下面条，显示上面导航条
 
 5.添加导航控制器作为子控制器，如何判断有多少个子控制器呢，
 5.1 有多少个按钮，就有多少个子控制器。
 5.2 导航控制器需要根控制器，显示最外面的就是导航控制器的根控制器，每个界面有自己的业务逻辑，因此需要自定义所有导航控制器的根控制器
 5.3 讲解项目结构，和切换原理。
 
 */


@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 2.设置窗口的根控制器
    // 2.1 创建UITabBarController
    UITabBarController *tabBarVc = [[UITabBarController alloc] init];
    self.window.rootViewController = tabBarVc;
    
    // 2.2 添加子控制器
    // 精华
    BSEssenceViewController *essenceVc = [[BSEssenceViewController alloc] init];
    essenceVc.view.backgroundColor = [UIColor redColor];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:essenceVc];
    [tabBarVc addChildViewController:nav];
    
    // 新帖
    BSNewViewController *newVc = [[BSNewViewController alloc] init];
    newVc.view.backgroundColor = [UIColor blueColor];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:newVc];
    [tabBarVc addChildViewController:nav1];
    
    // 发布
    BSPublishViewController *publishVc = [[BSPublishViewController alloc] init];
    publishVc.view.backgroundColor = [UIColor whiteColor];
//    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:newVc];
    [tabBarVc addChildViewController:publishVc];
    
    
    // 关注
    BSFriendTrendsViewController *friendVc = [[BSFriendTrendsViewController alloc] init];
    friendVc.view.backgroundColor = [UIColor yellowColor];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:friendVc];
    [tabBarVc addChildViewController:nav2];
    
    // 我
    BSMineViewController *meVc = [[BSMineViewController alloc] init];
    meVc.view.backgroundColor = [UIColor greenColor];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:meVc];
    [tabBarVc addChildViewController:nav3];

    
    
    // 3.显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
