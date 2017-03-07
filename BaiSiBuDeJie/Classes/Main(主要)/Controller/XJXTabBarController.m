//
//  XJXTabBarController.m
//  BuDeJie
//
//  Created by 孙远 on 2017/1/24.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXTabBarController.h"
#import "XJXEssenceViewController.h"
#import "XJXFriendTrendViewController.h"
#import "XJXMeViewController.h"
#import "XJXNewViewController.h"
#import "XJXPublishViewController.h"
#import "XJXTabBar.h"
#import "XJXNavigationController.h"



@interface XJXTabBarController ()

@end

@implementation XJXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加所有子控制器
    [self setupAllChildViewController];
    
    // 2.设置tabBar上按钮内容
    [self setupAllTitleButton];
    
    // 3.自定义tabBar
    [self setupTabBar];
    
    self.selectedIndex = 0;
}

// 3.自定义tabBar
-(void)setupTabBar
{
    XJXTabBar *tabBar = [[XJXTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

// 在load方法中设置被选中tabBar按钮的文字颜色,默认为蓝色,这里我们改为黑色
// +load 方法会在加载类的时候就被调用, ios 应用启动的时候，就会加载所有的类，就会调用每个类的+load方法。
+(void)load
{
    // 获取整个应用程序的UITabBarItem
    /*
     appearance
     1.只要遵守了UIAppearance,还要实现这个方法
     2.哪些属性可以通过appearance设置,只有被UI_APPEARANCE_SELECTOR宏修饰的属性,才能设置
     3.appearance:只能在控件显示之前设置,才有作用
     */
    // UITabBarItem *item = [UITabBarItem appearance];
    
    // 获取某个类中的UITabBarItem
    NSArray *arrClass = [NSArray arrayWithObjects:self, nil];
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:arrClass];
    // 这里可以设置按钮选中标题的颜色,富文本:描述一个文字颜色,阴影,空心,图文编辑,图文混排
    NSMutableDictionary *attrM = [NSMutableDictionary dictionary];
    attrM[NSForegroundColorAttributeName] = [UIColor blackColor];
    // 选中状态下,文字为黑色
    [item setTitleTextAttributes:attrM forState:UIControlStateSelected];
    
    // 设置字体大小,只有设置正常状态下才有效,所以这里需重新定义一个字典
    NSMutableDictionary *attrFont = [NSMutableDictionary dictionary];
    attrFont[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [item setTitleTextAttributes:attrFont forState:UIControlStateNormal];
}

// 2.设置tabBar上按钮内容
-(void)setupAllTitleButton
{
    // 精华
    [self setupOneTitleButton:0 image:[UIImage imageNamed:@"tabBar_essence_icon"] selectedImage:[UIImage imageOriginalWithName:@"tabBar_essence_click_icon"]  title:@"精华"];
    
    // 新帖
    [self setupOneTitleButton:1 image:[UIImage imageNamed:@"tabBar_new_icon"] selectedImage:[UIImage imageOriginalWithName:@"tabBar_new_click_icon"] title:@"新帖"];
    
    // 关注
    [self setupOneTitleButton:2 image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectedImage:[UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"] title:@"关注"];
    
    // 我
    [self setupOneTitleButton:3 image:[UIImage imageNamed:@"tabBar_me_icon"] selectedImage:[UIImage imageOriginalWithName:@"tabBar_me_click_icon"] title:@"我"];
}

// 设置一个tabBar按钮
-(void)setupOneTitleButton: (NSInteger)i image:(UIImage*)image selectedImage:(UIImage*)selectedImage title:(NSString *)title
{
    XJXNavigationController *nav = self.childViewControllers[i];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = image;
    nav.tabBarItem.selectedImage = selectedImage;

}


// 1.添加所有子控制器
-(void)setupAllChildViewController
{
    // 2.1 添加子控制器(5个子控制器) -> 自定义控制器 -> 划分项目文件结构
    // 精华
    XJXEssenceViewController *essenceVC = [[XJXEssenceViewController alloc] init];
    XJXNavigationController *nav = [[XJXNavigationController alloc] initWithRootViewController:essenceVC];
    // initWithRootViewController : push
    // tabBarVC : 会把第0个控制器的view添加上去
    [self addChildViewController:nav];
    // 新帖
    XJXNewViewController *newVC = [[XJXNewViewController alloc] init];
    XJXNavigationController *nav1 = [[XJXNavigationController alloc] initWithRootViewController:newVC];
    [self addChildViewController:nav1];
    //    // 发布
    //    XJXPublishViewController *publishVC = [[XJXPublishViewController alloc] init];
    //    [self addChildViewController:publishVC];
    // 关注
    XJXFriendTrendViewController *friendTrendVC = [[XJXFriendTrendViewController alloc] init];
    XJXNavigationController *nav3 = [[XJXNavigationController alloc] initWithRootViewController:friendTrendVC];
    [self addChildViewController:nav3];
    // 我 从storyboard中加载控制器
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([XJXMeViewController class]) bundle:nil];
    // 加载箭头指向的控制器
    XJXMeViewController *meVC = [storyboard instantiateInitialViewController];
    XJXNavigationController *nav4 = [[XJXNavigationController alloc] initWithRootViewController:meVC];
    [self addChildViewController:nav4];
    
}

@end
