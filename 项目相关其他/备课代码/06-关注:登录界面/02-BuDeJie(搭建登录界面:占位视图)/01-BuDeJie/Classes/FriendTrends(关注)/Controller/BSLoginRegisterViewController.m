//
//  BSLoginRegisterViewController.m
//  01-BuDeJie
//
//  Created by yz on 15/12/16.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSLoginRegisterViewController.h"

/*
    1.分析整个结构，上面，输入框，快速登录
    2.划分整体结构，然后在给分别给对应的结构添加子控件.
 
 */

@interface BSLoginRegisterViewController ()

@end

@implementation BSLoginRegisterViewController
// 点击关闭
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 点击注册账号
- (IBAction)registerBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


@end
