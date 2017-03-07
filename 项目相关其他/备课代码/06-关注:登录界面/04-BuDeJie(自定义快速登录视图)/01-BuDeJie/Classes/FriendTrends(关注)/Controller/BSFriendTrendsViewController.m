
//
//  BSFriendTrendsViewController.m
//  01-BuDeJie
//
//  Created by yz on 15/12/15.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSFriendTrendsViewController.h"


#import "UIBarButtonItem+Item.h"

#import "BSLoginRegisterViewController.h"


@interface BSFriendTrendsViewController ()

@end

@implementation BSFriendTrendsViewController


- (IBAction)loginOrRegister:(id)sender {
    
    // 登录或者注册
    BSLoginRegisterViewController *loginVc = [[BSLoginRegisterViewController alloc] init];
    
    [self presentViewController:loginVc animated:YES completion:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    [self setUpNavBar];
}


// 设置导航条
- (void)setUpNavBar
{
    // left
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] targer:nil action:nil];
    
    // titleView
    self.navigationItem.title = @"我的关注";
    
}


@end
