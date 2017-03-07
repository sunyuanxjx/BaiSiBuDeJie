//
//  BSFriendTrendsViewController.m
//  01-BuDeJie
//
//  Created by yz on 15/12/15.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSFriendTrendsViewController.h"


#import "UIBarButtonItem+Item.h"

@interface BSFriendTrendsViewController ()

@end

@implementation BSFriendTrendsViewController

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
