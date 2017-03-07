//
//  BSNewViewController.m
//  01-BuDeJie
//
//  Created by yz on 15/12/15.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSNewViewController.h"

#import "UIBarButtonItem+Item.h"

#import "BSSubTagViewController.h"

@interface BSNewViewController ()

@end

@implementation BSNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    // titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 导航栏左边的内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] targer:self action:@selector(tagClick)];
    

}

/**
 * 左上角按钮点击
 */
- (void)tagClick
{
    
    BSSubTagViewController *subTagVc = [[BSSubTagViewController alloc] init];
    
    [self.navigationController pushViewController:subTagVc animated:YES];
    
}

@end