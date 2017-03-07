//
//  AppDelegate.m
//  01-BuDeJie
//
//  Created by yz on 15/12/15.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "AppDelegate.h"


#import "BSAdViewController.h"

#import "BSTabBarController.h"



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
 
 6.设置tabBarButton按钮内容:由对应子控制器决定
    问题：
    1.发布界面对应按钮显示位置不正确，原因：图片尺寸超出一定范围，因此发布按钮不是tabBarButton,他对应的控制器也不是tabBarController的子控制器。
 
    2.选中按钮图片被渲染,两种方式解决：1.直接修改图片 2.纯代码
 
    3.修改插件,KSImage路径跟之前不一样了
 
 7.自定义tabBarController，自己的事情自己管理
 
 8.处理tabBarButton标题,tabBarButton由tabBarItem决定，因此找它设置.
    富文本属性：颜色，字体，阴影，图文混排。
    只需要设置一次，所有的tabBarItem都一样，拿到全局tabBarItem设置
    
 9.UIAppearance:获取全局的控件.
 
 10.完善tabBar，给tabBarController的tabBar添加加号按钮，居中显示。
    1.把系统的tabBarButton分成5等分，调整系统tabBar子控件的位置。
    2.系统tabBar子控件的位置是由系统决定的，想要改，只能一种方式，自定义tabBar，重写layoutSubviews。
    思想：只要想改系统自带子控件的位置，自定义它，然后重写layoutSubviews。
 
    3.使用自己的tabBar有个问题，怎么把UITabBarButton加到自己的tabBar上。
    *   研究：UITabBarButton什么时候添加到tabBar上，在viedWillAppear添加，因此只要在viewWillAppear之前替换系统的tabBar就可以了。
    4.布局子控件，抽取UIView分类
 
 11.下面条完善完，可以完善上面导航条.（设置导航条内容）
    1.精华 新帖 关注 我
    2.抽取UIBarButtom分类
    3.夜间模型 是选中状态
 
 12.抽取pch,存放常见头文件，自定义Log
 
 13.处理导航条标题
    *   拿到全局统一设置，自定义导航控制器
    *   通过导航条设置
    *   设置导航条背景图片，必须用default模式
 
 14.统一设置返回按钮，一般一个项目中的返回样式都是一样的。
    *   跳转到设置界面，点击设置界面在跳转到其他界面
    *   每次跳转的时候，才需要设置返回按钮，监听跳转。
    *   在哪设置，返回按钮最好由显示的界面决定。
    *   重写push方法，判断是否是首页，不是首页才需要.
    *   contentEdgeInsets:设置按钮内容往左边显示.
 
 15.滑动返回
    *   覆盖了返回按钮，就没有滑动返回功能，原因:代理做了事情，因为手势并没有移除，只能是代理做了一些处理。
 
 16.搭建广告界面
    *   分析广告业务逻辑，每次启动程序的时候才进入广告界面，也就是在启动完成时候才进入.
    *   并不是在启动界面进行广告时间，因为启动界面不能处理业务逻辑，启动界面的本质，就是截屏一张图片，没有处理业务逻辑的功能。
    *   思路：1.程序一启动进入广告界面，搞个控制器管理 2.搞个和启动界面一样图片的view挡在主框架前面，进行广告播放
    *   屏幕适配，不同屏幕，加载不同启动界面。
 17.加载广告数据
    *   讲解cocoapods
    *   获取不到数据，content Type（响应体） 讲解http请求过程
    *   修改AFN框架
 18.解析数据，显示广告界面
    * 广告图片按比例缩放.
    * 点击广告界面跳转到对应网页，打开网页的方式：webView，UIApplication，一般都是跳转到safari打开,并不是在当前应用打开.
 
 19.控制广告时间，搞个定时器，3秒后切换界面
 
 20.搭建标签页，加载数据
 
 21.展示数据，自定义cell,通过xib加载cell的两种方式，nsbundle（注意绑定ID）,注册
 
 22.圆角和订阅数
 
 21.裁剪/锯齿
 
 22.分割线， 自带的方法 和setFrame
 
 23.请求指示器业务逻辑
 
 24.搭建关注界面，界面固定死使用xib,没必要使用storyboard，比较重量级，描述多个控制器时，可以采取这种方式.
 
 
 
 
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
    BSAdViewController *adVc = [[BSAdViewController alloc] init];

    self.window.rootViewController = adVc;
    
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
